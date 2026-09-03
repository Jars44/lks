<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Resources\LoginResource;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function login(LoginRequest $request)
    {
        $society = \App\Models\Society::where('id_card_number', $request->id_card_number)->first();

        if (!$society || !\Illuminate\Support\Facades\Hash::check($request->password, $society->password)) {
            return response()->json([
                'message' => 'ID Card Number or Password incorrect',
            ], 401);
        }

        $token = $society->createToken('auth_token')->plainTextToken;

        return response()->json([
            'name' => $society->name,
            'born_date' => $society->born_date,
            'gender' => $society->gender,
            'address' => $society->address,
            'token' => $token,
            'regional' => [
                'id' => $society->regional->id,
                'province' => $society->regional->province,
                'district' => $society->regional->district,
            ],
        ]);
    }

    public function logout(Request $request)
    {
        $request->user('sanctum')->currentAccessToken()->delete();

        return response()->json(['message' => 'Logout success']);
    }
}