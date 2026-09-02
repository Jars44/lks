<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SocietiesController;
use App\Http\Controllers\RegionalsController;
use App\Http\Controllers\BrandsController;
use App\Http\Controllers\InstallmentsController;
use App\Http\Controllers\AvailableMonthsController;
use App\Http\Controllers\ApplicationsController;
use App\Http\Controllers\ValidationsController;
use App\Http\Controllers\ValidatorsController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Management Routes
Route::middleware(['auth:sanctum'])->group(function () {
    Route::apiResource('societies', SocietiesController::class);
    Route::apiResource('regionals', RegionalsController::class);
});

// Product Routes
Route::middleware(['auth:sanctum'])->group(function () {
    Route::apiResource('brands', BrandsController::class);
    Route::apiResource('installments', InstallmentsController::class);
    Route::apiResource('available-months', AvailableMonthsController::class);
});

// Application Routes
Route::middleware(['auth:sanctum'])->group(function () {
    Route::apiResource('applications', ApplicationsController::class);
    Route::apiResource('validations', ValidationsController::class);
    Route::apiResource('validators', ValidatorsController::class);
});
