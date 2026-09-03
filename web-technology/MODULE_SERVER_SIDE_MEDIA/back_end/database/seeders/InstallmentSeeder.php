<?php

namespace Database\Seeders;

use App\Models\AvailableMonth;
use App\Models\Installment;
use Illuminate\Database\Seeder;

class InstallmentSeeder extends Seeder
{
    public function run(): void
    {
        $cars = [
            ['id' => 1, 'brand_id' => 1, 'cars' => 'Toyota FT 86', 'description' => 'Toyota FT 86 car is the best', 'price' => 900000000],
            ['id' => 2, 'brand_id' => 1, 'cars' => 'Toyota Supra', 'description' => 'Toyota Supra is a legendary sports car', 'price' => 1200000000],
            ['id' => 3, 'brand_id' => 2, 'cars' => 'Yamaha GT', 'description' => 'Yamaha GT premium vehicle', 'price' => 750000000],
            ['id' => 4, 'brand_id' => 3, 'cars' => 'BMW M4', 'description' => 'BMW M4 high performance coupe', 'price' => 1800000000],
            ['id' => 5, 'brand_id' => 4, 'cars' => 'Bugatti Chiron', 'description' => 'Bugatti Chiron hypercar', 'price' => 5000000000],
            ['id' => 6, 'brand_id' => 5, 'cars' => 'Jeep Wrangler', 'description' => 'Jeep Wrangler offroad SUV', 'price' => 850000000],
        ];

        Installment::insert($cars);

        $months = [
            [1, 12, '12 Months'], [1, 24, '24 Months'], [1, 48, '48 Months'],
            [2, 12, '12 Months'], [2, 24, '24 Months'], [2, 36, '36 Months'],
            [3, 12, '12 Months'], [3, 24, '24 Months'],
            [4, 12, '12 Months'], [4, 36, '36 Months'], [4, 48, '48 Months'],
            [5, 24, '24 Months'], [5, 36, '36 Months'], [5, 60, '60 Months'],
            [6, 12, '12 Months'], [6, 36, '36 Months'],
        ];

        $rows = [];
        foreach ($months as $i => [$installmentId, $month, $desc]) {
            $car = collect($cars)->firstWhere('id', $installmentId);
            $rows[] = [
                'installment_id' => $installmentId,
                'month' => $month,
                'description' => $desc,
                'nominal' => (int) ceil($car['price'] / $month * 1.05),
            ];
        }

        AvailableMonth::insert($rows);
    }
}