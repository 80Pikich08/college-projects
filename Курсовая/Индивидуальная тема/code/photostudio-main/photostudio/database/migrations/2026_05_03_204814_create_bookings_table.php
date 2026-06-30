<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();

            $table->foreignId('service_id')
                ->nullable()
                ->constrained()
                ->nullOnDelete();

            $table->foreignId('tariff_id')
                ->nullable()
                ->constrained()
                ->nullOnDelete();

            $table->string('client_name');
            $table->string('client_phone');
            $table->string('client_email')->nullable();

            $table->dateTime('preferred_at')->nullable();

            $table->text('comment')->nullable();

            $table->string('status')->default('new');

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bookings');
    }
};