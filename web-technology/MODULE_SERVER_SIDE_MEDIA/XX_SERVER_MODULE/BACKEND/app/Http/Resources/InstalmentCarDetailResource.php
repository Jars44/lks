<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class InstalmentCarDetailResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'car' => $this->cars,
            'brand' => $this->brand ? $this->brand->brand : null,
            'price' => $this->price,
            'description' => $this->description,
            'available_month' => $this->availableMonths->map(function ($m) {
                return [
                    'month' => $m->month,
                    'description' => $m->description,
                    'nominal' => $m->nominal,
                ];
            }),
        ];
    }
}