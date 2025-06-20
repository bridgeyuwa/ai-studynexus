<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Institution;
use App\Models\Program;
use App\Models\Level;
use App\Models\InstitutionProgram;
use Illuminate\Support\Facades\Http;

class AIController extends Controller
{

    public function index()
    {
        return view('welcome', [
            'institutions' => Institution::all(),
            'programs' => Program::all(),
            'levels' => Level::all(),
        ]);
    }

    public function answer(Request $request)
    {
        $institution = Institution::find($request->input('institution_id'));
        $program = Program::find($request->input('program_id'));
        $level = Level::find($request->input('level_id'));

        if (!($institution && $program && $level)) {
            return back()->with('answer', ['error' => 'Invalid selection']);
        }

        $record = InstitutionProgram::where([
            'institution_id' => $institution->id,
            'program_id' => $program->id,
            'level_id' => $level->id
        ])->first();

        //dd($record);

        if (!$record) {
            return back()->with('answer', ['error' => 'No record found']);
        }

        // Build structured JSON
        $structured = [
            'institution' => $institution->name,
            'program' => $program->name,
            'level' => $level->name,
            'o_level' => $record->o_level,
            'direct_entry' => $record->direct_entry,
            'utme_subjects' => $record->utme_subjects,
        ];

        // Send to LLM
        $response = Http::timeout(60)->post('http://localhost:11434/api/generate', [
            'model' => 'llama3.2',
            'prompt' => "Convert this JSON into a clean response using this format:\n\nInstitution: ...\nProgram: ...\nLevel: ...\n\nUTME Subjects:\n- ...\n\nO Level:\n- ...\n\nDirect Entry:\n- ...\n\nOnly return the result. No comments or extra text.\n\nJSON:\n" . json_encode($structured),
            'stream' => false
        ]);

        $llm = $response->json();
        $final = trim($llm['response'] ?? '');

        return back()->with('answer', $final);
    }
}
