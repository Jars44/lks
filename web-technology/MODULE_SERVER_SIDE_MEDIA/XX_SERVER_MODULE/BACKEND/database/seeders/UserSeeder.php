<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $password = Hash::make('password');
        $rows = [
            ["id" => 1, "username" => "validator2", "password" => $password],
            ["id" => 2, "username" => "validator3", "password" => $password],
            ["id" => 3, "username" => "validator4", "password" => $password],
            ["id" => 4, "username" => "officer2", "password" => $password],
            ["id" => 5, "username" => "officer3", "password" => $password],
            ["id" => 6, "username" => "validator5", "password" => $password],
            ["id" => 7, "username" => "validator6", "password" => $password],
            ["id" => 8, "username" => "validator7", "password" => $password],
            ["id" => 9, "username" => "officer5", "password" => $password],
            ["id" => 10, "username" => "officer6", "password" => $password],
            ["id" => 11, "username" => "validator8", "password" => $password],
            ["id" => 12, "username" => "validator9", "password" => $password],
            ["id" => 13, "username" => "validator10", "password" => $password],
            ["id" => 14, "username" => "officer8", "password" => $password],
            ["id" => 15, "username" => "officer9", "password" => $password],
            ["id" => 16, "username" => "validator11", "password" => $password],
            ["id" => 17, "username" => "validator12", "password" => $password],
            ["id" => 18, "username" => "validator13", "password" => $password],
            ["id" => 19, "username" => "officer11", "password" => $password],
            ["id" => 20, "username" => "officer12", "password" => $password],
            ["id" => 21, "username" => "validator14", "password" => $password],
            ["id" => 22, "username" => "validator15", "password" => $password],
            ["id" => 23, "username" => "validator16", "password" => $password],
            ["id" => 24, "username" => "officer14", "password" => $password],
            ["id" => 25, "username" => "officer15", "password" => $password],
            ["id" => 26, "username" => "validator17", "password" => $password],
            ["id" => 27, "username" => "validator18", "password" => $password],
            ["id" => 28, "username" => "validator19", "password" => $password],
            ["id" => 29, "username" => "officer17", "password" => $password],
            ["id" => 30, "username" => "officer18", "password" => $password],
            ["id" => 31, "username" => "validator20", "password" => $password],
            ["id" => 32, "username" => "validator21", "password" => $password],
            ["id" => 33, "username" => "validator22", "password" => $password],
            ["id" => 34, "username" => "officer20", "password" => $password],
            ["id" => 35, "username" => "officer21", "password" => $password],
            ["id" => 36, "username" => "validator23", "password" => $password],
            ["id" => 37, "username" => "validator24", "password" => $password],
            ["id" => 38, "username" => "validator25", "password" => $password],
            ["id" => 39, "username" => "officer23", "password" => $password],
            ["id" => 40, "username" => "officer24", "password" => $password],
            ["id" => 41, "username" => "validator26", "password" => $password],
            ["id" => 42, "username" => "validator27", "password" => $password],
            ["id" => 43, "username" => "validator28", "password" => $password],
            ["id" => 44, "username" => "officer26", "password" => $password],
            ["id" => 45, "username" => "officer27", "password" => $password],
            ["id" => 46, "username" => "validator29", "password" => $password],
            ["id" => 47, "username" => "validator30", "password" => $password],
            ["id" => 48, "username" => "validator31", "password" => $password],
            ["id" => 49, "username" => "officer29", "password" => $password],
            ["id" => 50, "username" => "officer30", "password" => $password],
            ["id" => 51, "username" => "validator32", "password" => $password],
            ["id" => 52, "username" => "validator33", "password" => $password],
            ["id" => 53, "username" => "validator34", "password" => $password],
            ["id" => 54, "username" => "officer32", "password" => $password],
            ["id" => 55, "username" => "officer33", "password" => $password],
            ["id" => 56, "username" => "validator35", "password" => $password],
            ["id" => 57, "username" => "validator36", "password" => $password],
            ["id" => 58, "username" => "validator37", "password" => $password],
            ["id" => 59, "username" => "officer35", "password" => $password],
            ["id" => 60, "username" => "officer36", "password" => $password],
            ["id" => 61, "username" => "validator38", "password" => $password],
            ["id" => 62, "username" => "validator39", "password" => $password],
            ["id" => 63, "username" => "validator40", "password" => $password],
            ["id" => 64, "username" => "officer38", "password" => $password],
            ["id" => 65, "username" => "officer39", "password" => $password],
            ["id" => 66, "username" => "validator41", "password" => $password],
            ["id" => 67, "username" => "validator42", "password" => $password],
            ["id" => 68, "username" => "validator43", "password" => $password],
            ["id" => 69, "username" => "officer41", "password" => $password],
            ["id" => 70, "username" => "officer42", "password" => $password],
            ["id" => 71, "username" => "validator44", "password" => $password],
            ["id" => 72, "username" => "validator45", "password" => $password],
            ["id" => 73, "username" => "validator46", "password" => $password],
            ["id" => 74, "username" => "officer44", "password" => $password],
            ["id" => 75, "username" => "officer45", "password" => $password]
        ];

        User::insert($rows);
    }
}
