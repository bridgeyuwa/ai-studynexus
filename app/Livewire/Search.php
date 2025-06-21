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
    // Arrays to hold all available institutions, levels, and programs
    public $institutions = [];
    public $levels = [];
    public $programs = [];

    // IDs for selected institution, level, and program
    public $institution_id;
    public $level_id;
    public $program_id;

    // Output/response from LLM
    public $answer;

    // Initialize component with a list of all institutions
    public function mount()
    {
        $this->institutions = Institution::all();
    }

    // When institution is changed, update levels related to the selected institution
    public function updatedInstitutionId($value)
    {
        // Fetch levels that are associated with the selected institution via pivot table
        $this->levels = Level::whereHas('institutionPrograms', function ($q) use ($value) {
            $q->where('institution_id', $value);
        })->get();

        // Reset level and program selections
        $this->level_id = null;
        $this->programs = [];
    }

    // When level is changed, update programs related to the selected institution and level
    public function updatedLevelId($value)
    {
        // Fetch programs that match the selected institution and level via pivot table
        $this->programs = Program::whereHas('institutionPrograms', function ($q) use ($value) {
            $q->where('institution_id', $this->institution_id)
                ->where('level_id', $value);
        })->get();

        // Reset selected program
        $this->program_id = null;
    }

    // Handle form submission
    public function submit()
    {
        // Find selected institution, program, and level
        $institution = Institution::find($this->institution_id);
        $program = Program::find($this->program_id);
        $level = Level::find($this->level_id);

        // If any selection is invalid, return error message
        if (!($institution && $program && $level)) {
            $this->answer = 'Invalid selection';
            return;
        }

        // Fetch the pivot record containing requirements
        $record = InstitutionProgram::where([
            'institution_id' => $institution->id,
            'program_id' => $program->id,
            'level_id' => $level->id
        ])->first();

        // If no matching record is found, return error message
        if (!$record) {
            $this->answer = 'No record found';
            return;
        }

        // Structure data for prompt
        $structured = [
            'institution' => $institution->name,
            'program' => $program->name,
            'level' => $level->name,
            'o_level' => $record->o_level,
            'direct_entry' => $record->direct_entry,
            'utme_subjects' => $record->utme_subjects,
        ];

        // Send request to LLM API to format the response
        $response = Http::timeout(60)->post('http://localhost:11434/api/generate', [
            'model' => 'llama3.2',
            'prompt' => "Convert this JSON into a clean response using this format:\n\nInstitution: ...\nProgram: ...\nLevel: ...\n\nUTME Subjects:\n- ...\n\nO Level:\n- ...\n\nDirect Entry:\n- ...\n\nOnly return the result. No comments or extra text then summarize the output.\n\nJSON:\n" . json_encode($structured),
            'stream' => false
        ]);

        // Extract and assign the model's response
        $llm = $response->json();
        $this->answer = trim($llm['response'] ?? 'No response');
    }

    // Render the Livewire view
    public function render()
    {
        return view('livewire.search');
    }
}
