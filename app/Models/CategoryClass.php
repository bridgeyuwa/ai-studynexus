<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Lukeraymonddowning\SelfHealingUrls\Concerns\HasSelfHealingUrls;

class CategoryClass extends Model
{
    use HasFactory;
	use HasSelfHealingUrls;
	
	protected  $slug = 'name';
	
	public function categories()
    {
        return $this->hasMany(Category::class);
    }
	
	
	public function institutions()
    {
        return $this->hasManyThrough(Institution::class, Category::class);
    }
	
}
