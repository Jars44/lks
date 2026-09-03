<?php

namespace App\Http\Controllers\Api\Officer;

use App\Http\Controllers\Controller;
use App\Models\Brand;
use Illuminate\Http\Request;

class BrandController extends Controller
{
    public function index()
    {
        return response()->json([
            'brands' => Brand::all(),
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'brand' => 'required|string|max:255',
        ]);

        $brand = Brand::create($validated);

        return response()->json([
            'brand' => $brand,
        ], 201);
    }

    public function show($id)
    {
        $brand = Brand::findOrFail($id);

        return response()->json([
            'brand' => $brand,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $brand = Brand::findOrFail($id);

        $validated = $request->validate([
            'brand' => 'sometimes|required|string|max:255',
        ]);

        $brand->update($validated);

        return response()->json([
            'brand' => $brand,
        ], 200);
    }

    public function destroy($id)
    {
        Brand::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Brand deleted',
        ], 200);
    }
}
