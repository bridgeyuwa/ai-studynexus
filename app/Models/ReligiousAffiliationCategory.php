<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReligiousAffiliationCategory extends Model
{
    use HasFactory;
	
	public function religiousAffiliations()
    {
        return $this->hasMany(ReligiousAffiliation::class);
    }
	
}
