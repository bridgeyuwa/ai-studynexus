<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReligiousAffiliation extends Model
{
    use HasFactory;
	
	public function religiousAffiliationCategory() 
	{
        return $this->belongsTo(ReligiousAffiliationCategory::class);
    }
	
	
	public function institutions()
    {
        return $this->hasMany(Institution::class);
    }
}



