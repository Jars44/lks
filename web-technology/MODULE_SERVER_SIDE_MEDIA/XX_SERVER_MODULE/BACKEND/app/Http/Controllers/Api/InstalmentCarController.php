<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\InstalmentCarResource;
use App\Http\Resources\InstalmentCarDetailResource;
use App\Models\Installment;
use Illuminate\Http\Request;

class InstalmentCarController extends Controller
{
    public function index(Request $request)
    {
        $cars = Installment::with('brand', 'availableMonths')->get();

        return response()->json([
            'cars' => InstalmentCarResource::collection($cars),
        ], 200);
    }

    public function show(Request $request, $id)
    {
        $car = Installment::with('brand', 'availableMonths')->findOrFail($id);

        return response()->json([
            'instalment' => new InstalmentCarDetailResource($car),
        ], 200);
    }
}