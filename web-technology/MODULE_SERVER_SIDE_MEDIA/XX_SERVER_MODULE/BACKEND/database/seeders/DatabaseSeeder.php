<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            RegionalSeeder::class,
            BrandSeeder::class,
            UserSeeder::class,
            ValidatorSeeder::class,
            SocietySeeder::class,
            InstallmentSeeder::class,
        ]);
    }
}