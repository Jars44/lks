# LKS Project Repository

Repositori ini berisi kumpulan proyek dan modul untuk kompetisi LKS (Lomba Kompetensi Siswa) di bidang IT Software, AI, dan Web Technology. Proyek ini mencakup berbagai aplikasi dan implementasi dari tingkat dasar hingga lanjutan, termasuk aplikasi mobile, desktop, API, web games, dan model machine learning.

## Prasyarat

Sebelum menjalankan proyek ini, pastikan Anda memiliki perangkat lunak berikut terinstall:

- **Python 3.8+** (untuk modul AI)
- **Android Studio** (untuk aplikasi Android)
- **Visual Studio** (untuk aplikasi desktop)
- **Node.js** (jika diperlukan untuk web development)
- **Database Server** (MSSQL, MySQL, atau SQLite sesuai proyek)
- **Git** (untuk cloning repository)

## Daftar Isi

- [Deskripsi Proyek](#deskripsi-proyek)
- [Prasyarat](#prasyarat)
- [Struktur Proyek](#struktur-proyek)
- [Modul AI (LKS AI Kabupaten Malang 2025)](#modul-ai-lks-ai-kabupaten-malang-2025)
- [Modul IT Software](#modul-it-software)
- [Modul Web Technology](#modul-web-technology)
- [Cara Menjalankan](#cara-menjalankan)
- [Teknologi yang Digunakan](#teknologi-yang-digunakan)
- [Screenshot](#screenshot)
- [Tips dan Troubleshooting](#tips-dan-troubleshooting)
- [Kontribusi](#kontribusi)
- [Lisensi](#lisensi)

## Struktur Proyek

```!/bin/bash
lks-project/
├── ai/
│   ├── gui.py
│   ├── main.ipynb
│   ├── main.py
│   ├── assets/
│   │   ├── Datasset LKS AI Kabupaten Malang 2025.csv.xls
│   │   ├── Petunjuk Teknis LKS Kabupaten Malang 2025.pdf
│   │   └── Suplemen Dataset LKS AI Kabupaten Malang 2025.docx
│   └── Panduan_LKS_AI_Modul_BCD.md
├── it-software/
│   ├── Android/
│   │   ├── EsemkaBakery/
│   │   │   ├── Esemka Bakery.pdf
│   │   │   └── Backend/
│   │   ├── EsemkaGym/
│   │   ├── EsemkaPetition/
│   │   ├── EsemkaRecipes/
│   │   ├── EzemCoffie/
│   │   └── ...
│   ├── Api/
│   │   ├── EsemkaRailways/
│   │   └── EsemkaStore/
│   ├── Desktop/
│   │   ├── BromoAirlines/
│   │   ├── EsemkaCorporation/
│   │   ├── EsemkaFoodcourt/
│   │   ├── EsemkaPolling/
│   │   ├── EsemkaTaskMaster/
│   │   ├── EsemNet/
│   │   ├── QuizinAja/
│   │   ├── UbigPos/
│   │   └── ...
│   └── Pack Soal/
├── web-technology/
│   ├── MODULE_CLIENT_SIDE.docx
│   ├── MODULE_SERVER_SIDE.docx
│   ├── MODULE_CLIENT_MEDIA/
│   │   ├── index.html
│   │   ├── script.js
│   │   ├── style.css
│   │   ├── Example/
│   │   └── Images/
│   └── MODULE_SERVER_SIDE_MEDIA/
│       ├── accounts/
│       ├── database/
│       └── templates-gui/
├── .gitattributes
└── .gitignore
```

## Modul AI (LKS AI Kabupaten Malang 2025)

### Modul B: Data Classification (120 Menit)

- **Tujuan**: Membangun model klasifikasi menggunakan algoritma Decision Tree
- **Fitur**: Preprocessing data, split train-test (80:20), implementasi manual Decision Tree, visualisasi pohon keputusan, analisis feature importance
- **File Utama**: `ai/main.py`, `ai/main.ipynb`

### Modul C: Evaluasi Model (60 Menit)

- **Tujuan**: Mengevaluasi performa model klasifikasi
- **Fitur**: Confusion Matrix, metrik evaluasi (Accuracy, Precision, Recall, F1-Score), visualisasi hasil, optimasi model
- **File Utama**: `ai/main.py`

### Modul D: GUI untuk Uji Coba Data Baru (120 Menit)

- **Tujuan**: Membangun GUI untuk testing model
- **Fitur**: Input fields dinamis, prediksi real-time, validasi input, error handling
- **File Utama**: `ai/gui.py`

## Modul IT Software

### Android Applications

- **EsemkaBakery**: Aplikasi pemesanan kue dengan fitur login, register, home, search, detail, order, checkout
- **EsemkaGym**: Aplikasi gym management
- **EsemkaPetition**: Aplikasi pengaduan/petition
- **EsemkaRecipes**: Aplikasi resep masakan
- **EzemCoffie**: Aplikasi kopi

### Desktop Applications

- **BromoAirlines**: Sistem manajemen tiket penerbangan dengan fitur admin (master data) dan customer (pencarian & pembelian tiket)
- **EsemkaCorporation**: Sistem manajemen perusahaan
- **EsemkaFoodcourt**: Sistem manajemen foodcourt
- **EsemkaPolling**: Sistem polling
- **EsemkaTaskMaster**: Task management system
- **EsemNet**: Sistem jaringan
- **QuizinAja**: Aplikasi kuis
- **UbigPos**: Point of Sale system

### API Projects

- **EsemkaRailways**: API untuk sistem kereta api
- **EsemkaStore**: API untuk toko online

## Modul Web Technology

### Client-Side Media Module

- **BOMSKUY Game**: Game bom berbasis web dengan fitur:
  - Input username dan difficulty level
  - Grid-based gameplay dengan player, walls, enemies, bombs
  - Pause/resume functionality
  - Leaderboard system
  - Game over screen dengan stats
- **File Utama**: `web-technology/MODULE_CLIENT_MEDIA/index.html`, `script.js`, `style.css`

### Server-Side Media Module

- **Accounts**: Sistem manajemen akun
- **Database**: Konfigurasi database
- **Templates-GUI**: Template untuk interface

## Cara Menjalankan

### AI Module

1. Pastikan Python 3.8+ terinstall. Install dependencies dengan `pip install numpy matplotlib scikit-learn tkinter`.
2. Jalankan `python ai/main.py` untuk training model klasifikasi Decision Tree.
3. Jalankan `python ai/gui.py` untuk membuka GUI testing model.
4. Ikuti panduan di `ai/Panduan_LKS_AI_Modul_BCD.md` untuk detail lebih lanjut.

### Android Apps

1. Buka Android Studio dan import project dari folder `it-software/Android/[NamaApp]`.
2. Setup SDK dan emulator jika diperlukan.
3. Build dan run aplikasi di device/emulator.
4. Jika ada backend, jalankan API server terlebih dahulu (lihat folder Backend).

### Desktop Apps

1. Buka Visual Studio dan load project dari folder `it-software/Desktop/[NamaApp]`.
2. Setup database: Import file .sql ke MSSQL/MySQL server.
3. Update connection string di kode aplikasi.
4. Build dan run aplikasi.

### API Projects

1. Untuk .NET API: Jalankan `dotnet run` di folder project.
2. Untuk Node.js API: Jalankan `npm install` lalu `npm start`.
3. Test API menggunakan Postman atau tools serupa.

### Web Game

1. Buka `web-technology/MODULE_CLIENT_MEDIA/index.html` di browser modern (Chrome/Firefox).
2. Masukkan username dan pilih difficulty level.
3. Mainkan game dengan kontrol keyboard.
4. Lihat leaderboard dan stats di akhir game.

## Teknologi yang Digunakan

- **AI**: Python, Matplotlib, Tkinter
- **Android**: Java/Kotlin, Android SDK
- **Desktop**: C#, .NET Framework, MSSQL/MySQL
- **Web**: HTML, CSS, JavaScript
- **Database**: MSSQL, MySQL, SQLite

## Screenshot

Berikut adalah beberapa screenshot dari proyek-proyek utama:

### AI Module GUI

<!-- Tambahkan screenshot aplikasi GUI -->

### BOMSKUY Game

![BOMSKUY Game](web-technology/MODULE_CLIENT_MEDIA/Example/01.%20Welcome.jpg)

### Android App - EsemkaBakery

<!-- Tambahkan screenshot aplikasi Android -->

### Desktop App - UbigPos

<!-- Tambahkan screenshot aplikasi desktop -->

## Tips dan Troubleshooting

- Selalu backup kode secara berkala
- Gunakan comment yang jelas pada setiap fungsi
- Test aplikasi secara incremental
- Periksa log error untuk debugging
- Pastikan semua dependencies terinstall dengan benar

## Kontribusi

Proyek ini dibuat untuk keperluan kompetisi LKS. Untuk pertanyaan atau saran, silakan hubungi tim pengembang.

## Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE). Lihat file LICENSE untuk detail lebih lanjut.

Selamat bertanding! Semoga sukses dalam kompetisi LKS! 🎉
