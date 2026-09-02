<?php

namespace App\Http\Controllers;

use App\Models\Validation as ValidationModel;
use App\Models\Society;
use App\Services\SocietyValidationService;
use App\Http\Requests\StoreValidationRequest;
use App\Http\Requests\UpdateValidationRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class ValidationsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Validation::with(['installment.brand', 'validator.user']);

        // Search functionality
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('status', 'like', "%{$search}%")
                  ->orWhere('notes', 'like', "%{$search}%")
                  ->orWhereHas('installment', function ($installmentQuery) use ($search) {
                      $installmentQuery->where('name', 'like', "%{$search}%");
                  })
                  ->orWhereHas('validator', function ($validatorQuery) use ($search) {
                      $validatorQuery->where('name', 'like', "%{$search}%");
                  });
            });
        }

        // Filter by installment
        if ($request->has('installment_id') && !empty($request->installment_id)) {
            $query->where('installment_id', $request->installment_id);
        }

        // Filter by validator
        if ($request->has('validator_id') && !empty($request->validator_id)) {
            $query->where('validator_id', $request->validator_id);
        }

        // Filter by status
        if ($request->has('status') && !empty($request->status)) {
            $query->where('status', $request->status);
        }

        $validations = $query->paginate(15);

        return response()->json($validations);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreValidationRequest $request): JsonResponse
    {
        try {
            $society = Society::findOrFail($request->society_id);
            $validationService = new SocietyValidationService();
            $validation = $validationService->validateSociety($society, $request->validated());

            return response()->json([
                'message' => 'Validation created successfully.',
                'data' => $validation->load(['installment.brand', 'validator.user'])
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create validation.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Validation $validation): JsonResponse
    {
        return response()->json($validation->load(['installment.brand', 'validator.user']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateValidationRequest $request, Validation $validation): JsonResponse
    {
        try {
            $validation->update($request->validated());

            return response()->json([
                'message' => 'Validation updated successfully.',
                'data' => $validation->load(['installment.brand', 'validator.user'])
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update validation.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Validation $validation): JsonResponse
    {
        try {
            $validation->delete();

            return response()->json([
                'message' => 'Validation deleted successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete validation.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
