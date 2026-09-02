<?php

namespace App\Http\Controllers;

use App\Models\Validator;
use App\Http\Requests\StoreValidatorRequest;
use App\Http\Requests\UpdateValidatorRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class ValidatorsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Validator::with('user');

        // Search functionality
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('position', 'like', "%{$search}%")
                  ->orWhere('department', 'like', "%{$search}%");
            });
        }

        // Filter by department
        if ($request->has('department') && !empty($request->department)) {
            $query->where('department', $request->department);
        }

        // Filter by active status
        if ($request->has('is_active')) {
            $query->where('is_active', $request->boolean('is_active'));
        }

        $validators = $query->paginate(15);

        return response()->json($validators);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreValidatorRequest $request): JsonResponse
    {
        try {
            $validator = Validator::create($request->validated());

            return response()->json([
                'message' => 'Validator created successfully.',
                'data' => $validator->load('user')
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create validator.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Validator $validator): JsonResponse
    {
        return response()->json($validator->load(['user', 'validations.installment']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateValidatorRequest $request, Validator $validator): JsonResponse
    {
        try {
            $validator->update($request->validated());

            return response()->json([
                'message' => 'Validator updated successfully.',
                'data' => $validator->load('user')
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update validator.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Validator $validator): JsonResponse
    {
        try {
            $validator->delete();

            return response()->json([
                'message' => 'Validator deleted successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete validator.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
