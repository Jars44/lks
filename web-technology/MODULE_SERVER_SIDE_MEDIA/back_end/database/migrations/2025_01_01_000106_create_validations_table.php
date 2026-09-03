<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('validations', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('society_id');
            $table->unsignedBigInteger('validator_id')->nullable();
            $table->enum('status', ['pending', 'accepted', 'rejected'])->default('pending');
            $table->string('job')->nullable();
            $table->text('job_description')->nullable();
            $table->integer('income')->nullable();
            $table->text('reason_accepted')->nullable();
            $table->text('validator_notes')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('validations');
    }
};