<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('bookings', function (Blueprint $table) {
            if (!Schema::hasColumn('bookings', 'client_id')) {
                $table->foreignId('client_id')
                    ->nullable()
                    ->after('id')
                    ->constrained()
                    ->nullOnDelete();
            }

            if (!Schema::hasColumn('bookings', 'client_name')) {
                $table->string('client_name')->nullable();
            }

            if (!Schema::hasColumn('bookings', 'client_phone')) {
                $table->string('client_phone')->nullable();
            }

            if (!Schema::hasColumn('bookings', 'client_email')) {
                $table->string('client_email')->nullable();
            }

            if (!Schema::hasColumn('bookings', 'client_messenger')) {
                $table->string('client_messenger')->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('bookings', function (Blueprint $table) {
            if (Schema::hasColumn('bookings', 'client_messenger')) {
                $table->dropColumn('client_messenger');
            }

            if (Schema::hasColumn('bookings', 'client_email')) {
                $table->dropColumn('client_email');
            }

            if (Schema::hasColumn('bookings', 'client_phone')) {
                $table->dropColumn('client_phone');
            }

            if (Schema::hasColumn('bookings', 'client_name')) {
                $table->dropColumn('client_name');
            }

            if (Schema::hasColumn('bookings', 'client_id')) {
                $table->dropConstrainedForeignId('client_id');
            }
        });
    }
};