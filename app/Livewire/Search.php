<?php

namespace App\Livewire;

use Livewire\Component;
use App\Models\Institution;
use App\Models\Level;
use App\Models\Program;
use App\Models\InstitutionProgram;
use Illuminate\Support\Facades\Http;

class Search extends Component
{
    public $institutions = [];
    public $levels = [];
    public $programs = [];

    public $institution_id;
    public $level_id;
    public $program_id;
    public $answer;

    public function mount()
    {
        $this->institutions = Institution::all();
    }

    public function updatedInstitutionId($value)
    {
        $this->levels = Level::whereHas('institutionPrograms', function ($q) use ($value) {
            $q->where('institution_id', $value);
        })->get();

        $this->level_id = null;
        $this->programs = [];
    }

    public function updatedLevelId($value)
    {
        $this->programs = Program::whereHas('institutionPrograms', function ($q) use ($value) {
            $q->where('institution_id', $this->institution_id)
                ->where('level_id', $value);
        })->get();

        $this->program_id = null;
    }


    public function submit()
    {
        $institution = Institution::find($this->institution_id);
        $program = Program::find($this->program_id);
        $level = Level::find($this->level_id);

        if (!($institution && $program && $level)) {
            $this->answer = 'Invalid selection';
            return;
        }

        $record = InstitutionProgram::where([
            'institution_id' => $institution->id,
            'program_id' => $program->id,
            'level_id' => $level->id
        ])->first();

        if (!$record) {
            $this->answer = 'No record found';
            return;
        }

        $structured = [
            'institution' => $institution->name,
            'program' => $program->name,
            'level' => $level->name,
            'o_level' => $record->o_level,
            'direct_entry' => $record->direct_entry,
            'utme_subjects' => $record->utme_subjects,
        ];

        $response = Http::timeout(60)->post('http://localhost:11434/api/generate', [
            'model' => 'llama3.2',
            'prompt' => "Convert this JSON into a clean response using this format:\n\nInstitution: ...\nProgram: ...\nLevel: ...\n\nUTME Subjects:\n- ...\n\nO Level:\n- ...\n\nDirect Entry:\n- ...\n\nOnly return the result. No comments or extra text then summarize the output.\n\nJSON:\n" . json_encode($structured),
            'stream' => false
        ]);

        $llm = $response->json();
        $this->answer = trim($llm['response'] ?? 'No response');
    }

    public function render()
    {
        return view('livewire.search');
    }
}
