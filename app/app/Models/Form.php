<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Form extends Model
{
    use HasFactory;
    protected $fillable = ['language_id', 'name', 'vendor_id', 'type', 'status'];

    public function language()
    {
        return $this->belongsTo(Language::class, 'language_id', 'id');
    }
    public function vendor()
    {
        return $this->belongsTo(Vendor::class, 'vendor_id', 'id');
    }

    public function input()
    {
        return $this->hasMany(FormInput::class, 'form_id', 'id');
    }
}
