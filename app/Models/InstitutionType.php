<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InstitutionType extends Model
{
    use HasFactory;
    
      public function institutions()
    {
        return $this->hasMany(Institution::class);
    }
    
	
	public function institutionTypeCategory() 
	{
        return $this->belongsTo(InstitutionTypeCategory::class);
    }
	
}
