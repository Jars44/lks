<?php

namespace App\Http\Controllers\Api\Validator;

use App\Http\Controllers\Controller;
use App\Http\Resources\ValidationResource;
use App\Models\Validation;
use Illuminate\Http\Request;

class ValidationController extends Controller
{
    public function index()
    {
        $validations = Validation::with(['society', 'validator'])->get();

        return response()->json([
            'validations' => ValidationResource::collection($validations),
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:accepted,rejected',
            'validator_notes' => 'nullable|string',
        ]);

        $validation = Validation::findOrFail($id);

        $validation->validator_id = $request->user('sanctum')->validator->id;
        $validation->status = $validated['status'];
        $validation->validator_notes = $validated['validator_notes'] ?? null;
        $validation->save();

        return response()->json([
            'message' => 'Validation updated',
            'validation' => new ValidationResource($validation->load('society', 'validator')),
        ], 200);
    }
}
