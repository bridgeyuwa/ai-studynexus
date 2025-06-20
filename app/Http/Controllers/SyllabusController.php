<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Syllabus;
use App\Models\ExamBody;
use App\Models\Exam;
use App\Models\Subject;
use RalphJSmit\Laravel\SEO\Support\SEOData;
use Illuminate\Support\Facades\Cache;

class SyllabusController extends Controller
{
    public function index()
    {
      
		$examBodies = Cache::remember('syllabus_exam_bodies_with_exams', 60 * 60, function () {
			//load on ExamBodies with Exam
            return ExamBody::whereHas('exams.syllabi')->with(['exams' => function($query){
				//load only Exams with Syllabus
				$query->whereHas('syllabi')
				->orderBy('year', 'desc')
                ->orderBy('month', 'desc');
			}])->get();
			
        });
	
		$SEOData = new SEOData(
            title: "Exam Syllabi",
            description: "Explore syllabi for various exams like WAEC, NECO, and more.",
        );
        
        return view('syllabus.index', compact('examBodies','SEOData'));  
    }
    
    public function syllabi(Exam $exam)
    {
        // Cache the syllabi and related subjects for the specific exam body
        $syllabi = Cache::remember("syllabi_exam_{$exam->id}", 60 * 60, function () use ($exam) {
            return $exam->syllabi()->orderBy('name')->get();
        });
		
		$SEOData = new SEOData(
            title: "{$exam->abbr} Syllabus",
            description: "Browse the latest syllabus for {$exam->abbr} exams.",
        );
		
		//dd($exam);
		
		
		$shareLinks = \Share::currentPage()
				->facebook()
				->twitter()
				->linkedin()
				->reddit()
				->whatsapp()
				->telegram()
				->getRawLinks();

        return view('syllabus.syllabus', compact('exam', 'syllabi','SEOData', 'shareLinks'));  
    }
    
    public function show(Exam $exam, Syllabus $syllabus)
    {
        if ($syllabus->exam_id !== $exam->id) {
            abort(404, 'Syllabus not found for this exam.');
        }
		
		$SEOData = new SEOData(
            title: "{$syllabus->subject} Syllabus - {$exam->abbr}",
            description: "Official syllabus for {$syllabus->subject} - {$exam->abbr}.",
        );
		//dd($syllabus->name);
		$shareLinks = \Share::currentPage()
				->facebook()
				->twitter()
				->linkedin()
				->reddit()
				->whatsapp()
				->telegram()
				->getRawLinks();

        return view('syllabus.show', compact('exam', 'syllabus','SEOData', 'shareLinks'));     
    }
}
