<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('installment_apply_societies', function (Blueprint $table) {
            $table->id();
            $table->text('notes')->nullable();
            $table->unsignedBigInteger('available_month_id')->nullable();
            $table->date('date');
            $table->unsignedBigInteger('society_id');
            $table->unsignedBigInteger('installment_id')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('installment_apply_societies');
    }
};