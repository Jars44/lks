<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('available_month', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('installment_id');
            $table->integer('month')->nullable();
            $table->text('description')->nullable();
            $table->integer('nominal')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('available_month');
    }
};