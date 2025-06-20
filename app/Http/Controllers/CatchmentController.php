<?php

namespace App\Http\Controllers;

use App\Models\Catchment;
use App\Models\Region;
use Illuminate\Http\Request;
use RalphJSmit\Laravel\SEO\Support\SEOData;
use Illuminate\Support\Facades\Cache;

class CatchmentController extends Controller
{ 
    public function index()
    {
        // Cache the regions and their catchments with institutions
        $regions = Cache::remember('regions_with_catchments', 24 * 60 * 60, function () {
            return Region::with('catchments.institutions')->get();
        });

        $SEOData = new SEOData(
            title: "Universities in Nigeria by Catchment Area",
            description: "Discover universities in Nigeria based on catchment areas",
        );
		
		$shareLinks = \Share::currentPage()
				->facebook()
				->twitter()
				->linkedin()
				->reddit()
				->whatsapp()
				->telegram()
				->getRawLinks();

        return view('catchment.index', compact('regions', 'SEOData','shareLinks'));
    }

    public function show(Catchment $catchment)
    {
       
        $institutions = Cache::remember("institutions_for_catchment_{$catchment->id}", 24 * 60 * 60, function () use ($catchment) {
            return $catchment->institutions()->with(['state', 'institutionType', 'category'])->orderBy('name')->get();
        });

        $SEOData = new SEOData(
            title: "Universities with {$catchment->name} as Catchment Area",
            description: "Explore institutions within the {$catchment->name} catchment area of Nigeria. Find programs and compare institutions.",
        );
		
		$shareLinks = \Share::currentPage()
				->facebook()
				->twitter()
				->linkedin()
				->reddit()
				->whatsapp()
				->telegram()
				->getRawLinks();

        return view('catchment.show', compact('catchment', 'institutions', 'SEOData','shareLinks'));
    }

    public function policy()
    {
        $SEOData = new SEOData(
            title: "Catchment Area Policy",
            description: "Understand the policies for catchment areas for Federal Universities in Nigeria.",
        );
		
		$shareLinks = \Share::currentPage()
				->facebook()
				->twitter()
				->linkedin()
				->reddit()
				->whatsapp()
				->telegram()
				->getRawLinks();

        return view('catchment.policy', compact('SEOData','shareLinks'));
    }
}
