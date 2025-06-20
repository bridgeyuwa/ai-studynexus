<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InstitutionTypeCategory extends Model
{
    use HasFactory;
	
	  public function institutionTypes()
    {
        return $this->hasMany(InstitutionType::class);
    }
    
	
}
