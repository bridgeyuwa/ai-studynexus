<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Lukeraymonddowning\SelfHealingUrls\Concerns\HasSelfHealingUrls;

class NewsCategory extends Model
{
    use HasFactory;
	use HasSelfHealingUrls;
	
	protected  $slug = 'name';
	
	 public function institutions()
    {
        return $this->belongsToMany(Institution::class);
    }
	
	
	 public function news()
    {
        return $this->belongsToMany(News::class);
    }
}
