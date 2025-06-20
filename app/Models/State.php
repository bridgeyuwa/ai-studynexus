<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Lukeraymonddowning\SelfHealingUrls\Concerns\HasSelfHealingUrls;

class State extends Model
{
    use HasFactory;
	use HasSelfHealingUrls;
	
	protected  $slug = 'name';
        
    public function institutions()
    {
        return $this->hasMany(Institution::class);
    }
    
    public function region()
    {
        return $this->belongsTo(Region::class);
    }
	
	public function exambodies()
    {
        return $this->hasMany(ExamBody::class);
    }
    
}
