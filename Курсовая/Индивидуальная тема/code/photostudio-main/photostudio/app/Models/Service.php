<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Service extends Model
{
    protected $fillable = [
        'title',
        'slug',
        'short_description',
        'description',
        'cover_image',
        'is_active',
        'sort_order',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function tariffs(): HasMany
    {
        return $this->hasMany(Tariff::class);
    }
    
    public function bookings(): HasMany
    {
        return $this->hasMany(Booking::class);
    }
}