<?php

namespace App\Http\Controllers;

use App\Models\AvailableMonth;
use App\Http\Requests\StoreAvailableMonthRequest;
use App\Http\Requests\UpdateAvailableMonthRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class AvailableMonthsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResponse
    {
        $query = AvailableMonth::with('installment.brand');

        // Filter by installment
        if ($request->has('installment_id') && !empty($request->installment_id)) {
            $query->where('installment_id', $request->installment_id);
        }

        // Filter by year
        if ($request->has('year') && !empty($request->year)) {
            $query->where('year', $request->year);
        }

        // Filter by availability
        if ($request->has('is_available')) {
            $query->where('is_available', $request->boolean('is_available'));
        }

        $availableMonths = $query->paginate(15);

        return response()->json($availableMonths);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreAvailableMonthRequest $request): JsonResponse
    {
        try {
            $availableMonth = AvailableMonth::create($request->validated());

            return response()->json([
                'message' => 'Available month created successfully.',
                'data' => $availableMonth->load('installment.brand')
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create available month.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(AvailableMonth $availableMonth): JsonResponse
    {
        return response()->json($availableMonth->load('installment.brand'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateAvailableMonthRequest $request, AvailableMonth $availableMonth): JsonResponse
    {
        try {
            $availableMonth->update($request->validated());

            return response()->json([
                'message' => 'Available month updated successfully.',
                'data' => $availableMonth->load('installment.brand')
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update available month.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(AvailableMonth $availableMonth): JsonResponse
    {
        try {
            $availableMonth->delete();

            return response()->json([
                'message' => 'Available month deleted successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete available month.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
