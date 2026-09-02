<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('welcome');
})->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', function () {
        return Inertia::render('dashboard');
    })->name('dashboard');

    // Management Routes
    Route::get('societies', function () {
        return Inertia::render('societies/index');
    })->name('societies.index');

    Route::get('societies/create', function () {
        return Inertia::render('societies/create');
    })->name('societies.create');

    Route::get('societies/{society}', function () {
        return Inertia::render('societies/show');
    })->name('societies.show');

    Route::get('societies/{society}/edit', function () {
        return Inertia::render('societies/edit');
    })->name('societies.edit');

    Route::get('regionals', function () {
        return Inertia::render('regionals/index');
    })->name('regionals.index');

    Route::get('regionals/create', function () {
        return Inertia::render('regionals/create');
    })->name('regionals.create');

    Route::get('regionals/{regional}', function () {
        return Inertia::render('regionals/show');
    })->name('regionals.show');

    Route::get('regionals/{regional}/edit', function () {
        return Inertia::render('regionals/edit');
    })->name('regionals.edit');

    // Product Routes
    Route::get('brands', function () {
        return Inertia::render('brands/index');
    })->name('brands.index');

    Route::get('brands/create', function () {
        return Inertia::render('brands/create');
    })->name('brands.create');

    Route::get('brands/{brand}', function () {
        return Inertia::render('brands/show');
    })->name('brands.show');

    Route::get('brands/{brand}/edit', function () {
        return Inertia::render('brands/edit');
    })->name('brands.edit');

    Route::get('installments', function () {
        return Inertia::render('installments/index');
    })->name('installments.index');

    Route::get('installments/create', function () {
        return Inertia::render('installments/create');
    })->name('installments.create');

    Route::get('installments/{installment}', function () {
        return Inertia::render('installments/show');
    })->name('installments.show');

    Route::get('installments/{installment}/edit', function () {
        return Inertia::render('installments/edit');
    })->name('installments.edit');

    Route::get('available-months', function () {
        return Inertia::render('available-months/index');
    })->name('available-months.index');

    Route::get('available-months/create', function () {
        return Inertia::render('available-months/create');
    })->name('available-months.create');

    Route::get('available-months/{availableMonth}', function () {
        return Inertia::render('available-months/show');
    })->name('available-months.show');

    Route::get('available-months/{availableMonth}/edit', function () {
        return Inertia::render('available-months/edit');
    })->name('available-months.edit');

    // Application Routes
    Route::get('applications', function () {
        return Inertia::render('applications/index');
    })->name('applications.index');

    Route::get('applications/create', function () {
        return Inertia::render('applications/create');
    })->name('applications.create');

    Route::get('applications/{application}', function () {
        return Inertia::render('applications/show');
    })->name('applications.show');

    Route::get('applications/{application}/edit', function () {
        return Inertia::render('applications/edit');
    })->name('applications.edit');

    Route::get('validations', function () {
        return Inertia::render('validations/index');
    })->name('validations.index');

    Route::get('validations/create', function () {
        return Inertia::render('validations/create');
    })->name('validations.create');

    Route::get('validations/{validation}', function () {
        return Inertia::render('validations/show');
    })->name('validations.show');

    Route::get('validations/{validation}/edit', function () {
        return Inertia::render('validations/edit');
    })->name('validations.edit');

    Route::get('validators', function () {
        return Inertia::render('validators/index');
    })->name('validators.index');

    Route::get('validators/create', function () {
        return Inertia::render('validators/create');
    })->name('validators.create');

    Route::get('validators/{validator}', function () {
        return Inertia::render('validators/show');
    })->name('validators.show');

    Route::get('validators/{validator}/edit', function () {
        return Inertia::render('validators/edit');
    })->name('validators.edit');
});

require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
