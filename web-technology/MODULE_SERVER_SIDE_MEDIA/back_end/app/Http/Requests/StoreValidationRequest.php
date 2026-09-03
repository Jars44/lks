<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreValidationRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'job' => 'required|string|max:255',
            'job_description' => 'required|string',
            'income' => 'required|integer',
            'reason_accepted' => 'required|string',
        ];
    }
}