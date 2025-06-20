<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Institution extends Model
{

    use HasFactory;


    protected  $primaryKey = 'id';
    public  $incrementing = false;
    protected  $keyType = 'string';

    protected  $slug = 'name';



    public function programs()
    {
        return $this->belongsToMany(Program::class, 'institution_program')->using(InstitutionProgram::class)->withPivot('level_id', 'description', 'duration', 'tuition_fee', 'requirements', 'direct_entry', 'o_level', 'utme_subjects', 'utme_cutoff', 'accreditation_body_id', 'accreditation_status_id', 'accreditation_grant_date', 'accreditation_expiry_date', 'program_mode_id', 'is_distinguished', 'remarks', 'updated_at');
    }

    public function levels()
    {
        return $this->belongsToMany(Level::class, 'institution_program')->using(InstitutionProgram::class);
    }

    public function state()
    {
        return $this->belongsTo(State::class);
    }

    public function regions()
    {
        return $this->hasOneThrough(Region::class, State::class);
    }


    public function institutionType()
    {
        return $this->belongsTo(InstitutionType::class);
    }

    public function term()
    {
        return $this->belongsTo(Term::class);
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function catchments()
    {
        return $this->belongsToMany(Catchment::class);
    }


    public function phoneNumbers()
    {
        return $this->hasMany(PhoneNumber::class);
    }

    public function socials()
    {
        return $this->hasMany(Social::class);
    }

    public function accreditationBody()
    {
        return $this->belongsTo(AccreditationBody::class);
    }

    public function accreditationStatus()
    {
        return $this->belongsTo(AccreditationStatus::class);
    }


    public function religiousAffiliation()
    {
        return $this->belongsTo(ReligiousAffiliation::class);
    }


    public function parentInstitution()
    {
        return $this->belongsTo(Institution::class, 'parent_id');
    }


    public function childInstitutions()
    {
        return $this->hasMany(Institution::class, 'parent_id');
    }



    public function affiliatedInstitutions()
    {
        return $this->belongsToMany(Institution::class, 'institution_institution', 'primary_institution_id', 'related_institution_id');
    }


    public function institutionHead()
    {
        return $this->belongsTo(InstitutionHead::class);
    }


    public function news()
    {
        return $this->hasMany(News::class);
    }

    public function searchableAs()
    {
        return 'institutions_index';
    }
    public function toSearchableArray()
    {
        
        return [
            'id' => $this->id,
            'name' => $this->name,
            'state' => optional($this->state)->name,
            'programs' => $this->programs ? $this->programs->pluck('name')->implode(', ') : null,
            'abbr' => (string) $this->abbr,
            //'rank' => (int) $this->rank,
            'rank' => $this->rank !== null ? (int) $this->rank : 999999,
            'category' => optional($this->category)->name,
            'categoryClass' => optional($this->category->categoryClass)->name,
            'institution_type' => optional($this->institutionType)->name,

        ];
    }
}
