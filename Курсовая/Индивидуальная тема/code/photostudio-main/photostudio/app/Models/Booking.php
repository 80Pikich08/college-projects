<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Booking extends Model
{
    protected $fillable = [
        'client_id',
        'client_name',
        'client_phone',
        'client_email',
        'client_messenger',
        'preferred_at',
        'comment',
        'status',
    ];

    protected $casts = [
        'preferred_at' => 'datetime',
    ];

    public function client(): BelongsTo
    {
        return $this->belongsTo(Client::class);
    }

    public function items(): HasMany
    {
        return $this->hasMany(BookingItem::class);
    }
}