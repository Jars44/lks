<?php

namespace App\Http\Controllers;

use App\Models\Brand;
use App\Http\Requests\StoreBrandRequest;
use App\Http\Requests\UpdateBrandRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class BrandsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Brand::query();

        // Search functionality
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('description', 'like', "%{$search}%");
            });
        }

        $brands = $query->paginate(15);

        return response()->json($brands);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreBrandRequest $request): JsonResponse
    {
        try {
            $brand = Brand::create($request->validated());

            return response()->json([
                'message' => 'Brand created successfully.',
                'data' => $brand
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create brand.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Brand $brand): JsonResponse
    {
        return response()->json($brand->load('installments'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateBrandRequest $request, Brand $brand): JsonResponse
    {
        try {
            $brand->update($request->validated());

            return response()->json([
                'message' => 'Brand updated successfully.',
                'data' => $brand
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update brand.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Brand $brand): JsonResponse
    {
        try {
            $brand->delete();

            return response()->json([
                'message' => 'Brand deleted successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete brand.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
