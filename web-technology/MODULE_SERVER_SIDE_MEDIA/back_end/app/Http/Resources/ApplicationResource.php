<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ApplicationResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->installment->id,
            'car' => $this->installment->cars,
            'brand' => $this->installment->brand ? $this->installment->brand->brand : null,
            'price' => $this->installment->price,
            'description' => $this->installment->description,
            'applications' => [[
                'month' => $this->availableMonth->month,
                'nominal' => $this->availableMonth->nominal,
                'apply_status' => $this->status ? $this->status->status : 'pending',
                'notes' => $this->notes,
            ]],
        ];
    }
}