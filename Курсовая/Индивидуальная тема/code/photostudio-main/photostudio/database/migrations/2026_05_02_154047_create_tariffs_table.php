<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tariffs', function (Blueprint $table) {
            $table->id();

            $table->foreignId('service_id')
                ->constrained()
                ->cascadeOnDelete();

            $table->string('title');

            $table->decimal('price', 10, 2);
            $table->decimal('old_price', 10, 2)->nullable();

            $table->unsignedInteger('duration_minutes')->nullable();
            $table->unsignedInteger('photos_count')->nullable();

            $table->text('description')->nullable();
            $table->text('features')->nullable();

            $table->boolean('is_popular')->default(false);
            $table->boolean('is_active')->default(true);

            $table->unsignedInteger('sort_order')->default(0);

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tariffs');
    }
};