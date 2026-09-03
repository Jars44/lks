<?php

namespace Database\Seeders;

use App\Models\Society;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class SocietySeeder extends Seeder
{
    public function run(): void
    {
        Society::insert([
            ['id' => 1, 'id_card_number' => '20210001', 'password' => Hash::make('121212'), 'name' => 'Omar Gunawan', 'born_date' => '1990-04-18', 'gender' => 'male', 'address' => 'Jln. Baranang Siang No. 479, DKI Jakarta', 'regional_id' => 1],
            ['id' => 2, 'id_card_number' => '20210002', 'password' => Hash::make('121212'), 'name' => 'Nilam Sinaga', 'born_date' => '1998-09-11', 'gender' => 'female', 'address' => 'Gg. Sukajadi No. 26, DKI Jakarta', 'regional_id' => 1],
            ['id' => 3, 'id_card_number' => '20210003', 'password' => Hash::make('121212'), 'name' => 'Rosman Lailasari', 'born_date' => '1983-02-12', 'gender' => 'male', 'address' => 'Jln. Moch. Ramdan No. 242, DKI Jakarta', 'regional_id' => 1],
            ['id' => 4, 'id_card_number' => '20210004', 'password' => Hash::make('121212'), 'name' => 'Ifa Adriansyah', 'born_date' => '1993-05-17', 'gender' => 'female', 'address' => 'Gg. Setia Budi No. 215, DKI Jakarta', 'regional_id' => 1],
            ['id' => 5, 'id_card_number' => '20210005', 'password' => Hash::make('121212'), 'name' => 'Sakura Susanti', 'born_date' => '1973-11-05', 'gender' => 'male', 'address' => 'Kpg. B.Agam 1 No. 729, DKI Jakarta', 'regional_id' => 1],
            ['id' => 6, 'id_card_number' => '20210006', 'password' => Hash::make('121212'), 'name' => 'Jail Utama', 'born_date' => '2001-12-28', 'gender' => 'male', 'address' => 'Kpg. Cikutra Timur No. 57, DKI Jakarta', 'regional_id' => 1],
            ['id' => 7, 'id_card_number' => '20210007', 'password' => Hash::make('121212'), 'name' => 'Gawati Wibowo', 'born_date' => '1971-08-23', 'gender' => 'male', 'address' => 'Kpg. Bara No. 346, DKI Jakarta', 'regional_id' => 1],
            ['id' => 8, 'id_card_number' => '20210008', 'password' => Hash::make('121212'), 'name' => 'Pia Rajata', 'born_date' => '1976-08-04', 'gender' => 'male', 'address' => 'Kpg. Yohanes No. 445, DKI Jakarta', 'regional_id' => 1],
            ['id' => 9, 'id_card_number' => '20210009', 'password' => Hash::make('121212'), 'name' => 'Darmaji Suartini', 'born_date' => '1999-10-05', 'gender' => 'male', 'address' => 'Gg. Kusmanto No. 622, DKI Jakarta', 'regional_id' => 1],
            ['id' => 10, 'id_card_number' => '20210010', 'password' => Hash::make('121212'), 'name' => 'Kiandra Tamba', 'born_date' => '1988-05-31', 'gender' => 'male', 'address' => 'Ki. Sutarto No. 66, DKI Jakarta', 'regional_id' => 1],
            ['id' => 11, 'id_card_number' => '20210011', 'password' => Hash::make('121212'), 'name' => 'Manah Thamrin', 'born_date' => '1989-06-20', 'gender' => 'female', 'address' => 'Jln. Baung No. 871, DKI Jakarta', 'regional_id' => 1],
            ['id' => 12, 'id_card_number' => '20210012', 'password' => Hash::make('121212'), 'name' => 'Banara Ardianto', 'born_date' => '1978-10-27', 'gender' => 'male', 'address' => 'Ki. Yos Sudarso No. 411, DKI Jakarta', 'regional_id' => 1],
            ['id' => 13, 'id_card_number' => '20210013', 'password' => Hash::make('121212'), 'name' => 'Anggabaya Mustofa', 'born_date' => '1979-05-11', 'gender' => 'female', 'address' => 'Psr. Pacuan Kuda No. 351, DKI Jakarta', 'regional_id' => 1],
            ['id' => 14, 'id_card_number' => '20210014', 'password' => Hash::make('121212'), 'name' => 'Emong Purnawati', 'born_date' => '1979-07-15', 'gender' => 'male', 'address' => 'Jln. Jayawijaya No. 141, DKI Jakarta', 'regional_id' => 1],
            ['id' => 15, 'id_card_number' => '20210015', 'password' => Hash::make('121212'), 'name' => 'Nardi Pertiwi', 'born_date' => '1981-05-14', 'gender' => 'male', 'address' => 'Psr. Barasak No. 554, DKI Jakarta', 'regional_id' => 1],
            ['id' => 16, 'id_card_number' => '20210016', 'password' => Hash::make('121212'), 'name' => 'Ina Nasyiah', 'born_date' => '1971-05-21', 'gender' => 'female', 'address' => 'Ds. Suryo No. 100, DKI Jakarta', 'regional_id' => 2],
            ['id' => 17, 'id_card_number' => '20210017', 'password' => Hash::make('121212'), 'name' => 'Jinawi Wastuti', 'born_date' => '1994-06-18', 'gender' => 'male', 'address' => 'Ki. Sugiono No. 918, DKI Jakarta', 'regional_id' => 2],
            ['id' => 18, 'id_card_number' => '20210018', 'password' => Hash::make('121212'), 'name' => 'Marsudi Utama', 'born_date' => '1979-06-04', 'gender' => 'female', 'address' => 'Kpg. Cikapayang No. 229, DKI Jakarta', 'regional_id' => 2],
            ['id' => 19, 'id_card_number' => '20210019', 'password' => Hash::make('121212'), 'name' => 'Ilsa Gunarto', 'born_date' => '1992-06-11', 'gender' => 'female', 'address' => 'Gg. Baing No. 871, DKI Jakarta', 'regional_id' => 2],
            ['id' => 20, 'id_card_number' => '20210020', 'password' => Hash::make('121212'), 'name' => 'Hani Pratiwi', 'born_date' => '1990-07-10', 'gender' => 'male', 'address' => 'Dk. Yap Tjwan Bing No. 528, DKI Jakarta', 'regional_id' => 2],
            ['id' => 21, 'id_card_number' => '20210021', 'password' => Hash::make('121212'), 'name' => 'Najwa Pratiwi', 'born_date' => '1996-11-05', 'gender' => 'male', 'address' => 'Kpg. Raden No. 688, DKI Jakarta', 'regional_id' => 2],
            ['id' => 22, 'id_card_number' => '20210022', 'password' => Hash::make('121212'), 'name' => 'Samiah Haryanto', 'born_date' => '1985-10-26', 'gender' => 'male', 'address' => 'Gg. Juanda No. 863, DKI Jakarta', 'regional_id' => 2],
            ['id' => 23, 'id_card_number' => '20210023', 'password' => Hash::make('121212'), 'name' => 'Olga Safitri', 'born_date' => '1971-03-04', 'gender' => 'male', 'address' => 'Psr. Ir. H. Juanda No. 728, DKI Jakarta', 'regional_id' => 2],
            ['id' => 24, 'id_card_number' => '20210024', 'password' => Hash::make('121212'), 'name' => 'Halim Winarsih', 'born_date' => '1974-11-16', 'gender' => 'male', 'address' => 'Dk. Nakula No. 730, DKI Jakarta', 'regional_id' => 2],
            ['id' => 25, 'id_card_number' => '20210025', 'password' => Hash::make('121212'), 'name' => 'Vivi Widodo', 'born_date' => '1988-09-19', 'gender' => 'male', 'address' => 'Kpg. Astana Anyar No. 983, DKI Jakarta', 'regional_id' => 2],
            ['id' => 26, 'id_card_number' => '20210026', 'password' => Hash::make('121212'), 'name' => 'Dian Firmansyah', 'born_date' => '1985-04-01', 'gender' => 'male', 'address' => 'Kpg. Baha No. 855, DKI Jakarta', 'regional_id' => 2],
            ['id' => 27, 'id_card_number' => '20210027', 'password' => Hash::make('121212'), 'name' => 'Patricia Usada', 'born_date' => '1986-08-28', 'gender' => 'male', 'address' => 'Psr. Ters. Jakarta No. 993, DKI Jakarta', 'regional_id' => 2],
            ['id' => 28, 'id_card_number' => '20210028', 'password' => Hash::make('121212'), 'name' => 'Soleh Mandasari', 'born_date' => '1988-09-28', 'gender' => 'female', 'address' => 'Ki. Flores No. 869, DKI Jakarta', 'regional_id' => 2],
            ['id' => 29, 'id_card_number' => '20210029', 'password' => Hash::make('121212'), 'name' => 'Kamal Pranowo', 'born_date' => '1976-08-10', 'gender' => 'male', 'address' => 'Jln. Baung No. 80, DKI Jakarta', 'regional_id' => 2],
            ['id' => 30, 'id_card_number' => '20210030', 'password' => Hash::make('121212'), 'name' => 'Ade Kusmawati', 'born_date' => '1996-08-29', 'gender' => 'male', 'address' => 'Jln. Kiaracondong No. 398, DKI Jakarta', 'regional_id' => 2],
            ['id' => 31, 'id_card_number' => '20210031', 'password' => Hash::make('121212'), 'name' => 'Irwan Sinaga', 'born_date' => '1976-10-06', 'gender' => 'female', 'address' => 'Dk. Basmol Raya No. 714, West Java', 'regional_id' => 3],
            ['id' => 32, 'id_card_number' => '20210032', 'password' => Hash::make('121212'), 'name' => 'Lulut Lestari', 'born_date' => '1981-03-31', 'gender' => 'male', 'address' => 'Ds. Cihampelas No. 933, West Java', 'regional_id' => 3],
            ['id' => 33, 'id_card_number' => '20210033', 'password' => Hash::make('121212'), 'name' => 'Balijan Rahimah', 'born_date' => '1972-04-25', 'gender' => 'female', 'address' => 'Ki. Ciwastra No. 539, West Java', 'regional_id' => 3],
            ['id' => 34, 'id_card_number' => '20210034', 'password' => Hash::make('121212'), 'name' => 'Kasiyah Sitompul', 'born_date' => '1975-01-14', 'gender' => 'male', 'address' => 'Dk. Sutarto No. 434, West Java', 'regional_id' => 3],
            ['id' => 35, 'id_card_number' => '20210035', 'password' => Hash::make('121212'), 'name' => 'Wulan Nasyidah', 'born_date' => '1974-11-04', 'gender' => 'male', 'address' => 'Dk. Mahakam No. 367, West Java', 'regional_id' => 3],
            ['id' => 36, 'id_card_number' => '20210036', 'password' => Hash::make('121212'), 'name' => 'Damar Palastri', 'born_date' => '1981-03-24', 'gender' => 'female', 'address' => 'Jr. Teuku Umar No. 547, West Java', 'regional_id' => 3],
            ['id' => 37, 'id_card_number' => '20210037', 'password' => Hash::make('121212'), 'name' => 'Gamanto Simanjuntak', 'born_date' => '1972-01-13', 'gender' => 'female', 'address' => 'Jln. Salam No. 421, West Java', 'regional_id' => 3],
            ['id' => 38, 'id_card_number' => '20210038', 'password' => Hash::make('121212'), 'name' => 'Lukita Gunarto', 'born_date' => '1998-11-27', 'gender' => 'female', 'address' => 'Jr. HOS. Cjokroaminoto (Pasirkaliki) No. 9, West Java', 'regional_id' => 3],
            ['id' => 39, 'id_card_number' => '20210039', 'password' => Hash::make('121212'), 'name' => 'Malika Nashiruddin', 'born_date' => '1989-07-05', 'gender' => 'male', 'address' => 'Psr. Kartini No. 960, West Java', 'regional_id' => 3],
            ['id' => 40, 'id_card_number' => '20210040', 'password' => Hash::make('121212'), 'name' => 'Siska Hutapea', 'born_date' => '1972-03-30', 'gender' => 'female', 'address' => 'Ki. Wora Wari No. 501, West Java', 'regional_id' => 3],
            ['id' => 41, 'id_card_number' => '20210041', 'password' => Hash::make('121212'), 'name' => 'Laras Sirait', 'born_date' => '1971-01-13', 'gender' => 'male', 'address' => 'Psr. Basmol Raya No. 859, West Java', 'regional_id' => 3],
            ['id' => 42, 'id_card_number' => '20210042', 'password' => Hash::make('121212'), 'name' => 'Embuh Mulyani', 'born_date' => '1996-08-05', 'gender' => 'male', 'address' => 'Kpg. Wahidin No. 512, West Java', 'regional_id' => 3],
            ['id' => 43, 'id_card_number' => '20210043', 'password' => Hash::make('121212'), 'name' => 'Mutia Nashiruddin', 'born_date' => '1985-05-08', 'gender' => 'female', 'address' => 'Ds. Hang No. 765, West Java', 'regional_id' => 3],
            ['id' => 44, 'id_card_number' => '20210044', 'password' => Hash::make('121212'), 'name' => 'Pangestu Lazuardi', 'born_date' => '2001-08-02', 'gender' => 'male', 'address' => 'Dk. Bass No. 886, West Java', 'regional_id' => 3],
            ['id' => 45, 'id_card_number' => '20210045', 'password' => Hash::make('121212'), 'name' => 'Gaduh Suwarno', 'born_date' => '1971-07-27', 'gender' => 'female', 'address' => 'Psr. Basuki No. 591, West Java', 'regional_id' => 3],
        ]);
    }
}
