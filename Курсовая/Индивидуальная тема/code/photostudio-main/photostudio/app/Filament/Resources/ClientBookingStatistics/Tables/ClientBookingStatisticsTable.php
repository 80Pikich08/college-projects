<?php

namespace App\Filament\Resources\ClientBookingStatistics\Tables;

use Filament\Actions\Action;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Illuminate\Support\Facades\DB;

class ClientBookingStatisticsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('client_name')
                    ->label('Клиент')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('client_phone')
                    ->label('Телефон')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('client_email')
                    ->label('Email')
                    ->searchable(),

                TextColumn::make('client_messenger')
                    ->label('Telegram / WhatsApp')
                    ->searchable(),

                TextColumn::make('bookings_count')
                    ->label('Кол-во заявок')
                    ->badge()
                    ->sortable(),

                TextColumn::make('last_booking_at')
                    ->label('Последняя заявка')
                    ->dateTime('d.m.Y H:i')
                    ->sortable(),

                TextColumn::make('calculated_at')
                    ->label('Обновлено')
                    ->dateTime('d.m.Y H:i')
                    ->sortable(),
            ])
            ->headerActions([
                Action::make('refresh_statistics')
                    ->label('Обновить статистику')
                    ->icon('heroicon-o-arrow-path')
                    ->requiresConfirmation()
                    ->action(function (): void {
                        DB::statement('CALL refresh_client_booking_statistics(NULL)');
                    })
                    ->successNotificationTitle('Статистика обновлена'),
            ])
            ->defaultSort('bookings_count', 'desc');
    }
}