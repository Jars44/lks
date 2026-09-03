<?php

namespace App\Http\Controllers\Api\Officer;

use App\Http\Controllers\Controller;
use App\Models\AvailableMonth;
use Illuminate\Http\Request;

class AvailableMonthController extends Controller
{
    public function index()
    {
        return response()->json([
            'available_months' => AvailableMonth::all(),
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'installment_id' => 'required|integer|exists:installment,id',
            'month' => 'required|integer|min:1',
            'description' => 'required|string',
            'nominal' => 'required|integer|min:0',
        ]);

        $availableMonth = AvailableMonth::create($validated);

        return response()->json([
            'available_month' => $availableMonth,
        ], 201);
    }

    public function show($id)
    {
        $availableMonth = AvailableMonth::findOrFail($id);

        return response()->json([
            'available_month' => $availableMonth,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $availableMonth = AvailableMonth::findOrFail($id);

        $validated = $request->validate([
            'installment_id' => 'sometimes|required|integer|exists:installment,id',
            'month' => 'sometimes|required|integer|min:1',
            'description' => 'sometimes|required|string',
            'nominal' => 'sometimes|required|integer|min:0',
        ]);

        $availableMonth->update($validated);

        return response()->json([
            'available_month' => $availableMonth,
        ], 200);
    }

    public function destroy($id)
    {
        AvailableMonth::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Available month deleted',
        ], 200);
    }
}
