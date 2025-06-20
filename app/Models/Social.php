<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Social extends Model {

    use HasFactory;

    public function socialType() {
        return $this->belongsTo(SocialType::class);
    }

  /* public function institution() {
        return $this->belongsTo(Institution::class);
    }
	*/
	public function institution() {
        return $this->belongsTo(Institution::class);
    }

}
