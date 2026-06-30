<?php

namespace App\Filament\Resources\ClientBookingStatistics\Pages;

use App\Filament\Resources\ClientBookingStatistics\ClientBookingStatisticResource;
use Filament\Actions\DeleteAction;
use Filament\Resources\Pages\EditRecord;

class EditClientBookingStatistic extends EditRecord
{
    protected static string $resource = ClientBookingStatisticResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
        ];
    }
}
