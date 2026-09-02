<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateInstallmentApplySocietiesRequest extends FormRequest
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
            'society_id' => 'sometimes|required|exists:societies,id',
            'status_id' => 'sometimes|required|exists:installment_apply_statuses,id',
            'applied_at' => 'sometimes|nullable|date',
        ];
    }
}
