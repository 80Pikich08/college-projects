<?php
 
use App\Http\Controllers\Public\AboutController;
use App\Http\Controllers\Public\BookingController;
use App\Http\Controllers\Public\PricingController;
use App\Http\Controllers\Public\HomeController;
use App\Http\Controllers\Public\ServiceController;
use Illuminate\Support\Facades\Route;

Route::get('/', HomeController::class)->name('home');

Route::get('/pricing', PricingController::class)->name('pricing');
 
Route::get('/services/{service:slug}', [ServiceController::class, 'show'])
    ->name('services.show');

Route::get('/booking', [BookingController::class, 'create'])
    ->name('booking.create');

Route::post('/booking', [BookingController::class, 'store'])
    ->name('booking.store');

Route::get('/booking/success', [BookingController::class, 'success'])
    ->name('booking.success');

Route::get('/about', AboutController::class)->name('about');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::inertia('dashboard', 'dashboard')->name('dashboard');
});

require __DIR__.'/settings.php';
