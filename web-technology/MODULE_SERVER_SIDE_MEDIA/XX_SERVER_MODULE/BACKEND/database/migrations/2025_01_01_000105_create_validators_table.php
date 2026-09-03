<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('validators', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->enum('role', ['officer', 'validator'])->default('officer');
            $table->string('name');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('validators');
    }
};