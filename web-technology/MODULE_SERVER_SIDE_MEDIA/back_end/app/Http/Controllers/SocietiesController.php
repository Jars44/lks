<?php

namespace App\Http\Controllers;

use App\Models\Society;
use App\Http\Requests\StoreSocietyRequest;
use App\Http\Requests\UpdateSocietyRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class SocietiesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Society::with('regional');

        // Search functionality
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%")
                  ->orWhere('phone', 'like', "%{$search}%");
            });
        }

        // Filter by regional
        if ($request->has('regional_id') && !empty($request->regional_id)) {
            $query->where('regional_id', $request->regional_id);
        }

        $societies = $query->paginate(15);

        return response()->json($societies);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreSocietyRequest $request): JsonResponse
    {
        try {
            $society = Society::create($request->validated());

            return response()->json([
                'message' => 'Society created successfully.',
                'data' => $society->load('regional')
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create society.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Society $society): JsonResponse
    {
        return response()->json($society->load(['regional', 'installments', 'appliedInstallments']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateSocietyRequest $request, Society $society): JsonResponse
    {
        try {
            $society->update($request->validated());

            return response()->json([
                'message' => 'Society updated successfully.',
                'data' => $society->load('regional')
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update society.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Society $society): JsonResponse
    {
        try {
            $society->delete();

            return response()->json([
                'message' => 'Society deleted successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete society.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
