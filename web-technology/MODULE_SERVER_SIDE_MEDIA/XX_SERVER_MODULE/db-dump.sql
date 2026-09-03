-- MySQL dump for LKS Web Technology Car Instalment Platform
-- Generated from migrated + seeded database
--
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `available_month`;
CREATE TABLE `available_month` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `installment_id` int(11) NOT NULL,
  `month` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `nominal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `available_month` VALUES
(1, 1, 12, '12 Months', 78750000),
(2, 1, 24, '24 Months', 39375000),
(3, 1, 48, '48 Months', 19687500),
(4, 2, 12, '12 Months', 105000000),
(5, 2, 24, '24 Months', 52500000),
(6, 2, 36, '36 Months', 35000000),
(7, 3, 12, '12 Months', 65625000),
(8, 3, 24, '24 Months', 32812500),
(9, 4, 12, '12 Months', 157500000),
(10, 4, 36, '36 Months', 52500000),
(11, 4, 48, '48 Months', 39375000),
(12, 5, 24, '24 Months', 218750001),
(13, 5, 36, '36 Months', 145833334),
(14, 5, 60, '60 Months', 87500000),
(15, 6, 12, '12 Months', 74375000),
(16, 6, 36, '36 Months', 24791667);

DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `brand` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `brand` VALUES
(1, 'Toyota'),
(2, 'Yamaha'),
(3, 'BMW'),
(4, 'Bugatti'),
(5, 'Jeep');

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL PRIMARY KEY,
  `value` text NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL PRIMARY KEY,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` text NOT NULL,
  `exception` text NOT NULL,
  `failed_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `installment`;
CREATE TABLE `installment` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `brand_id` int(11) DEFAULT NULL,
  `cars` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `installment` VALUES
(1, 1, 'Toyota FT 86', 'Toyota FT 86 car is the best', 900000000),
(2, 1, 'Toyota Supra', 'Toyota Supra is a legendary sports car', 1200000000),
(3, 2, 'Yamaha GT', 'Yamaha GT premium vehicle', 750000000),
(4, 3, 'BMW M4', 'BMW M4 high performance coupe', 1800000000),
(5, 4, 'Bugatti Chiron', 'Bugatti Chiron hypercar', 5000000000),
(6, 5, 'Jeep Wrangler', 'Jeep Wrangler offroad SUV', 850000000);

DROP TABLE IF EXISTS `installment_apply_societies`;
CREATE TABLE `installment_apply_societies` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `notes` text DEFAULT NULL,
  `available_month_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `society_id` int(11) NOT NULL,
  `installment_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `installment_apply_status`;
CREATE TABLE `installment_apply_status` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `date` date NOT NULL,
  `society_id` int(11) NOT NULL,
  `installment_id` int(11) DEFAULT NULL,
  `available_month_id` int(11) DEFAULT NULL,
  `installment_apply_societies_id` int(11) DEFAULT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` text NOT NULL,
  `options` text DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `queue` varchar(255) NOT NULL,
  `payload` text NOT NULL,
  `attempts` int(11) NOT NULL,
  `reserved_at` int(11) DEFAULT NULL,
  `available_at` int(11) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_01_01_000100_create_regionals_table', 1),
(5, '2025_01_01_000101_create_brands_table', 1),
(6, '2025_01_01_000102_create_societies_table', 1),
(7, '2025_01_01_000103_create_installments_table', 1),
(8, '2025_01_01_000104_create_available_months_table', 1),
(9, '2025_01_01_000105_create_validators_table', 1),
(10, '2025_01_01_000106_create_validations_table', 1),
(11, '2025_01_01_000107_create_installment_apply_societies_table', 1),
(12, '2025_01_01_000108_create_installment_apply_statuses_table', 1),
(13, '2026_09_02_074622_create_personal_access_tokens_table', 1);

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL PRIMARY KEY,
  `token` varchar(255) NOT NULL,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `token` varchar(255) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` date DEFAULT NULL,
  `expires_at` date DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `regionals`;
CREATE TABLE `regionals` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `province` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `regionals` VALUES
(1, 'DKI Jakarta', 'Central Jakarta'),
(2, 'DKI Jakarta', 'South Jakarta'),
(3, 'West Java', 'Bandung');

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL PRIMARY KEY,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `societies`;
CREATE TABLE `societies` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `id_card_number` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `born_date` date NOT NULL,
  `gender` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `regional_id` int(11) NOT NULL,
  `login_tokens` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `societies` VALUES
(1, '20210001', '$2y$12$sHFI8lrc.pQ8spRLTauWB.i9wrV2aiRqHBTDNSPoF6gN7AgAgUF0O', 'Omar Gunawan', '1990-04-18', 'male', 'Jln. Baranang Siang No. 479, DKI Jakarta', 1, NULL),
(2, '20210002', '$2y$12$4SJfY6tZpsIpWgkitawCz.PfbabLHOWCbZXLJHk0Xpbnbo2LmtZ8K', 'Nilam Sinaga', '1998-09-11', 'female', 'Gg. Sukajadi No. 26, DKI Jakarta', 1, NULL),
(3, '20210003', '$2y$12$Up07c2IvI2VnHoYfl/FgqeBKWm5m13Kw9btm1rQmSS7KmAH66mDkG', 'Rosman Lailasari', '1983-02-12', 'male', 'Jln. Moch. Ramdan No. 242, DKI Jakarta', 1, NULL),
(4, '20210004', '$2y$12$z6oR9F9a4VTbF68SRflywuL7AmUR9JEIc1FM23P.sQkJJoMgNwFKG', 'Ifa Adriansyah', '1993-05-17', 'female', 'Gg. Setia Budi No. 215, DKI Jakarta', 1, NULL),
(5, '20210005', '$2y$12$KrLNXKE0Q58tP7/ZOWKkZeP.v1x7Kv5K5dNidz44j9pyNfJeJNCsq', 'Sakura Susanti', '1973-11-05', 'male', 'Kpg. B.Agam 1 No. 729, DKI Jakarta', 1, NULL),
(6, '20210006', '$2y$12$PX/VH32f7URrIFgKZOB4/.aQ61DUXMBTBb/24QSiY5rPKEgqTJdIu', 'Jail Utama', '2001-12-28', 'male', 'Kpg. Cikutra Timur No. 57, DKI Jakarta', 1, NULL),
(7, '20210007', '$2y$12$LrKCtF.Xi8stE5627bQk1O/UBmgNnczb0MMdeXPH.9bt4zNQTO0Dm', 'Gawati Wibowo', '1971-08-23', 'male', 'Kpg. Bara No. 346, DKI Jakarta', 1, NULL),
(8, '20210008', '$2y$12$qsjkUQB9RSroIP9KgE5l5.tMo.kdZjKT/PQbKthBg3a5/FjcA7tXu', 'Pia Rajata', '1976-08-04', 'male', 'Kpg. Yohanes No. 445, DKI Jakarta', 1, NULL),
(9, '20210009', '$2y$12$84qBYEbGfPqFvm43tK8LEedWqeuzbE7CqVeur5xbZLIgAlYRfvHae', 'Darmaji Suartini', '1999-10-05', 'male', 'Gg. Kusmanto No. 622, DKI Jakarta', 1, NULL),
(10, '20210010', '$2y$12$ueD81mByrpKPmChT8y6e7OG5673mGHO5JEI7S8ctRk8uifTucIZGe', 'Kiandra Tamba', '1988-05-31', 'male', 'Ki. Sutarto No. 66, DKI Jakarta', 1, NULL),
(11, '20210011', '$2y$12$CME/hXdDs18K5bapSnY5zO9HxxwNLCWYGOTJEhjzLqImIKGHWKYIe', 'Manah Thamrin', '1989-06-20', 'female', 'Jln. Baung No. 871, DKI Jakarta', 1, NULL),
(12, '20210012', '$2y$12$7dO2.mC6LqbGIq6bqbQ5Ju025WQzHfCsNYWV..znne7cwc1o.Srry', 'Banara Ardianto', '1978-10-27', 'male', 'Ki. Yos Sudarso No. 411, DKI Jakarta', 1, NULL),
(13, '20210013', '$2y$12$jwZ7EqpjynXngT2kiyhlhu5/1sXwLKzhS64B1bWBlGNKVCqVHVoxS', 'Anggabaya Mustofa', '1979-05-11', 'female', 'Psr. Pacuan Kuda No. 351, DKI Jakarta', 1, NULL),
(14, '20210014', '$2y$12$5p8Dyylc/gISqGoL./NoSOLIHeS2Lw0Bim13k4U7chYyLiwwqcYCS', 'Emong Purnawati', '1979-07-15', 'male', 'Jln. Jayawijaya No. 141, DKI Jakarta', 1, NULL),
(15, '20210015', '$2y$12$AiitqcDaNFe94x4QWQ.dgOj/e/LbcF0LVdv6e06trn6/Qsm3kFBQ2', 'Nardi Pertiwi', '1981-05-14', 'male', 'Psr. Barasak No. 554, DKI Jakarta', 1, NULL),
(16, '20210016', '$2y$12$cSncglx6wILjZf54DRjiI.0Ayy8edRo4Y1HppNQF/s3e54PwXx436', 'Ina Nasyiah', '1971-05-21', 'female', 'Ds. Suryo No. 100, DKI Jakarta', 2, NULL),
(17, '20210017', '$2y$12$33dgEKehmMcN/fe9ZfTW4u5HBgaipWj3N8gj31GjgW2HLU5LumXWm', 'Jinawi Wastuti', '1994-06-18', 'male', 'Ki. Sugiono No. 918, DKI Jakarta', 2, NULL),
(18, '20210018', '$2y$12$vjcr91Ou3oSBfAHLP4oZOu9W0TJBbKTkMx/y4bYRv5NDLoVAGCkOm', 'Marsudi Utama', '1979-06-04', 'female', 'Kpg. Cikapayang No. 229, DKI Jakarta', 2, NULL),
(19, '20210019', '$2y$12$GZwDu9TdCmOi6kz.aEQCUu8fzFXYSe.FatkWF7JWrgFnE5E2Ue9Iq', 'Ilsa Gunarto', '1992-06-11', 'female', 'Gg. Baing No. 871, DKI Jakarta', 2, NULL),
(20, '20210020', '$2y$12$KWGs/XGciTHT.HF0j48S7uDxWcSmofHBXceAlWFJ1XT0NiMg8Vrha', 'Hani Pratiwi', '1990-07-10', 'male', 'Dk. Yap Tjwan Bing No. 528, DKI Jakarta', 2, NULL),
(21, '20210021', '$2y$12$ucPNvHdsYgqBUbYdwEFAg.U1gD5DH6cmXdO8lEs6i4OmAG/3i.QWO', 'Najwa Pratiwi', '1996-11-05', 'male', 'Kpg. Raden No. 688, DKI Jakarta', 2, NULL),
(22, '20210022', '$2y$12$mHnKRuphtIxf/Sqtw54cv.lVLoVGuq9VsZ8a0XJGinU2zbNNrRtaa', 'Samiah Haryanto', '1985-10-26', 'male', 'Gg. Juanda No. 863, DKI Jakarta', 2, NULL),
(23, '20210023', '$2y$12$TQVl7a.bEhlct5QV65SRSOLDnwSOk1yXtLKv93AYpjbAalqK1ffUC', 'Olga Safitri', '1971-03-04', 'male', 'Psr. Ir. H. Juanda No. 728, DKI Jakarta', 2, NULL),
(24, '20210024', '$2y$12$L07NuUG.PsM6r6P1iQ9IVuIsmL3BLTn/9iquZYZUvWorqUo/rGnom', 'Halim Winarsih', '1974-11-16', 'male', 'Dk. Nakula No. 730, DKI Jakarta', 2, NULL),
(25, '20210025', '$2y$12$UkodSW7YIOWY75qO143ll.JjomqAxE0NGXyg1n4ZpyCXnb7G7Ki06', 'Vivi Widodo', '1988-09-19', 'male', 'Kpg. Astana Anyar No. 983, DKI Jakarta', 2, NULL),
(26, '20210026', '$2y$12$wlpyq/HSyoGOZUM5Gq1hPuKeEVtI/uwj8w5wEyLb8uDy0B24056UW', 'Dian Firmansyah', '1985-04-01', 'male', 'Kpg. Baha No. 855, DKI Jakarta', 2, NULL),
(27, '20210027', '$2y$12$jlY4AgHTbrZSF6C2Nl4ZSOQkMZJBGb.aANeR2NfrdKsW1vaa3t4zC', 'Patricia Usada', '1986-08-28', 'male', 'Psr. Ters. Jakarta No. 993, DKI Jakarta', 2, NULL),
(28, '20210028', '$2y$12$d6V7gDDXwFXv/OlnE7x0JeHfuKWeWJo8htO0lIO9M/C/cC0SY8JOO', 'Soleh Mandasari', '1988-09-28', 'female', 'Ki. Flores No. 869, DKI Jakarta', 2, NULL),
(29, '20210029', '$2y$12$OW.3O2wRcE27fSL8LVk/8u8nJddsBWA7RAGFN1zEGjtA3djBB7FXu', 'Kamal Pranowo', '1976-08-10', 'male', 'Jln. Baung No. 80, DKI Jakarta', 2, NULL),
(30, '20210030', '$2y$12$ifV9AGlEM3T5R0ZpcwPWb.gdJvhtBpkg/WdWwZIhBKhF8alRGBrN6', 'Ade Kusmawati', '1996-08-29', 'male', 'Jln. Kiaracondong No. 398, DKI Jakarta', 2, NULL),
(31, '20210031', '$2y$12$d4kntUN2KZ//iEOyy4Bz0uJuQPar.JUEX0iUqQijQKN0lvu84mMgO', 'Irwan Sinaga', '1976-10-06', 'female', 'Dk. Basmol Raya No. 714, West Java', 3, NULL),
(32, '20210032', '$2y$12$JsuNUZygbNUXBjeTAHVXzerQ/BvI.caUJk7FxjMafYiFpUFeTSKY.', 'Lulut Lestari', '1981-03-31', 'male', 'Ds. Cihampelas No. 933, West Java', 3, NULL),
(33, '20210033', '$2y$12$fjJL4kWDBQIRC7.rIZ1g5eUKWOe0rAiPbEy/mJhu2S7I.Kw96aECi', 'Balijan Rahimah', '1972-04-25', 'female', 'Ki. Ciwastra No. 539, West Java', 3, NULL),
(34, '20210034', '$2y$12$bETw2rpJJURua/M2uWrw5.W62MtoVqrqXZK8rLkRIcU6O9j5QisbW', 'Kasiyah Sitompul', '1975-01-14', 'male', 'Dk. Sutarto No. 434, West Java', 3, NULL),
(35, '20210035', '$2y$12$FQo.2skLnTnRpz5UYNlY7u1Ojrpe78w8mJdpSih10mEGTZI4MQyKS', 'Wulan Nasyidah', '1974-11-04', 'male', 'Dk. Mahakam No. 367, West Java', 3, NULL),
(36, '20210036', '$2y$12$5tTRlcmOJdlzYC7x1vemmeXj.4J563Mqjj8nqq.UhJ42sLOd4PyPK', 'Damar Palastri', '1981-03-24', 'female', 'Jr. Teuku Umar No. 547, West Java', 3, NULL),
(37, '20210037', '$2y$12$TRx9IzMecmLgzab.ivNAf.Z09ZM/2UopMJiw6Hn15EfpO7oASXk.u', 'Gamanto Simanjuntak', '1972-01-13', 'female', 'Jln. Salam No. 421, West Java', 3, NULL),
(38, '20210038', '$2y$12$T00PNXSA/SB7fWP5M3dvEeTFzFytxKGhlkua4JHnRAlKIsIiX1k8S', 'Lukita Gunarto', '1998-11-27', 'female', 'Jr. HOS. Cjokroaminoto (Pasirkaliki) No. 9, West Java', 3, NULL),
(39, '20210039', '$2y$12$svZcVYhXu2Gkj6rIW3uvj.Tmg6RT/Q5wkXUUl2w3W5U.ALo0VDGEy', 'Malika Nashiruddin', '1989-07-05', 'male', 'Psr. Kartini No. 960, West Java', 3, NULL),
(40, '20210040', '$2y$12$kSN35.NgGHrcSv0vbIK5beuSjSKTU1cTC62O.GW6/pYJOKuToynvu', 'Siska Hutapea', '1972-03-30', 'female', 'Ki. Wora Wari No. 501, West Java', 3, NULL),
(41, '20210041', '$2y$12$5XtWooewtIWjHCZ/8AwebOSrvAa.QJulhGFIu61wDLbwFsRtsoH5G', 'Laras Sirait', '1971-01-13', 'male', 'Psr. Basmol Raya No. 859, West Java', 3, NULL),
(42, '20210042', '$2y$12$vD0x5aLt9EyBWA7MuohVL.T/L4BUqeMFOAh/CYBsRFIFBLm8SqLvW', 'Embuh Mulyani', '1996-08-05', 'male', 'Kpg. Wahidin No. 512, West Java', 3, NULL),
(43, '20210043', '$2y$12$2P.Qdi02tx3GPOOx/Y3MSO2mPj5LdDB1.4vZfQSjgxFn9bpZbbyWa', 'Mutia Nashiruddin', '1985-05-08', 'female', 'Ds. Hang No. 765, West Java', 3, NULL),
(44, '20210044', '$2y$12$W8kwQh1e5Wln6dSw2XK9ge06QcVoBWoI6TBqsl2K6yzg76UacgnUa', 'Pangestu Lazuardi', '2001-08-02', 'male', 'Dk. Bass No. 886, West Java', 3, NULL),
(45, '20210045', '$2y$12$YhWLFGGhfb4i/zTLhXJJ0ebF7xylOa/Op3l9nqmY5jQ/D72x5S.tu', 'Gaduh Suwarno', '1971-07-27', 'female', 'Psr. Basuki No. 591, West Java', 3, NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` VALUES
(1, 'validator2', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(2, 'validator3', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(3, 'validator4', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(4, 'officer2', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(5, 'officer3', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(6, 'validator5', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(7, 'validator6', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(8, 'validator7', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(9, 'officer5', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(10, 'officer6', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(11, 'validator8', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(12, 'validator9', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(13, 'validator10', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(14, 'officer8', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(15, 'officer9', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(16, 'validator11', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(17, 'validator12', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(18, 'validator13', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(19, 'officer11', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(20, 'officer12', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(21, 'validator14', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(22, 'validator15', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(23, 'validator16', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(24, 'officer14', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(25, 'officer15', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(26, 'validator17', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(27, 'validator18', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(28, 'validator19', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(29, 'officer17', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(30, 'officer18', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(31, 'validator20', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(32, 'validator21', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(33, 'validator22', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(34, 'officer20', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(35, 'officer21', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(36, 'validator23', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(37, 'validator24', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(38, 'validator25', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(39, 'officer23', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(40, 'officer24', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(41, 'validator26', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(42, 'validator27', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(43, 'validator28', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(44, 'officer26', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(45, 'officer27', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(46, 'validator29', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(47, 'validator30', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(48, 'validator31', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(49, 'officer29', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(50, 'officer30', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(51, 'validator32', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(52, 'validator33', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(53, 'validator34', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(54, 'officer32', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(55, 'officer33', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(56, 'validator35', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(57, 'validator36', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(58, 'validator37', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(59, 'officer35', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(60, 'officer36', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(61, 'validator38', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(62, 'validator39', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(63, 'validator40', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(64, 'officer38', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(65, 'officer39', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(66, 'validator41', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(67, 'validator42', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(68, 'validator43', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(69, 'officer41', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(70, 'officer42', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(71, 'validator44', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(72, 'validator45', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(73, 'validator46', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(74, 'officer44', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL),
(75, 'officer45', '$2y$12$YzmwqmHj9zs9u.le6PGis.a3CkQiy3r42cDus/FZVY/LfC6klbk9.', NULL);

DROP TABLE IF EXISTS `validations`;
CREATE TABLE `validations` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `society_id` int(11) NOT NULL,
  `validator_id` int(11) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `job` varchar(255) DEFAULT NULL,
  `job_description` text DEFAULT NULL,
  `income` int(11) DEFAULT NULL,
  `reason_accepted` text DEFAULT NULL,
  `validator_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `validators`;
CREATE TABLE `validators` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `user_id` int(11) NOT NULL,
  `role` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `validators` VALUES
(1, 1, 'validator', 'Kamila Wibisono'),
(2, 2, 'validator', 'Maya Kusmawati'),
(3, 3, 'validator', 'Gaduh Prasetyo'),
(4, 4, 'officer', 'Indra Usamah'),
(5, 5, 'officer', 'Kalim Yulianti'),
(6, 6, 'validator', 'Eva Mandasari'),
(7, 7, 'validator', 'Jatmiko Handayani'),
(8, 8, 'validator', 'Ratna Riyanti'),
(9, 9, 'officer', 'Ayu Iswahyudi'),
(10, 10, 'officer', 'Azalea Mulyani'),
(11, 11, 'validator', 'Hesti Andriani'),
(12, 12, 'validator', 'Kusuma Nasyidah'),
(13, 13, 'validator', 'Gaman Sihotang'),
(14, 14, 'officer', 'Bella Habibi'),
(15, 15, 'officer', 'Titin Agustina'),
(16, 16, 'validator', 'Ami Kurniawan'),
(17, 17, 'validator', 'Hasta Riyanti'),
(18, 18, 'validator', 'Laila Hassanah'),
(19, 19, 'officer', 'Martana Hakim'),
(20, 20, 'officer', 'Aurora Siregar'),
(21, 21, 'validator', 'Tina Prastuti'),
(22, 22, 'validator', 'Farhunnisa Widiastuti'),
(23, 23, 'validator', 'Olga Hartati'),
(24, 24, 'officer', 'Tira Purwanti'),
(25, 25, 'officer', 'Darmanto Nuraini'),
(26, 26, 'validator', 'Okto Pradana'),
(27, 27, 'validator', 'Dian Hariyah'),
(28, 28, 'validator', 'Ganda Gunawan'),
(29, 29, 'officer', 'Najam Rajata'),
(30, 30, 'officer', 'Hani Maulana'),
(31, 31, 'validator', 'Galak Uyainah'),
(32, 32, 'validator', 'Eka Suartini'),
(33, 33, 'validator', 'Asmianto Kusumo'),
(34, 34, 'officer', 'Prayitna Yuniar'),
(35, 35, 'officer', 'Banawi Prastuti'),
(36, 36, 'validator', 'Kania Maulana'),
(37, 37, 'validator', 'Salwa Mansur'),
(38, 38, 'validator', 'Dagel Puspita'),
(39, 39, 'officer', 'Jamal Rahimah'),
(40, 40, 'officer', 'Ami Prastuti'),
(41, 41, 'validator', 'Puput Suryatmi'),
(42, 42, 'validator', 'Hani Uyainah'),
(43, 43, 'validator', 'Aditya Kusmawati'),
(44, 44, 'officer', 'Agnes Permadi'),
(45, 45, 'officer', 'Edison Susanti'),
(46, 46, 'validator', 'Winda Pertiwi'),
(47, 47, 'validator', 'Emil Nuraini'),
(48, 48, 'validator', 'Raden Sinaga'),
(49, 49, 'officer', 'Sadina Nurdiyanti'),
(50, 50, 'officer', 'Jessica Habibi'),
(51, 51, 'validator', 'Maya Napitupulu'),
(52, 52, 'validator', 'Nurul Utama'),
(53, 53, 'validator', 'Asmianto Ardianto'),
(54, 54, 'officer', 'Cawisono Wulandari'),
(55, 55, 'officer', 'Candrakanta Palastri'),
(56, 56, 'validator', 'Uda Sitorus'),
(57, 57, 'validator', 'Paiman Zulaika'),
(58, 58, 'validator', 'Eko Putra'),
(59, 59, 'officer', 'Mariadi Samosir'),
(60, 60, 'officer', 'Chandra Januar'),
(61, 61, 'validator', 'Padma Hariyah'),
(62, 62, 'validator', 'Taufik Uyainah'),
(63, 63, 'validator', 'Maria Laksmiwati'),
(64, 64, 'officer', 'Harjo Tamba'),
(65, 65, 'officer', 'Vanesa Palastri'),
(66, 66, 'validator', 'Diah Mulyani'),
(67, 67, 'validator', 'Syahrini Farida'),
(68, 68, 'validator', 'Fitria Winarsih'),
(69, 69, 'officer', 'Clara Pratiwi'),
(70, 70, 'officer', 'Dian Habibi'),
(71, 71, 'validator', 'Aurora Wulandari'),
(72, 72, 'validator', 'Safina Hassanah'),
(73, 73, 'validator', 'Cinthia Adriansyah'),
(74, 74, 'officer', 'Wadi Prakasa'),
(75, 75, 'officer', 'Parman Namaga');

SET FOREIGN_KEY_CHECKS = 1;
