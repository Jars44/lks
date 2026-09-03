<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureRole
{
    public function handle(Request $request, Closure $next, string $role): Response
    {
        $validator = $request->user('sanctum')?->validator;

        if (!$validator || $validator->role !== $role) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        return $next($request);
    }
}