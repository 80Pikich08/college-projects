<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ClientBookingStatistic extends Model
{
    protected $table = 'client_booking_statistics';

    protected $fillable = [
        'client_id',
        'client_name',
        'client_phone',
        'client_email',
        'client_messenger',
        'bookings_count',
        'last_booking_at',
        'calculated_at',
    ];

    protected $casts = [
        'last_booking_at' => 'datetime',
        'calculated_at' => 'datetime',
    ];

    public function client(): BelongsTo
    {
        return $this->belongsTo(Client::class);
    }
}