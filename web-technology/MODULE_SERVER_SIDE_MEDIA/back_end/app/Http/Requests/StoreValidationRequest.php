<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreValidationRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'installment_id' => 'required|exists:installments,id',
            'validator_id' => 'required|exists:validators,id',
            'status' => 'required|string|max:50',
            'notes' => 'nullable|string',
            'validated_at' => 'nullable|date',
        ];
    }
}
