<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('bookings', function (Blueprint $table) {
            $table->foreignId('client_id')
                ->nullable()
                ->after('id')
                ->constrained()
                ->nullOnDelete();
        });

        if (Schema::hasColumn('bookings', 'service_id')) {
            Schema::table('bookings', function (Blueprint $table) {
                $table->dropConstrainedForeignId('service_id');
            });
        }

        if (Schema::hasColumn('bookings', 'tariff_id')) {
            Schema::table('bookings', function (Blueprint $table) {
                $table->dropConstrainedForeignId('tariff_id');
            });
        }
    }

    public function down(): void
    {
        Schema::table('bookings', function (Blueprint $table) {
            $table->foreignId('service_id')
                ->nullable()
                ->constrained()
                ->nullOnDelete();

            $table->foreignId('tariff_id')
                ->nullable()
                ->constrained()
                ->nullOnDelete();
        });

        Schema::table('bookings', function (Blueprint $table) {
            $table->dropConstrainedForeignId('client_id');
        });
    }
};