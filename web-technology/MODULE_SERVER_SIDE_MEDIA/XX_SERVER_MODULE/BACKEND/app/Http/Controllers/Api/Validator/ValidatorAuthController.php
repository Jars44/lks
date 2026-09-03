<?php

namespace App\Http\Controllers\Api\Validator;

use App\Http\Controllers\Controller;
use App\Http\Requests\ValidatorLoginRequest;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class ValidatorAuthController extends Controller
{
    public function login(ValidatorLoginRequest $request)
    {
        $user = User::where('username', $request->username)->first();

        if (! $user || ! Hash::check($request->password, $user->password) || ! $user->validator || $user->validator->role !== 'validator') {
            return response()->json([
                'message' => 'ID Card Number or Password incorrect',
            ], 401);
        }

        $token = $user->createToken('validator_token')->plainTextToken;

        return response()->json([
            'message' => 'Login success',
            'token' => $token,
            'name' => $user->validator->name,
            'role' => 'validator',
        ], 200);
    }
}
