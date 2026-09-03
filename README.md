# LKS Project Repository

Repositori ini adalah kumpulan lengkap proyek dan modul praktis untuk persiapan kompetisi LKS (Lomba Kompetensi Siswa) di bidang IT Software, AI, dan Web Technology. Dirancang untuk siswa dan pengembang pemula hingga mahir, repositori ini menyediakan implementasi hands-on dari aplikasi mobile, desktop, API, web games, hingga model machine learning. Dengan fokus pada pembelajaran praktis dan pengembangan keterampilan teknis, proyek ini membantu Anda membangun portofolio yang kuat dan mempersiapkan diri menghadapi tantangan kompetisi.

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
│   ├── model.py
│   └── assets/
│       ├── dataset.csv
│       ├── Petunjuk Teknis LKS Kabupaten Malang 2025.pdf
│       └── Suplemen Dataset LKS AI Kabupaten Malang 2025.docx
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

### Modul A: Data Preparation & EDA (60 Menit)

- **Tujuan**: Melakukan data preparation dan Exploratory Data Analysis (EDA) untuk memahami struktur dataset dan menemukan insights awal.
- **Fitur**: Data preparation, handling missing values, analisis fitur dan label kelas, visualisasi data awal.
- **Manfaat**: Membantu peserta memahami data yang akan digunakan, menangani data yang hilang, dan mendapatkan wawasan dasar sebelum pemodelan.
- **File Utama**: `ai/main.py`

### Modul B: Data Classification (120 Menit)

- **Tujuan**: Membangun model klasifikasi menggunakan algoritma Decision Tree untuk memahami konsep dasar machine learning dan pengolahan data.
- **Fitur**: Meliputi preprocessing data, pembagian data train-test (80:20), implementasi manual Decision Tree, visualisasi pohon keputusan, serta analisis feature importance untuk interpretabilitas model.
- **Manfaat**: Membantu peserta memahami alur pembuatan model klasifikasi dari awal hingga evaluasi, serta meningkatkan kemampuan analisis data.
- **File Utama**: `ai/main.py`, `ai/main.ipynb`

### Modul C: Evaluasi Model (60 Menit)

- **Tujuan**: Mengevaluasi performa model klasifikasi dengan metrik yang relevan untuk memastikan model bekerja dengan baik.
- **Fitur**: Penggunaan Confusion Matrix, metrik evaluasi seperti Accuracy, Precision, Recall, F1-Score, visualisasi hasil evaluasi, dan optimasi model untuk performa lebih baik.
- **Manfaat**: Memahami pentingnya evaluasi model dan cara meningkatkan kualitas model klasifikasi.
- **File Utama**: `ai/main.py`

### Modul D: GUI untuk Uji Coba Data Baru (120 Menit)

- **Tujuan**: Membangun antarmuka GUI yang interaktif untuk menguji model klasifikasi dengan data baru secara real-time.
- **Fitur**: Input fields dinamis, prediksi real-time, validasi input, dan penanganan error untuk pengalaman pengguna yang baik.
- **Manfaat**: Mempermudah pengujian model tanpa perlu menjalankan kode secara manual, serta meningkatkan keterampilan pengembangan GUI.
- **File Utama**: `ai/gui.py`

## Modul IT Software

Modul IT Software berisi kumpulan proyek untuk LKS IT Software. **Status: sebagian besar
folder berisi spec PDF + aset gambar, hanya sedikit yang memiliki source code.** Lihat
`it-software/README.md` untuk breakdown per project.

### Implementasi yang tersedia (source code lengkap)
- `it-software/Desktop/UbigPos` — C# WinForms POS (.NET 9, MSSQL)
- `it-software/Pack Soal/C1/EsemkaLibrary` — Android Kotlin (seleknas 2024)
- `it-software/Pack Soal/C1/MotorcyclerRepair` — C# WinForms + EF Designer (seleknas 2024)
- `it-software/Pack Soal/C2/HovRailKiosk` — C# WinForms + EF Designer (seleknas 2024)
- `it-software/Pack Soal/C2/Tiks09` — Android Kotlin (seleknas 2024)
- `it-software/Pack Soal/C2/TiksAPI` — C# WebAPI + EF (partial, no migrations)

### Spec + binary (no source)
- 5 Android projects + 1 Spring Boot: `Backend/*.dll|.exe` publish artifacts only
- 1 WebAPI (Sakura Sushi, Voto, EsemkaLibrary, etc.): same
- 1 Spring Boot (EsemkaGym)

### Spec only
- `it-software/Api/EsemkaRailways` — spec PDF + SQL, no backend
- `it-software/Api/EsemkaStore` — spec PDF + 4-table SQL, no backend
- 7 Desktop projects (BromoAirlines, EsemNet, EsemkaCorporation, EsemkaFoodcourt,
  EsemkaPolling, EsemkaTaskMaster, QuizinAja) — spec + SQL/assets only
- `it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Desktop1` — GrocerSeeker (spec + 2 SQL variants)
- `it-software/Pack Soal/SOAL LKS NASIONAL ITSSB 2024/LKSN2024_Desktop2` — MarathonSimulation (spec + SQL)

## Modul Web Technology

Modul Web Technology fokus pada pengembangan aplikasi web interaktif dan sistem backend yang scalable. Menggunakan teknologi HTML, CSS, JavaScript untuk frontend, dan bahasa server-side seperti PHP/Node.js untuk backend, modul ini mencakup game interaktif, sistem manajemen akun, dan template UI yang siap pakai.

### Client-Side Media Module

Modul ini menekankan pengembangan frontend dengan JavaScript vanilla, CSS untuk styling, dan HTML untuk struktur, menciptakan pengalaman pengguna yang dinamis dan menarik tanpa framework eksternal.

- **BOMSKUY Game**: Game bom berbasis web dengan fitur menarik seperti input username dan tingkat kesulitan, gameplay berbasis grid dengan player, dinding, musuh, dan bom, fungsi pause/resume, sistem leaderboard, serta layar game over dengan statistik lengkap. Menggunakan canvas atau DOM manipulation untuk rendering game.
- **File Utama**: `web-technology/MODULE_CLIENT_MEDIA/index.html`, `script.js`, `style.css`

### Server-Side Media Module

Modul ini mencakup pengembangan backend dengan fokus pada keamanan, performa, dan integrasi database. Menggunakan arsitektur RESTful atau MVC untuk membangun aplikasi web yang robust.

- **Accounts**: Sistem manajemen akun untuk autentikasi dan otorisasi pengguna. Fitur meliputi registrasi, login, reset password, dan role-based access control menggunakan session atau JWT.
- **Database**: Konfigurasi dan manajemen database untuk aplikasi web. Mendukung koneksi ke MySQL/SQLite, query optimization, dan migrasi data.
- **Templates-GUI**: Template antarmuka pengguna untuk mempercepat pengembangan aplikasi web. Menggunakan Bootstrap atau framework CSS custom untuk responsive design dan komponen UI reusable.

## Cara Menjalankan

### AI Module

1. Pastikan Python 3.8+ terinstall. Install dependencies dengan `pip install numpy pandas matplotlib seaborn` (tkinter sudah termasuk dalam instalasi Python standar / Anaconda).
2. Jalankan `python ai/main.py` untuk training model klasifikasi Decision Tree.
3. Jalankan `python ai/gui.py` untuk membuka GUI testing model.
4. Buka `ai/main.ipynb` di Jupyter Notebook / VS Code untuk demo interaktif Modul A–D.

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
