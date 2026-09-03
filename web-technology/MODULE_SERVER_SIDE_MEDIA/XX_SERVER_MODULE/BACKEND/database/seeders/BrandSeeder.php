<?php

namespace Database\Seeders;

use App\Models\Brand;
use Illuminate\Database\Seeder;

class BrandSeeder extends Seeder
{
    public function run(): void
    {
        Brand::insert([
            ['id' => 1, 'brand' => 'Toyota'],
            ['id' => 2, 'brand' => 'Yamaha'],
            ['id' => 3, 'brand' => 'BMW'],
            ['id' => 4, 'brand' => 'Bugatti'],
            ['id' => 5, 'brand' => 'Jeep'],
        ]);
    }
}
