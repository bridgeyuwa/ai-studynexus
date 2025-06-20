<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Timetable extends Model
{
    use HasFactory;
	
	protected $casts = [ 
	'start_time' => 'datetime',
	'end_time' => 'datetime'

	];
	
	
	
	public function exam() {
        return $this->belongsTo(Exam::class);
    }	
	
}
