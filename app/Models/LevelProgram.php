<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\Pivot;

class LevelProgram extends Pivot
{
    // Specify the pivot table name
    protected $table = 'level_program';

    // Cast 'updated_at' column to datetime
    protected $casts = [
        'updated_at' => 'datetime',
    ];

    // Relationship to Program model (for Nova or general use)
    public function program() {
        return $this->belongsTo(Program::class);
    }

    // Relationship to Level model (for Nova or general use)
    public function level() {
        return $this->belongsTo(Level::class);
    }
}
