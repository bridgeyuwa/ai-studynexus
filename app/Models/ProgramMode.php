<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProgramMode extends Model
{
    use HasFactory;
	
	public function institutionPrograms() {
        return $this->hasMany(InstitutionProgram::class);
    }
	
	
}
