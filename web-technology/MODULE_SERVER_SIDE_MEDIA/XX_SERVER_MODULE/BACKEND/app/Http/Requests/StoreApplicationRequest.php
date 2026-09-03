<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreApplicationRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'instalment_id' => 'required|integer|exists:installment,id',
            'months' => 'required|integer|min:1',
            'notes' => 'nullable|string',
        ];
    }

    protected function failedValidation(\Illuminate\Contracts\Validation\Validator $validator)
    {
        $response = response()->json([
            'message' => 'Invalid field',
            'errors' => $validator->errors()->toArray(),
        ], 401);

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}