<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\News;
use App\Models\Institution;
use App\Models\NewsCategory;
use RalphJSmit\Laravel\SEO\Support\SEOData;
use Illuminate\Support\Facades\Cache;

class NewsController extends Controller
{
    public function index()
    {
        // Cache the paginated news items
        $news = Cache::remember('news_index_page_'. request('page', 1), 15 * 60, function () {
            $newsItems = News::with(['newsCategories', 'institution'])->orderBy('created_at', 'desc')->paginate(10);
            $newsItems->getCollection()->transform(function ($newsItem) {
                $newsItem->readTime = $this->readTime($newsItem->content);
                return $newsItem;
            });
            return $newsItems;
        });

        // Cache the news categories with count
        $newsCategories = Cache::remember('news_categories_index', 60 * 60, function () {
            return NewsCategory::withCount('news')->orderBy('news_count', 'desc')->take(25)->get();
        });
		
		
		$SEOData = new SEOData(
            title: "Latest Education News",
            description: "Stay updated with the latest education news in Nigeria.",
        );
		
		
        return view('news.index', compact('news', 'newsCategories','SEOData'));
    }

    public function indexByInstitution(Institution $institution)
    {
        $news = Cache::remember("news_index_institution_{$institution->id}", 15 * 60, function () use ($institution) {
            $newsItems = $institution->news()->with('newsCategories')->orderBy('created_at', 'desc')->paginate(10);
            $newsItems->getCollection()->transform(function ($newsItem) {
                $newsItem->readTime = $this->readTime($newsItem->content);
                return $newsItem;
            });
            $newsItems->load(['institution']);
            return $newsItems;
        });

        $newsCategories = Cache::remember('news_categories_index_institution', 60 * 60, function () {
            return NewsCategory::withCount('news')->orderBy('news_count', 'desc')->take(25)->get();
        });
		
		
		$SEOData = new SEOData(
            title: "News from {$institution->name}",
            description: "Latest news updates from {$institution->name}.",
        );

        return view('news.index', compact('institution', 'news', 'newsCategories','SEOData'));
    }
	

    public function indexByNewsCategory(NewsCategory $newsCategory)
    {
        $news = Cache::remember("news_index_category_{$newsCategory->id}", 15 * 60, function () use ($newsCategory) {
            $newsItems = $newsCategory->news()->with('newsCategories')->orderBy('created_at', 'desc')->paginate(10);
            $newsItems->getCollection()->transform(function ($newsItem) {
                $newsItem->readTime = $this->readTime($newsItem->content);
                return $newsItem;
            });
            $newsItems->load(['institution']);
            return $newsItems;
        });

        $newsCategories = Cache::remember('news_categories_index_category', 60 * 60, function () {
            return NewsCategory::withCount('news')->orderBy('news_count', 'desc')->take(25)->get();
        });
		
		
		$SEOData = new SEOData(
            title: "News in {$newsCategory->name} Category",
            description: "Browse news articles in the {$newsCategory->name} category.",
        );

        return view('news.index', compact('newsCategory', 'news', 'newsCategories','SEOData'));
    }
	
	
					
	public function indexOfNewsCategories()
    {
		
		
		$newsCategories = Cache::remember('news_categories', 60 * 60, function () {
			return NewsCategory::all()->groupBy(function($newsCategory) {
				return strtoupper(substr($newsCategory->name, 0, 1));
			})->sortKeys()
			->map(function($group) {
				return $group->sortBy('name');
			});
		});
				
		
		$SEOData = new SEOData(
            title: "All News Categories",
            description: "Comprehensive list of all news categories in alphabetical order",
        );
		
		return view('news.news-categories', compact( 'newsCategories','SEOData'));
	}

   
	
	
	public function show(News $news) 
	{
		$news->readTime = $this->readTime($news->content);
		
		$SEOData = new SEOData(
			title: $news->title,
			description: $news->excerpt,
		);

		$newsCategoryIds = $news->newsCategories->pluck('id')->toArray();

		// Cache similar news
		$cacheKey = 'similar_news_' . $news->id;
		$similarNews = Cache::remember($cacheKey, 60 * 60, function () use ($news, $newsCategoryIds) {
			return News::whereHas('newsCategories', function($query) use ($newsCategoryIds) {
				$query->whereIn('news_categories.id', $newsCategoryIds);
			})
			->where('id', '!=', $news->id)
			->withCount(['newsCategories' => function($query) use ($newsCategoryIds) {
				$query->whereIn('news_categories.id', $newsCategoryIds);
			}])
			->with(['institution', 'newsCategories'])
			->orderBy('news_categories_count', 'desc')
			->when($news->institution_id, function ($query) use ($news) {
				$query->orderByRaw('institution_id = ? DESC', [$news->institution_id]);
			})
			->orderBy('created_at', 'desc')
			->take(5)
			->get();
		});

		$shareLinks = \Share::currentPage()
				->facebook()
				->twitter()
				->linkedin()
				->reddit()
				->whatsapp()
				->telegram()
				->getRawLinks();
		
		return view('news.show', compact('news', 'similarNews', 'SEOData', 'shareLinks'));
	}

	
	
	

    public function showByInstitution(Institution $institution, News $news) 
    {
        if ($news->institution_id !== $institution->id) {
            abort(404);
        }

        $news->readTime = $this->readTime($news->content);
		
		$SEOData = new SEOData(
            title: $news->title,
            description: $news->excerpt,
        );
		
		
		$newsCategoryIds = $news->newsCategories->pluck('id')->toArray();

		// Cache similar news
		$cacheKey = 'similar_news_' . $news->id;
		$similarNews = Cache::remember($cacheKey, 60 * 60, function () use ($news, $newsCategoryIds) {
			return News::whereHas('newsCategories', function($query) use ($newsCategoryIds) {
				$query->whereIn('news_categories.id', $newsCategoryIds);
			})
			->where('id', '!=', $news->id)
			->withCount(['newsCategories' => function($query) use ($newsCategoryIds) {
				$query->whereIn('news_categories.id', $newsCategoryIds);
			}])
			->with(['institution', 'newsCategories'])
			->orderBy('news_categories_count', 'desc')
			->when($news->institution_id, function ($query) use ($news) {
				$query->orderByRaw('institution_id = ? DESC', [$news->institution_id]);
			})
			->orderBy('created_at', 'desc')
			->take(5)
			->get();
		});		
		
		
		$canonical = route('news.show', ['news' => $news]);
		
		$shareLinks = \Share::currentPage()
				->facebook()
				->reddit()
				->twitter()
				->linkedin()
				->whatsapp()
				->telegram()
				->getRawLinks();
		
        return view('news.show', compact('news','SEOData', 'similarNews','canonical','shareLinks'));
    }

    public function showByNewsCategory(NewsCategory $newsCategory, News $news)
    {
        if (!$newsCategory->news->contains($news->id)) {
            abort(404);
        }

        $news->readTime = $this->readTime($news->content);
		
		$SEOData = new SEOData(
            title: $news->title,
            description: $news->excerpt,
        );
		
		
		$newsCategoryIds = $news->newsCategories->pluck('id')->toArray();

		// Cache similar news
		$cacheKey = 'similar_news_' . $news->id;
		$similarNews = Cache::remember($cacheKey, 60 * 60, function () use ($news, $newsCategoryIds) {
			return News::whereHas('newsCategories', function($query) use ($newsCategoryIds) {
				$query->whereIn('news_categories.id', $newsCategoryIds);
			})
			->where('id', '!=', $news->id)
			->withCount(['newsCategories' => function($query) use ($newsCategoryIds) {
				$query->whereIn('news_categories.id', $newsCategoryIds);
			}])
			->with(['institution', 'newsCategories'])
			->orderBy('news_categories_count', 'desc')
			->when($news->institution_id, function ($query) use ($news) {
				$query->orderByRaw('institution_id = ? DESC', [$news->institution_id]);
			})
			->orderBy('created_at', 'desc')
			->take(5)
			->get();
		});
			
		
		$canonical = route('news.show', ['news' => $news]);
		
		$shareLinks = \Share::currentPage()
				->facebook()
				->twitter()
				->linkedin()
				->reddit()
				->whatsapp()
				->telegram()
				->getRawLinks();
		
        return view('news.show', compact('newsCategory', 'news','SEOData', 'similarNews', 'canonical','shareLinks'));
    }

    protected function readTime($content)
    {
        $content = str_word_count(strip_tags($content));
        $minutes = ceil($content / 200);
        return $minutes;
    }
}
