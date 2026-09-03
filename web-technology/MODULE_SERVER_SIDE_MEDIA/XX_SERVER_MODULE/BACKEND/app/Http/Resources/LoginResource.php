<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class LoginResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'name' => $this->name,
            'born_date' => $this->born_date,
            'gender' => $this->gender,
            'address' => $this->address,
            'token' => $this->whenNotNull($this->token),
            'regional' => [
                'id' => $this->regional->id,
                'province' => $this->regional->province,
                'district' => $this->regional->district,
            ],
        ];
    }
}