<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Lukeraymonddowning\SelfHealingUrls\Concerns\HasSelfHealingUrls;

class ExamBody extends Model
{
    use HasFactory;
	use HasSelfHealingUrls;
	
	protected  $slug = 'abbr';
	
	public function exams() {
        return $this->hasMany(Exam::class);
    }
	
	/* public function syllabi() {
        return $this->hasMany(Syllabus::class);
    } */
	
	 public function state()
    {
        return $this->belongsTo(State::class);
    }
	
	
}
