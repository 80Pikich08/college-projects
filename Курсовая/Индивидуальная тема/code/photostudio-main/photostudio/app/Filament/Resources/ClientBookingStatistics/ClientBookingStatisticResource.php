<?php

namespace App\Filament\Resources\ClientBookingStatistics;

use App\Filament\Resources\ClientBookingStatistics\Pages\ListClientBookingStatistics;
use App\Filament\Resources\ClientBookingStatistics\Tables\ClientBookingStatisticsTable;
use App\Models\ClientBookingStatistic;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class ClientBookingStatisticResource extends Resource
{
    protected static ?string $model = ClientBookingStatistic::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedChartBar;

    protected static ?string $recordTitleAttribute = 'client_name';

    protected static ?string $navigationLabel = 'Статистика клиентов';

    protected static ?string $modelLabel = 'Статистика клиента';

    protected static ?string $pluralModelLabel = 'Статистика клиентов';

    protected static ?int $navigationSort = 30;

    public static function table(Table $table): Table
    {
        return ClientBookingStatisticsTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListClientBookingStatistics::route('/'),
        ];
    }
}