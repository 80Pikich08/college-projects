<?php

namespace App\Filament\Resources\ClientBookingStatistics\Schemas;

use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class ClientBookingStatisticForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('client_id')
                    ->relationship('client', 'name')
                    ->required(),
                TextInput::make('client_name')
                    ->required(),
                TextInput::make('client_phone')
                    ->tel()
                    ->required(),
                TextInput::make('client_email')
                    ->email(),
                TextInput::make('client_messenger'),
                TextInput::make('bookings_count')
                    ->required()
                    ->numeric()
                    ->default(0),
                DateTimePicker::make('last_booking_at'),
                DateTimePicker::make('calculated_at'),
            ]);
    }
}
