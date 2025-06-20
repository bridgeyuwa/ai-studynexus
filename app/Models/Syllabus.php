<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Lukeraymonddowning\SelfHealingUrls\Concerns\HasSelfHealingUrls;

class Syllabus extends Model
{
    use HasFactory;
	use HasSelfHealingUrls;
	
	protected  $slug = 'name';
	
	/* public function examBody() {
        return $this->belongsTo(ExamBody::class);
    } */
	
	
	public function exam() {
        return $this->belongsTo(Exam::class);
    }

}
