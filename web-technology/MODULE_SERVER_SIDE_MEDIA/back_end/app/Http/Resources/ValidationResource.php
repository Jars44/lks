<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ValidationResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'status' => $this->status,
            'job' => $this->job,
            'job_description' => $this->job_description,
            'income' => $this->income,
            'reason_accepted' => $this->reason_accepted,
            'validator_notes' => $this->validator_notes,
            'validator' => $this->whenLoaded('validator', function () {
                return $this->validator ? [
                    'id' => $this->validator->id,
                    'name' => $this->validator->name,
                    'role' => $this->validator->role,
                ] : null;
            }),
        ];
    }
}