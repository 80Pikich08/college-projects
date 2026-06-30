<?php

namespace App\Http\Controllers\Public;

use App\Http\Controllers\Controller;
use App\Models\Service;
use Inertia\Inertia;
use Inertia\Response;

class ServiceController extends Controller
{
    public function show(Service $service): Response
    {
        abort_unless($service->is_active, 404);

        $service->load([
            'tariffs' => function ($query) {
                $query
                    ->where('is_active', true)
                    ->orderBy('sort_order')
                    ->orderBy('id');
            },
        ]);

        return Inertia::render('services/show', [
            'service' => [
                'id' => $service->id,
                'title' => $service->title,
                'slug' => $service->slug,
                'short_description' => $service->short_description,
                'description' => $service->description,
                'cover_image' => $service->cover_image,
                'tariffs' => $service->tariffs->map(function ($tariff) {
                    return [
                        'id' => $tariff->id,
                        'title' => $tariff->title,
                        'price' => $tariff->price,
                        'old_price' => $tariff->old_price,
                        'duration_minutes' => $tariff->duration_minutes,
                        'photos_count' => $tariff->photos_count,
                        'description' => $tariff->description,
                        'features' => $tariff->features,
                        'is_popular' => $tariff->is_popular,
                    ];
                }),
            ],
        ]);
    }
}