<?php

namespace App\Filament\Resources\Bookings\Schemas;

use App\Models\Service;
use App\Models\Tariff;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Components\Utilities\Get;
use Filament\Schemas\Components\Utilities\Set;
use Filament\Schemas\Schema;

class BookingForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Клиент')
                    ->schema([
                        Select::make('client_id')
                            ->label('Клиент')
                            ->relationship('client', 'name')
                            ->searchable()
                            ->preload(),

                        TextInput::make('client_name')
                            ->label('Имя')
                            ->required()
                            ->maxLength(255),

                        TextInput::make('client_phone')
                            ->label('Телефон')
                            ->required()
                            ->maxLength(255),

                        TextInput::make('client_email')
                            ->label('Email')
                            ->email()
                            ->maxLength(255),

                        TextInput::make('client_messenger')
                            ->label('Telegram / WhatsApp')
                            ->maxLength(255),
                    ])
                    ->columns(2),

                Section::make('Услуги в заявке')
                    ->schema([
                        Repeater::make('items')
                            ->label('Услуги')
                            ->relationship('items')
                            ->schema([
                                Select::make('service_id')
                                    ->label('Услуга')
                                    ->options(
                                        Service::query()
                                            ->where('is_active', true)
                                            ->orderBy('sort_order')
                                            ->orderBy('title')
                                            ->pluck('title', 'id')
                                            ->toArray()
                                    )
                                    ->required()
                                    ->searchable()
                                    ->preload()
                                    ->live()
                                    ->afterStateUpdated(function (Set $set): void {
                                        $set('tariff_id', null);
                                    }),

                                Select::make('tariff_id')
                                    ->label('Тариф')
                                    ->options(function (Get $get): array {
                                        $serviceId = $get('service_id');

                                        if (!$serviceId) {
                                            return [];
                                        }

                                        return Tariff::query()
                                            ->where('service_id', $serviceId)
                                            ->where('is_active', true)
                                            ->orderBy('sort_order')
                                            ->orderBy('title')
                                            ->pluck('title', 'id')
                                            ->toArray();
                                    })
                                    ->searchable()
                                    ->preload(),
                            ])
                            ->columns(2)
                            ->minItems(1)
                            ->addActionLabel('Добавить услугу'),
                    ]),

                Section::make('Детали заявки')
                    ->schema([
                        DateTimePicker::make('preferred_at')
                            ->label('Желаемая дата и время'),

                        Select::make('status')
                            ->label('Статус')
                            ->options([
                                'new' => 'Новая',
                                'contacted' => 'Связались',
                                'confirmed' => 'Подтверждена',
                                'completed' => 'Завершена',
                                'cancelled' => 'Отменена',
                            ])
                            ->default('new')
                            ->required(),

                        Textarea::make('comment')
                            ->label('Комментарий')
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}