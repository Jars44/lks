# Panduan Lengkap Menambahkan Logika Pergerakan Pemain di Proyek LKS Web

Panduan ini menjelaskan cara menambahkan logika pergerakan pemain (player movement) ke proyek web LKS Anda di `web-technology/MODULE_CLIENT_MEDIA`. Panduan menggunakan pendekatan grid-based yang sudah ada, dengan asumsi grid 8x8 (meskipun CSS menunjukkan 9x7, HTML memiliki 64 item, jadi kita gunakan indeks 0-63).

## 1. Persiapan dan Pemahaman Struktur

### Grid Layout

- Grid terdiri dari 64 `<div class="grid-item">` (8 baris x 8 kolom).
- Pemain berada di posisi awal dengan `id="player"` (sekitar indeks 9 atau 10 berdasarkan HTML).

### Elemen Utama

- **Pemain**: `<img class="player" src=".../char_*.png">` di dalam grid-item.
- **Dinding**: `<img class="wall">` di grid-item tertentu.
- **Musuh**: `<img class="dog">` di grid-item.

### Koordinat

- Gunakan indeks array (0-63) atau koordinat [baris, kolom] (0-7 untuk keduanya).
- Arah pemain: Gambar pemain berubah berdasarkan arah (char_up.png, char_down.png, dll.).

## 2. Langkah-Langkah Implementasi

Tambahkan kode berikut ke `script.js`. Pastikan kode ini ditempatkan setelah fungsi yang ada, dan sebelum `document.addEventListener("DOMContentLoaded", ...)`.

### a. Variabel Global untuk Tracking

```javascript
let playerPosition = 9; // Indeks awal pemain (sesuaikan dengan HTML, misal posisi 10 adalah indeks 9)
let gridSize = 8; // 8x8 grid
let playerDirection = "down"; // Arah awal
const gridItems = document.querySelectorAll(".grid-item"); // Semua grid-item
```

### b. Fungsi untuk Mendapatkan Koordinat dari Indeks

```javascript
function getCoords(index) {
  return {
    row: Math.floor(index / gridSize),
    col: index % gridSize,
  };
}

function getIndex(row, col) {
  return row * gridSize + col;
}
```

### c. Fungsi untuk Mengecek Collision (Tabrakan)

```javascript
function isValidMove(newIndex) {
  if (newIndex < 0 || newIndex >= 64) return false; // Batas grid
  const targetItem = gridItems[newIndex];
  return !targetItem.querySelector(".wall"); // Tidak ada dinding
}
```

### d. Fungsi untuk Memindahkan Pemain

```javascript
function movePlayer(direction) {
  const { row, col } = getCoords(playerPosition);
  let newRow = row;
  let newCol = col;

  switch (direction) {
    case "up":
      newRow--;
      break;
    case "down":
      newRow++;
      break;
    case "left":
      newCol--;
      break;
    case "right":
      newCol++;
      break;
  }

  const newIndex = getIndex(newRow, newCol);
  if (isValidMove(newIndex)) {
    // Pindahkan gambar pemain
    const playerImg = document.querySelector(".player");
    const targetItem = gridItems[newIndex];
    targetItem.appendChild(playerImg);

    // Update arah dan gambar
    playerDirection = direction;
    playerImg.src = `/web-technology/MODULE_CLIENT_MEDIA/Images/char_${direction}.png`;

    playerPosition = newIndex;
    console.log(`Player moved to ${direction}, new position: ${newIndex}`);
  } else {
    console.log("Invalid move: wall or out of bounds");
  }
}
```

### e. Event Listener untuk Keyboard Input

Tambahkan di akhir `script.js`, setelah event listener yang ada:

```javascript
document.addEventListener("keydown", function (event) {
  if (document.getElementById("game").style.display !== "block") return; // Hanya saat game aktif
  if (isPaused) return; // Jangan gerak saat pause

  switch (event.key) {
    case "w":
    case "ArrowUp":
      movePlayer("up");
      break;
    case "s":
    case "ArrowDown":
      movePlayer("down");
      break;
    case "a":
    case "ArrowLeft":
      movePlayer("left");
      break;
    case "d":
    case "ArrowRight":
      movePlayer("right");
      break;
  }
  event.preventDefault(); // Cegah scroll default
});
```

## 3. Penyesuaian HTML (Opsional)

- Pastikan grid-item pemain memiliki `id="player"` untuk referensi awal.
- Jika perlu, tambahkan kelas untuk dinding dan musuh agar mudah dideteksi (sudah ada di HTML).

## 4. Fitur Tambahan untuk LKS

- **Animasi**: Tambahkan CSS transition ke `.player` untuk gerakan halus: `transition: all 0.2s ease;`.
- **Skor**: Tambahkan logika untuk menghitung skor saat pemain meledak dinding atau musuh.
- **Musuh Bergerak**: Tambahkan fungsi serupa untuk musuh (dog) dengan interval timer.
- **Bomb Placement**: Tambahkan event klik untuk meletakkan bom di posisi pemain.

## 5. Testing dan Debugging

- Jalankan game, tekan WASD atau panah untuk gerak.
- Periksa console untuk log gerakan.
- Pastikan pemain tidak melewati dinding atau batas.
- Jika ada error, periksa indeks grid dan pastikan `gridItems` terdeteksi dengan benar.

## 6. Tips untuk LKS

- Fokus pada logika sederhana untuk poin tinggi.
- Tambahkan sound effects atau animasi ledakan untuk nilai tambah.
- Jika perlu canvas, konversi grid ke canvas untuk performa, tapi grid cukup untuk LKS.

Jika Anda butuh kode lengkap atau penyesuaian spesifik (misal, ukuran grid berbeda), berikan detail lebih lanjut.
