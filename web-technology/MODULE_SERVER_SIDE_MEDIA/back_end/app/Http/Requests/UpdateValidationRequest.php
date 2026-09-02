<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateValidationRequest extends FormRequest
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
            'installment_id' => 'sometimes|required|exists:installments,id',
            'validator_id' => 'sometimes|required|exists:validators,id',
            'status' => 'sometimes|required|string|max:50',
            'notes' => 'sometimes|nullable|string',
            'validated_at' => 'sometimes|nullable|date',
        ];
    }
}
