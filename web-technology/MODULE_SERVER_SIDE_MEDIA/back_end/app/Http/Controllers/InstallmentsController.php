<?php

namespace App\Http\Controllers;

use App\Models\Installment;
use App\Http\Requests\StoreInstallmentRequest;
use App\Http\Requests\UpdateInstallmentRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class InstallmentsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Installment::with(['brand', 'society.regional']);

        // Search functionality
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('description', 'like', "%{$search}%")
                  ->orWhereHas('brand', function ($brandQuery) use ($search) {
                      $brandQuery->where('name', 'like', "%{$search}%");
                  })
                  ->orWhereHas('society', function ($societyQuery) use ($search) {
                      $societyQuery->where('name', 'like', "%{$search}%");
                  });
            });
        }

        // Filter by brand
        if ($request->has('brand_id') && !empty($request->brand_id)) {
            $query->where('brand_id', $request->brand_id);
        }

        // Filter by society
        if ($request->has('society_id') && !empty($request->society_id)) {
            $query->where('society_id', $request->society_id);
        }

        // Filter by status
        if ($request->has('status') && !empty($request->status)) {
            $query->where('status', $request->status);
        }

        $installments = $query->paginate(15);

        return response()->json($installments);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreInstallmentRequest $request): JsonResponse
    {
        try {
            $installment = Installment::create($request->validated());

            return response()->json([
                'message' => 'Installment created successfully.',
                'data' => $installment->load(['brand', 'society.regional'])
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create installment.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Installment $installment): JsonResponse
    {
        return response()->json($installment->load([
            'brand',
            'society.regional',
            'availableMonths',
            'appliedSocieties.status',
            'validations.validator'
        ]));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateInstallmentRequest $request, Installment $installment): JsonResponse
    {
        try {
            $installment->update($request->validated());

            return response()->json([
                'message' => 'Installment updated successfully.',
                'data' => $installment->load(['brand', 'society.regional'])
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update installment.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Installment $installment): JsonResponse
    {
        try {
            $installment->delete();

            return response()->json([
                'message' => 'Installment deleted successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete installment.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
