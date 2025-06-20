<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Level extends Model
{
    use HasFactory;

    protected  $slug = 'name';

    public function programs()
    {
        return $this->belongsToMany(Program::class, 'institution_program')->using(InstitutionProgram::class)->withPivot('tuition_fee');
    }


    public function institutions()
    {
        return $this->belongsToMany(Institution::class, 'institution_program')->using(InstitutionProgram::class);
    }



    // for level_programs relationship
    public function __programs()
    {
        return $this->belongsToMany(Program::class, 'level_program')->using(LevelProgram::class)->withPivot('description', 'requirements', 'direct_entry', 'o_level', 'utme_subjects', 'duration', 'updated_at');
    }

    public function institutionPrograms()
    {
        return $this->hasMany(InstitutionProgram::class);
    }
}
