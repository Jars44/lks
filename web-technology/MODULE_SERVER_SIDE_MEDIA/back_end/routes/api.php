<?php

use App\Http\Controllers\Api\ApplicationController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\InstalmentCarController;
use App\Http\Controllers\Api\SocietyValidationController;
use App\Http\Controllers\Api\Officer\OfficerAuthController;
use App\Http\Controllers\Api\Officer\BrandController as OfficerBrandController;
use App\Http\Controllers\Api\Officer\RegionalController as OfficerRegionalController;
use App\Http\Controllers\Api\Officer\SocietyController as OfficerSocietyController;
use App\Http\Controllers\Api\Officer\InstallmentController as OfficerInstallmentController;
use App\Http\Controllers\Api\Officer\AvailableMonthController as OfficerAvailableMonthController;
use App\Http\Controllers\Api\Validator\ValidatorAuthController;
use App\Http\Controllers\Api\Validator\ValidationController as ValidatorValidationController;
use Illuminate\Support\Facades\Route;

// Public
Route::post('/auth/login', [AuthController::class, 'login']);

// Society (Bearer token)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/auth/logout', [AuthController::class, 'logout']);

    Route::post('/validation', [SocietyValidationController::class, 'store']);
    Route::get('/validations', [SocietyValidationController::class, 'index']);

    Route::get('/instalment_cars', [InstalmentCarController::class, 'index']);
    Route::get('/instalment_cars/{id}', [InstalmentCarController::class, 'show']);

    Route::post('/applications', [ApplicationController::class, 'store']);
    Route::get('/applications', [ApplicationController::class, 'index']);
});

// Officer (users table, role=officer)
Route::post('/officer/login', [OfficerAuthController::class, 'login']);
Route::middleware(['auth:sanctum', 'role:officer'])->prefix('/officer')->group(function () {
    Route::apiResource('brands', OfficerBrandController::class);
    Route::apiResource('regionals', OfficerRegionalController::class);
    Route::apiResource('societies', OfficerSocietyController::class);
    Route::apiResource('installments', OfficerInstallmentController::class);
    Route::apiResource('available-months', OfficerAvailableMonthController::class);
});

// Validator (users table, role=validator)
Route::post('/validator/login', [ValidatorAuthController::class, 'login']);
Route::middleware(['auth:sanctum', 'role:validator'])->prefix('/validator')->group(function () {
    Route::get('/validations', [ValidatorValidationController::class, 'index']);
    Route::put('/validations/{id}', [ValidatorValidationController::class, 'update']);
});