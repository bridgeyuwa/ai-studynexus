<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Program extends Model
{
    use HasFactory;

    // Use 'id' as primary key
    protected $primaryKey = 'id';

    // 'id' is not auto-incrementing
    public $incrementing = false;

    // 'id' is of type string
    protected $keyType = 'string';

    // Each program belongs to a college
    public function college()
    {
        return $this->belongsTo(College::class);
    }

    // Many-to-many relationship with institutions via 'institution_program' pivot
    public function institutions()
    {
        return $this->belongsToMany(Institution::class, 'institution_program')->using(InstitutionProgram::class);
    }

    // Many-to-many relationship with levels via 'institution_program' pivot
    public function levels()
    {
        return $this->belongsToMany(Level::class, 'institution_program')->using(InstitutionProgram::class);
    }

    // Many-to-many relationship with levels via 'level_program' pivot (alternative relationship)
    public function __levels()
    {
        return $this->belongsToMany(Level::class, 'level_program')->using(LevelProgram::class);
    }

    // One-to-many relationship with institution_program (pivot records)
    public function institutionPrograms()
    {
        return $this->hasMany(\App\Models\InstitutionProgram::class);
    }
}
