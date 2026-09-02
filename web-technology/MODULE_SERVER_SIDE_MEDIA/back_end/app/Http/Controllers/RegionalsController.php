<?php

namespace App\Http\Controllers;

use App\Models\Regional;
use App\Http\Requests\StoreRegionalRequest;
use App\Http\Requests\UpdateRegionalRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class RegionalsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Regional::query();

        // Search functionality
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('code', 'like', "%{$search}%");
            });
        }

        $regionals = $query->paginate(15);

        return response()->json($regionals);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreRegionalRequest $request): JsonResponse
    {
        try {
            $regional = Regional::create($request->validated());

            return response()->json([
                'message' => 'Regional created successfully.',
                'data' => $regional
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create regional.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Regional $regional): JsonResponse
    {
        return response()->json($regional->load('societies'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateRegionalRequest $request, Regional $regional): JsonResponse
    {
        try {
            $regional->update($request->validated());

            return response()->json([
                'message' => 'Regional updated successfully.',
                'data' => $regional
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update regional.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Regional $regional): JsonResponse
    {
        try {
            $regional->delete();

            return response()->json([
                'message' => 'Regional deleted successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete regional.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
