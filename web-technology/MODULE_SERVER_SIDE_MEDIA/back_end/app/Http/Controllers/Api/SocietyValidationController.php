<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreValidationRequest;
use App\Http\Resources\ValidationResource;
use Illuminate\Http\Request;

class SocietyValidationController extends Controller
{
    public function store(StoreValidationRequest $request)
    {
        $society = $request->user('sanctum');

        // Society can only request validation once
        if ($society->validations()->exists()) {
            return response()->json([
                'message' => 'Validation already requested',
            ], 401);
        }

        $society->validations()->create([
            'status' => 'pending',
            'job' => $request->job,
            'job_description' => $request->job_description,
            'income' => $request->income,
            'reason_accepted' => $request->reason_accepted,
        ]);

        return response()->json([
            'message' => 'Request data validation sent successful',
        ], 200);
    }

    public function index(Request $request)
    {
        $validation = $request->user('sanctum')->validations()->latest()->first();

        if (!$validation) {
            return response()->json([
                'validation' => null,
            ], 200);
        }

        return response()->json([
            'validation' => new ValidationResource($validation),
        ], 200);
    }
}