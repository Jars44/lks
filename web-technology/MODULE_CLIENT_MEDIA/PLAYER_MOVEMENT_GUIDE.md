# Panduan Lengkap Menambahkan Logika Pergerakan Pemain di Proyek LKS Web

Panduan ini menjelaskan cara menambahkan logika pergerakan pemain (player movement) ke proyek web LKS Anda di `web-technology/MODULE_CLIENT_MEDIA`. Panduan menggunakan pendekatan grid-based yang sudah ada, dengan grid 9x7 (9 kolom horizontal, 7 baris vertikal untuk area bermain, tidak termasuk tembok luar), total 63 grid-item untuk area bermain (indeks 0-62).

## 1. Persiapan dan Pemahaman Struktur

### Grid Layout

- Grid terdiri dari 64 `<div class="grid-item">` (9 baris x 7 kolom untuk area bermain, dengan tembok luar).
- Pemain berada di posisi awal dengan `id="player"` (sekitar indeks 9 atau 10 berdasarkan HTML).
- Representasi grid (9x7 inner, dengan outer walls):

  ```!bin/bash
  [x][x][x][x][x][x][x][x][x][x][x]
  [x][0][0][0][0][0][0][0][0][0][x]
  [x][0][x][0][x][0][x][0][x][0][x]
  [x][0][0][0][0][0][0][0][0][0][x]
  [x][0][x][0][x][0][x][0][x][0][x]
  [x][0][0][0][0][0][0][0][0][0][x]
  [x][0][x][0][x][0][x][0][x][0][x]
  [x][0][0][0][0][0][0][0][0][0][x]
  [x][x][x][x][x][x][x][x][x][x][x]
  ```

  Catatan: x = tembok luar, 0 = area bermain kosong.

### Elemen Utama

- **Pemain**: `<img class="player" src=".../char_*.png">` di dalam grid-item.
- **Dinding**: `<img class="wall">` di grid-item tertentu.
- **Musuh**: `<img class="dog">` di grid-item.

### Koordinat

- Gunakan indeks array (0-62 untuk area bermain) atau koordinat [baris, kolom] (0-6 untuk baris, 0-8 untuk kolom).
- Arah pemain: Gambar pemain berubah berdasarkan arah (char_up.png, char_down.png, dll.).

## 2. Penempatan Acak (Random) Dog dan Wall

Untuk membuat peletakan **dog** dan **wall** secara acak setiap kali permainan dimulai, Anda perlu menambahkan logika di `script.js` yang akan:

- Mengacak posisi grid-item yang akan ditempati oleh dog dan wall.
- Memastikan posisi dog dan wall tidak bertabrakan dengan posisi pemain awal.
- Mengupdate DOM untuk memindahkan elemen dog dan wall ke posisi acak tersebut.

Contoh logika sederhana untuk peletakan acak:

```javascript
function placeRandomElements() {
  const gridItems = document.querySelectorAll(".grid-item");
  const totalGrid = gridItems.length;
  const playerStartIndex = 10; // Sesuaikan dengan posisi awal pemain

  // Hapus dog dan wall yang ada sebelumnya
  gridItems.forEach((item) => {
    const dog = item.querySelector(".dog");
    if (dog) dog.remove();
    const wall = item.querySelector(".wall");
    if (wall) wall.remove();
  });

  // Fungsi untuk mendapatkan posisi acak yang valid
  function getRandomPosition(excludePositions) {
    let pos;
    do {
      pos = Math.floor(Math.random() * totalGrid);
    } while (excludePositions.includes(pos));
    return pos;
  }

  // Tentukan jumlah dog dan wall yang ingin ditempatkan
  const dogCount = 3; // Contoh jumlah dog
  const wallCount = 10; // Contoh jumlah wall

  const occupiedPositions = [playerStartIndex];

  // Tempatkan dog secara acak
  for (let i = 0; i < dogCount; i++) {
    const pos = getRandomPosition(occupiedPositions);
    occupiedPositions.push(pos);
    const dogImg = document.createElement("img");
    dogImg.className = "dog";
    dogImg.src = "/web-technology/MODULE_CLIENT_MEDIA/Images/dog_down.png";
    dogImg.alt = "dog";
    gridItems[pos].appendChild(dogImg);
  }

  // Tempatkan wall secara acak
  for (let i = 0; i < wallCount; i++) {
    const pos = getRandomPosition(occupiedPositions);
    occupiedPositions.push(pos);
    const wallImg = document.createElement("img");
    wallImg.className = "wall";
    wallImg.src = "/web-technology/MODULE_CLIENT_MEDIA/Images/wall.png";
    wallImg.alt = "wall";
    gridItems[pos].appendChild(wallImg);
  }
}
```

Panggil fungsi ini saat permainan dimulai, misalnya di dalam fungsi `Play()` setelah loading selesai.

## 3. Langkah-Langkah Implementasi

Tambahkan kode berikut ke `script.js`. Pastikan kode ini ditempatkan setelah fungsi yang ada, dan sebelum `document.addEventListener("DOMContentLoaded", ...)`.

### a. Variabel Global untuk Tracking

```javascript
let playerPosition = 9; // Indeks awal pemain (sesuaikan dengan HTML, misal posisi 10 adalah indeks 9)
let gridSize = 9; // 9 columns (horizontal)
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
  if (newIndex < 0 || newIndex >= 63) return false; // Batas grid (0-62)
  const targetItem = gridItems[newIndex];
  // Cek apakah ada wall atau dog di posisi baru
  return !targetItem.querySelector(".wall") && !targetItem.querySelector(".dog");
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
    console.log("Invalid move: wall, dog, or out of bounds");
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

## 4. Memanggil Fungsi Peletakan Acak

Panggil fungsi `placeRandomElements()` di dalam fungsi `Play()` setelah loading selesai, sebelum memulai timer dan menampilkan game.

```javascript
setTimeout(() => {
  document.getElementById("home").style.display = "none";
  document.getElementById("game").style.display = "block";
  placeRandomElements(); // Peletakan dog dan wall secara acak
  startTimer();
  console.log("Game started with username:", username.value, "and difficulty:", difficulty.value);
}, 3000);
```

## 5. Testing dan Debugging

- Jalankan game, pastikan dog dan wall muncul di posisi acak setiap kali mulai.
- Pastikan pemain tidak bisa bergerak melewati wall atau dog.
- Periksa console untuk log gerakan dan validasi posisi.
- Jika ada error, periksa indeks grid dan pastikan `gridItems` terdeteksi dengan benar.

## 6. Tips untuk LKS

- Fokus pada logika sederhana untuk poin tinggi.
- Tambahkan sound effects atau animasi ledakan untuk nilai tambah.
- Jika perlu canvas, konversi grid ke canvas untuk performa, tapi grid cukup untuk LKS.

Jika Anda butuh kode lengkap atau penyesuaian spesifik (misal, ukuran grid berbeda), berikan detail lebih lanjut.
