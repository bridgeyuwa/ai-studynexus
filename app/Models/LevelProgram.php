<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\Pivot;


class LevelProgram extends Pivot
{
   
   protected $table = 'level_program';
	
    protected $casts = [
	'updated_at' => 'datetime',
	];
	
	


/* Added because of Nova */
	public function program() {
        return $this->belongsTo(Program::class);
    }
	
	
	public function level() {
        return $this->belongsTo(Level::class);
    }
	
   
   
   
   
}
