<?php

namespace App\Http\Controllers\Public;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Client;
use App\Models\Service;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response;

class BookingController extends Controller
{
    public function create(Request $request): Response
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
            ->get();

        return Inertia::render('booking/create', [
            'services' => $services->map(function ($service) {
                return [
                    'id' => $service->id,
                    'title' => $service->title,
                    'slug' => $service->slug,
                    'tariffs' => $service->tariffs->map(function ($tariff) {
                        return [
                            'id' => $tariff->id,
                            'title' => $tariff->title,
                            'price' => $tariff->price,
                        ];
                    }),
                ];
            }),
            'selectedServiceSlug' => $request->query('service'),
            'selectedTariffId' => $request->query('tariff'),
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'items' => ['required', 'array', 'min:1'],
            'items.0.service_id' => ['required', 'exists:services,id'],
            'items.*.service_id' => ['nullable', 'exists:services,id'],
            'items.*.tariff_id' => ['nullable', 'exists:tariffs,id'],

            'client_name' => ['required', 'string', 'max:255'],
            'client_phone' => ['required', 'string', 'max:255'],
            'client_email' => ['nullable', 'email', 'max:255'],
            'client_messenger' => ['nullable', 'string', 'max:255'],

            'preferred_at' => ['nullable', 'date'],
            'comment' => ['nullable', 'string', 'max:3000'],
        ]);

        $items = collect($validated['items'])
            ->filter(function ($item) {
                return !empty($item['service_id']);
            })
            ->values();

        if ($items->isEmpty()) {
            throw ValidationException::withMessages([
                'items.0.service_id' => 'Нужно выбрать хотя бы одну услугу.',
            ]);
        }

        DB::transaction(function () use ($validated, $items) {
            $client = Client::query()->updateOrCreate(
                [
                    'phone' => $validated['client_phone'],
                ],
                [
                    'name' => $validated['client_name'],
                    'email' => $validated['client_email'] ?? null,
                    'messenger' => $validated['client_messenger'] ?? null,
                ],
            );

            $booking = Booking::create([
                'client_id' => $client->id,

                // Дублируем данные клиента в заявке, чтобы заявка сохраняла историю.
                'client_name' => $validated['client_name'],
                'client_phone' => $validated['client_phone'],
                'client_email' => $validated['client_email'] ?? null,
                'client_messenger' => $validated['client_messenger'] ?? null,

                'preferred_at' => $validated['preferred_at'] ?? null,
                'comment' => $validated['comment'] ?? null,
                'status' => 'new',
            ]);

            foreach ($items as $item) {
                $booking->items()->create([
                    'service_id' => $item['service_id'],
                    'tariff_id' => $item['tariff_id'] ?? null,
                ]);
            }
        });

        return redirect()->route('booking.success');
    }

    public function success(): Response
    {
        return Inertia::render('booking/success');
    }
}