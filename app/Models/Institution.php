<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Institution extends Model
{
    use HasFactory;

    // Use 'id' as the primary key
    protected $primaryKey = 'id';

    // Disable auto-incrementing since 'id' is a string
    public $incrementing = false;

    // Specify that the primary key is a string
    protected $keyType = 'string';

    // Used for slug generation (if applicable)
    protected $slug = 'name';

    // Define many-to-many relationship with Program via pivot table 'institution_program'
    public function programs()
    {
        return $this->belongsToMany(Program::class, 'institution_program')
            ->using(InstitutionProgram::class)
            ->withPivot(
                'level_id', 'description', 'duration', 'tuition_fee', 'requirements',
                'direct_entry', 'o_level', 'utme_subjects', 'utme_cutoff',
                'accreditation_body_id', 'accreditation_status_id',
                'accreditation_grant_date', 'accreditation_expiry_date',
                'program_mode_id', 'is_distinguished', 'remarks', 'updated_at'
            );
    }

    // Define many-to-many relationship with Level via the same pivot table
    public function levels()
    {
        return $this->belongsToMany(Level::class, 'institution_program')->using(InstitutionProgram::class);
    }

}
