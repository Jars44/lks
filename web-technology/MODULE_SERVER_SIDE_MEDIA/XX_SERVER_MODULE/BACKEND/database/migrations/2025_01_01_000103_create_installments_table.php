<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('installment', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('brand_id')->nullable();
            $table->string('cars');
            $table->text('description')->nullable();
            $table->integer('price')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('installment');
    }
};