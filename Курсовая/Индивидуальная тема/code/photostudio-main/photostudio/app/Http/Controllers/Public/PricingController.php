<?php
 
namespace App\Http\Controllers\Public;
 
use App\Http\Controllers\Controller;
use App\Models\Service;
use Inertia\Inertia;
use Inertia\Response;
 
class PricingController extends Controller
{
    public function __invoke(): Response
    {
        $services = Service::query()
            ->where('is_active', true)
            ->with([
                'tariffs' => function ($query) {
                    $query
                        ->where('is_active', true)
                        ->orderBy('sort_order')
                        ->orderBy('id');
                },
            ])
            ->orderBy('sort_order')
            ->orderBy('id')
            ->get([
                'id',
                'title',
                'slug',
                'short_description',
            ]);
 
        return Inertia::render('pricing', [
            'services' => $services->map(function ($service) {
                return [
                    'id' => $service->id,
                    'title' => $service->title,
                    'slug' => $service->slug,
                    'short_description' => $service->short_description,
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
                ];
            }),
        ]);
    }
}