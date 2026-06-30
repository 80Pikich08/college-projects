<?php

namespace App\Filament\Resources\Tariffs\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;

class TariffForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('service_id')
                    ->relationship('service', 'title')
                    ->required(),
                TextInput::make('title')
                    ->required(),
                TextInput::make('price')
                    ->required()
                    ->numeric()
                    ->prefix('$'),
                TextInput::make('old_price')
                    ->numeric()
                    ->prefix('$'),
                TextInput::make('duration_minutes')
                    ->numeric(),
                TextInput::make('photos_count')
                    ->numeric(),
                Textarea::make('description')
                    ->columnSpanFull(),
                Textarea::make('features')
                    ->columnSpanFull(),
                Toggle::make('is_popular')
                    ->required(),
                Toggle::make('is_active')
                    ->required(),
                TextInput::make('sort_order')
                    ->required()
                    ->numeric()
                    ->default(0),
            ]);
    }
}
