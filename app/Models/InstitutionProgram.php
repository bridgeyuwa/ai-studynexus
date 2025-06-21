<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\Pivot;

class InstitutionProgram extends Pivot
{   
    // Specify the pivot table name explicitly
    protected $table = 'institution_program';

    // Define inverse relationship: this pivot belongs to a Program
    public function program() {
        return $this->belongsTo(Program::class);
    }

    // Define inverse relationship: this pivot belongs to an Institution
    public function institution() {
        return $this->belongsTo(Institution::class);
    }

    // Define inverse relationship: this pivot belongs to a Level
    public function level() {
        return $this->belongsTo(Level::class);
    }
}
