<?php

namespace Database\Seeders;

use App\Models\Regional;
use Illuminate\Database\Seeder;

class RegionalSeeder extends Seeder
{
    public function run(): void
    {
        Regional::insert([
            ['id' => 1, 'province' => 'DKI Jakarta', 'district' => 'Central Jakarta'],
            ['id' => 2, 'province' => 'DKI Jakarta', 'district' => 'South Jakarta'],
            ['id' => 3, 'province' => 'West Java', 'district' => 'Bandung'],
        ]);
    }
}
