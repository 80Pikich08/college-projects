<?php

namespace App\Filament\Resources\ClientBookingStatistics\Pages;

use App\Filament\Resources\ClientBookingStatistics\ClientBookingStatisticResource;
use Filament\Resources\Pages\ListRecords;

class ListClientBookingStatistics extends ListRecords
{
    protected static string $resource = ClientBookingStatisticResource::class;
}