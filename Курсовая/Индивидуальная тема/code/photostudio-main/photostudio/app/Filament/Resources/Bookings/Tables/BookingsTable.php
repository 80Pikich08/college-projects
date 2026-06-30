<?php

namespace App\Filament\Resources\Bookings\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class BookingsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(function (Builder $query): Builder {
                return $query->with([
                    'client',
                    'items.service',
                    'items.tariff',
                ]);
            })
            ->columns([
                TextColumn::make('id')
                    ->label('ID')
                    ->sortable(),

                TextColumn::make('client_name')
                    ->label('Клиент')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('client_phone')
                    ->label('Телефон')
                    ->searchable(),

                TextColumn::make('items.service.title')
                    ->label('Услуги')
                    ->listWithLineBreaks()
                    ->bulleted(),

                TextColumn::make('preferred_at')
                    ->label('Желаемая дата')
                    ->dateTime('d.m.Y H:i')
                    ->sortable(),

                TextColumn::make('status')
                    ->label('Статус')
                    ->badge()
                    ->formatStateUsing(function (string $state): string {
                        return match ($state) {
                            'new' => 'Новая',
                            'contacted' => 'Связались',
                            'confirmed' => 'Подтверждена',
                            'completed' => 'Завершена',
                            'cancelled' => 'Отменена',
                            default => $state,
                        };
                    }),

                TextColumn::make('created_at')
                    ->label('Создана')
                    ->dateTime('d.m.Y H:i')
                    ->sortable(),
            ])
            ->filters([
                SelectFilter::make('status')
                    ->label('Статус')
                    ->options([
                        'new' => 'Новая',
                        'contacted' => 'Связались',
                        'confirmed' => 'Подтверждена',
                        'completed' => 'Завершена',
                        'cancelled' => 'Отменена',
                    ]),
            ])
            ->recordActions([
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
    }
}
