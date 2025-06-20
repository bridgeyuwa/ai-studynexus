<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Institution;
use App\Models\State;
use App\Models\Program;
use App\Models\Level;
use App\Models\CategoryClass;
use App\Models\ReligiousAffiliationCategory;
use RalphJSmit\Laravel\SEO\Support\SEOData;
use Illuminate\Support\Facades\Cache;

class SearchController extends Controller
{
    public function index(Request $request)
    {
        $stateId = $request->input('location');
        $levelId = $request->input('level');
        $programId = $request->input('program');
        $typeSlug = $request->input('type');
        $categoryClassId = $request->input('category');
        $religionId = $request->input('religion');
        $sortBy = $request->input('sort');
		
		
		$state = $stateId ? State::find($stateId) : null;
        $level = $levelId ? Level::find($levelId) : null;
		$program = $programId ? Program::find($programId) : null;
		$typeSlug = in_array($typeSlug, ['public', 'federal', 'state','private','']) ? $typeSlug : '';
		$categoryClass = $categoryClassId ? CategoryClass::find($categoryClassId) : null;
		$religiousAffiliationCategory = $religionId ? ReligiousAffiliationCategory::find($religionId) : null;
        $sortBy = in_array($sortBy, ['rank', 'za', '']) ? $sortBy : '';
		
		$sortOrder = match ($sortBy) {
			'rank' => 'Rank',
			'za' => 'Z - A',
			default => 'A - Z',
		};
		
		
		
		
		$cacheKey = 'search_' 
    . 'location_' . ($stateId ?? 'null') 
    . '_level_' . ($levelId ?? 'null') 
    . '_program_' . ($programId ?? 'null') 
    . '_type_' . ($typeSlug ?? 'null') 
    . '_category_' . ($categoryClassId ?? 'null') 
    . '_religion_' . ($religionId ?? 'null') 
    . '_sort_' . ($sortBy ?? 'null')
	. request('page', 1);
		
	 $institutions = Cache::remember($cacheKey, 60 * 60, function () use ($request, $state, $level, $program, $typeSlug, $categoryClass, $religiousAffiliationCategory, $sortBy) {
       	
        $query = Institution::query();

        // Institution Type filter
        if ($typeSlug) {
            if ($typeSlug == "public") {
                $query->whereHas('institutionType.institutionTypeCategory', function ($q) use ($typeSlug) {
                    $q->where('slug', $typeSlug);
                });
            } elseif($typeSlug == "federal" || $typeSlug == "state" || $typeSlug == "private") {
                $query->whereHas('institutionType', function ($q) use ($typeSlug) {
                    $q->where('slug', $typeSlug);
                });
            }
			
        }

		
		// Categories Filter
         if ($categoryClass) {
            $query->whereHas('category.categoryClass', function ($q) use ($categoryClass) {
                $q->where('id', $categoryClass->id);
            });
        }
		


        // Religious Affiliation Filter
        if ($religiousAffiliationCategory) {
            $query->whereHas('religiousAffiliation.religiousAffiliationCategory', function ($q) use ($religiousAffiliationCategory) {
                $q->where('id', $religiousAffiliationCategory->id);
            });
        }

        // State Filter
       if ($state) {
            $query->where('state_id', $state->id);
        }

        // Level Filter
         if ($level) {
            $query->whereHas('levels', function ($q) use ($level) {
                $q->where('levels.id', $level->id);
            });
        }

        // Program Filter
        if ($program) {
            $query->whereHas('programs', function ($q) use ($program) {
                $q->where('programs.id', $program->id);
            });
        }
		
		
		//eager load the program levels  when only program is selected
		if(empty($level) && !empty($program)){
			
			$query->with([
					'levels' => function ($q) use ($program) {
						$q->wherePivot('program_id', $program->id);
					}
				]);	
			//dd();	
		}
		
		
		if( empty($level) || empty($program) ){
			 $query->with([
				'programs' => function ($q) use ($program, $level) {
						if ($program) {
							$q->where('program_id', $program->id);
							if ($level) {
								$q->whereHas('levels', function ($q) use ($level) {
									$q->where('levels.id', $level->id);
								});
							}
						}
					}
			 ]);
		}

        // Eager Load common Relationships
        $query->with([
            'state:id,name,is_state,code',
            'institutionType:id,name',
            'category:id,name'
            
        ]);
		
		//eagerload  when Level OR program is not available to load programs for tuition computation
		
		
        // Sorting
        
		
		if ($sortBy === "rank") {
			$query->orderByRaw('rank IS NULL, rank');
		} elseif ($sortBy === "za") {
			$query->orderBy('name', 'desc');
		} else {
			$query->orderBy('name', 'asc');
		}

		

        return $query->paginate(30)->appends($request->except('page'));
	
	 });	
		
		
		
        $SEOData = new SEOData(
            title: "Search Nigerian Academic Institutions and Programs",
            description: "Use our advanced search to find universities, polytechnics, monotechnics, colleges of education, etc., and course programs in Nigeria that match your criteria. Filter by location, study level, programme, institution category and more.",
        );

        return view('search', compact('institutions', 'program', 'state', 'level','typeSlug','categoryClass','religiousAffiliationCategory','sortOrder', 'SEOData'));
    }
}
