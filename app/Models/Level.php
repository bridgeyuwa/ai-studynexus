<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Level extends Model
{
    use HasFactory;

    // Used for slug generation if applicable
    protected $slug = 'name';

    // Many-to-many relationship with Program via 'institution_program' pivot table
    public function programs()
    {
        return $this->belongsToMany(Program::class, 'institution_program')
            ->using(InstitutionProgram::class)
            ->withPivot('tuition_fee');
    }

    // Many-to-many relationship with Institution via 'institution_program' pivot table
    public function institutions()
    {
        return $this->belongsToMany(Institution::class, 'institution_program')
            ->using(InstitutionProgram::class);
    }

    // Optional separate many-to-many relationship with Program via 'level_program' pivot table
    public function __programs()
    {
        return $this->belongsToMany(Program::class, 'level_program')
            ->using(LevelProgram::class)
            ->withPivot('description', 'requirements', 'direct_entry', 'o_level', 'utme_subjects', 'duration', 'updated_at');
    }

    // One-to-many relationship: a level can have many institution_program records
    public function institutionPrograms()
    {
        return $this->hasMany(InstitutionProgram::class);
    }
}
