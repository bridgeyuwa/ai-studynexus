<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Lukeraymonddowning\SelfHealingUrls\Concerns\HasSelfHealingUrls;

class Exam extends Model
{
    use HasFactory;
	use HasSelfHealingUrls;
	
	protected  $slug = 'name';
	
	public function examBody() {
        return $this->belongsTo(ExamBody::class);
    }
	
	public function timetables() {
        return $this->hasMany(Timetable::class);
    }
	
	public function syllabi() {
        return $this->hasMany(Syllabus::class);
    }
}
