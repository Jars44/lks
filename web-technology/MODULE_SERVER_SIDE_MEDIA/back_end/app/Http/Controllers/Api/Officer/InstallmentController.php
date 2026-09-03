<?php

namespace App\Http\Controllers\Api\Officer;

use App\Http\Controllers\Controller;
use App\Models\Installment;
use Illuminate\Http\Request;

class InstallmentController extends Controller
{
    public function index()
    {
        return response()->json([
            'installments' => Installment::with(['brand', 'availableMonths'])->get(),
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'brand_id' => 'required|integer|exists:brand,id',
            'cars' => 'required|string',
            'description' => 'nullable|string',
            'price' => 'required|integer|min:0',
        ]);

        $installment = Installment::create($validated);

        return response()->json([
            'installment' => $installment,
        ], 201);
    }

    public function show($id)
    {
        $installment = Installment::with(['brand', 'availableMonths'])->findOrFail($id);

        return response()->json([
            'installment' => $installment,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $installment = Installment::findOrFail($id);

        $validated = $request->validate([
            'brand_id' => 'sometimes|required|integer|exists:brand,id',
            'cars' => 'sometimes|required|string',
            'description' => 'sometimes|nullable|string',
            'price' => 'sometimes|required|integer|min:0',
        ]);

        $installment->update($validated);

        return response()->json([
            'installment' => $installment,
        ], 200);
    }

    public function destroy($id)
    {
        Installment::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Installment deleted',
        ], 200);
    }
}
