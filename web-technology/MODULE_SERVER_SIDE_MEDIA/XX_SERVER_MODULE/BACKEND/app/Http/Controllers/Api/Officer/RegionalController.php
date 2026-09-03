<?php

namespace App\Http\Controllers\Api\Officer;

use App\Http\Controllers\Controller;
use App\Models\Regional;
use Illuminate\Http\Request;

class RegionalController extends Controller
{
    public function index()
    {
        return response()->json([
            'regionals' => Regional::all(),
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'province' => 'required|string',
            'district' => 'required|string',
        ]);

        $regional = Regional::create($validated);

        return response()->json([
            'regional' => $regional,
        ], 201);
    }

    public function show($id)
    {
        $regional = Regional::findOrFail($id);

        return response()->json([
            'regional' => $regional,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $regional = Regional::findOrFail($id);

        $validated = $request->validate([
            'province' => 'sometimes|required|string',
            'district' => 'sometimes|required|string',
        ]);

        $regional->update($validated);

        return response()->json([
            'regional' => $regional,
        ], 200);
    }

    public function destroy($id)
    {
        Regional::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Regional deleted',
        ], 200);
    }
}
