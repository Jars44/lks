<?php

namespace App\Http\Controllers\Api\Officer;

use App\Http\Controllers\Controller;
use App\Models\Society;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class SocietyController extends Controller
{
    public function index()
    {
        $societies = Society::with('regional')->get()->makeHidden(['password', 'login_tokens']);

        return response()->json([
            'societies' => $societies,
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id_card_number' => 'required|string|max:8|unique:societies,id_card_number',
            'password' => 'required|string',
            'name' => 'required|string',
            'born_date' => 'required|date',
            'gender' => 'required|in:male,female',
            'address' => 'required|string',
            'regional_id' => 'required|integer|exists:regionals,id',
        ]);

        $validated['password'] = Hash::make($validated['password']);

        $society = Society::create($validated);

        return response()->json([
            'society' => $society->load('regional')->makeHidden(['password', 'login_tokens']),
        ], 201);
    }

    public function show($id)
    {
        $society = Society::with('regional')->findOrFail($id)->makeHidden(['password', 'login_tokens']);

        return response()->json([
            'society' => $society,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $society = Society::findOrFail($id);

        $validated = $request->validate([
            'id_card_number' => 'sometimes|required|string|max:8|unique:societies,id_card_number,'.$society->id,
            'password' => 'sometimes|required|string',
            'name' => 'sometimes|required|string',
            'born_date' => 'sometimes|required|date',
            'gender' => 'sometimes|required|in:male,female',
            'address' => 'sometimes|required|string',
            'regional_id' => 'sometimes|required|integer|exists:regionals,id',
        ]);

        if (array_key_exists('password', $validated)) {
            $validated['password'] = Hash::make($validated['password']);
        }

        $society->update($validated);

        return response()->json([
            'society' => $society->load('regional')->makeHidden(['password', 'login_tokens']),
        ], 200);
    }

    public function destroy($id)
    {
        Society::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Society deleted',
        ], 200);
    }
}
