<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ExamBody;
use App\Models\Exam;
use RalphJSmit\Laravel\SEO\Support\SEOData;
use Illuminate\Support\Facades\Cache;

class TimetableController extends Controller
{     
    /**
     * Display a listing of the Exams Timetables.
     */
    public function index()
    {
        // Cache the exam bodies with their exams for 60 minutes
        $examBodies = Cache::remember('timetable_exam_bodies_with_exams', 60 * 60, function () {
			//load on ExamBodies with Exam
            return ExamBody::whereHas('exams.timetables')->with(['exams' => function($query){
				//load only Exams with timetable
				$query->whereHas('timetables')
				->with('timetables')
				->orderBy('year', 'desc')
                ->orderBy('month', 'desc');
			}])->get();
			
        });
		
		
		$SEOData = new SEOData(
            title: "Exam Timetables",
            description: "Find the latest timetables for all major exams like WAEC, NECO, and NABTEB.",
        );

        return view('timetable.index', compact('examBodies','SEOData'));  
    }

    /**
     * Display a Timetable.
     */
    public function show(Exam $exam)
    {
		
		// Check if the exam has timetables
		if (!$exam->timetables()->exists()) {
			abort(404, 'Timetable not found for this exam.');
		}
		
		
		
        // Cache the timetables grouped by exam date for 60 minutes
		$groupedTimetables = Cache::remember("timetables_grouped_by_exam_date_{$exam->id}", 60 * 60, function () use ($exam) {
			return $exam->timetables()->get()
			->groupBy(function ($timetable) {
				// Extract the date part from start_time
				return \Carbon\Carbon::parse($timetable->start_time)->toDateString();
			});
		})
		->sortKeys()
		->map(function($group) {
			  return $group->sortBy('start_time');
		});
		
		
		$SEOData = new SEOData(
            title: "Timetable | {$exam->name}",
            description: "Timetable for {$exam->name} for private candidates. Check full subject schedules and exam dates now!",
        );
		
		$shareLinks = \Share::currentPage()
				->facebook()
				->twitter()
				->linkedin()
				->reddit()
				->whatsapp()
				->telegram()
				->getRawLinks();

        return view('timetable.show', compact('exam', 'groupedTimetables','SEOData', 'shareLinks'));     
    }
}
