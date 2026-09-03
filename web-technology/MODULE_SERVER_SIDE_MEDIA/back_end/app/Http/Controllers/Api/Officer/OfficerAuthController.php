<?php

namespace App\Http\Controllers\Api\Officer;

use App\Http\Controllers\Controller;
use App\Http\Requests\OfficerLoginRequest;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class OfficerAuthController extends Controller
{
    public function login(OfficerLoginRequest $request)
    {
        $user = User::where('username', $request->username)->first();

        if (! $user || ! Hash::check($request->password, $user->password) || ! $user->validator || $user->validator->role !== 'officer') {
            return response()->json([
                'message' => 'ID Card Number or Password incorrect',
            ], 401);
        }

        $token = $user->createToken('officer_token')->plainTextToken;

        return response()->json([
            'message' => 'Login success',
            'token' => $token,
            'name' => $user->validator->name,
            'role' => 'officer',
        ], 200);
    }
}
