<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreApplicationRequest;
use App\Http\Resources\ApplicationResource;
use App\Models\AvailableMonth;
use App\Models\InstallmentApplySocieties;
use App\Models\InstallmentApplyStatus;
use App\Models\Validation;
use Illuminate\Http\Request;

class ApplicationController extends Controller
{
    public function store(StoreApplicationRequest $request)
    {
        $society = $request->user('sanctum');

        // Validation must be accepted
        $validation = $society->validations()->where('status', 'accepted')->latest()->first();
        if (!$validation) {
            return response()->json([
                'message' => 'Your data validator must be accepted by validator before',
            ], 401);
        }

        // Only one application per instalment
        $already = InstallmentApplySocieties::where('society_id', $society->id)
            ->where('installment_id', $request->instalment_id)
            ->exists();
        if ($already) {
            return response()->json([
                'message' => 'Application for a instalment can only be once',
            ], 401);
        }

        $availableMonth = AvailableMonth::where('installment_id', $request->instalment_id)
            ->where('month', $request->months)
            ->first();

        if (!$availableMonth) {
            return response()->json([
                'message' => 'Invalid field',
                'errors' => [
                    'months' => ['The selected months is invalid.'],
                ],
            ], 401);
        }

        $apply = InstallmentApplySocieties::create([
            'notes' => $request->notes,
            'available_month_id' => $availableMonth->id,
            'date' => now()->toDateString(),
            'society_id' => $society->id,
            'installment_id' => $request->instalment_id,
        ]);

        InstallmentApplyStatus::create([
            'date' => now()->toDateString(),
            'society_id' => $society->id,
            'installment_id' => $request->instalment_id,
            'available_month_id' => $availableMonth->id,
            'installment_apply_societies_id' => $apply->id,
            'status' => 'pending',
        ]);

        return response()->json([
            'message' => 'Applying for Instalment successful',
        ], 200);
    }

    public function index(Request $request)
    {
        $society = $request->user('sanctum');

        $applies = InstallmentApplySocieties::with(['installment.brand', 'availableMonth', 'status'])
            ->where('society_id', $society->id)
            ->get();

        return response()->json([
            'instalments' => ApplicationResource::collection($applies),
        ], 200);
    }
}