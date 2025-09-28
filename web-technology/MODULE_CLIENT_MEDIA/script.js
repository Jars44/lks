let isPaused = false;
let gameInterval;
let countdownInterval;

const username = document.getElementById("username");
const difficulty = document.getElementById("level");
const timerElement = document.getElementById("time");
let timeLeft = 180;
let timerInterval;

let playerPosition = 23;
let gridSize = 11;
let playerDirection = "down";
const gridItems = document.querySelectorAll(".grid-item");

let player = {
  position: playerPosition,
  hearts: 3,
  explosionRange: 1,
  direction: playerDirection,
  frozenUntil: 0,
};

let wallsDestroyed = 0;
let tntsCollected = 0;
let icesCollected = 0;

let matchData = {
  username: "",
  time: 180,
  walls: 0,
  tnts: 0,
  ices: 0,
};

let dogs = [];

function getCoords(index) {
  return {
    row: Math.floor(index / gridSize),
    col: index % gridSize,
  };
}

function isWall(row, col) {
  if (row === 0 || row === 8) return true;
  if (col === 0 || col === 10) return true;
  if (row % 2 === 0 && col % 2 === 0) return true;
  return false;
}

function getIndex(row, col) {
  return row * gridSize + col;
}

function isValidMove(newIndex) {
  if (newIndex < 0 || newIndex >= 99) return false;
  const { row, col } = getCoords(newIndex);
  if (isWall(row, col)) return false;
  const targetItem = gridItems[newIndex];
  return !targetItem.querySelector(".wall") && !targetItem.querySelector(".dog");
}

function distance(dog, player) {
  const dogCoords = getCoords(dog.position);
  const playerCoords = getCoords(player.position);
  return Math.abs(dogCoords.row - playerCoords.row) + Math.abs(dogCoords.col - playerCoords.col);
}

function placeRandomElements() {
  const totalGrid = gridItems.length;

  function getRandomPosition(excludePositions) {
    let pos;
    do {
      pos = Math.floor(Math.random() * totalGrid);
    } while (excludePositions.includes(pos));
    return pos;
  }

  const dogCount = 1;
  const wallCount = 15;
  const occupiedPositions = [playerPosition];

  for (let i = 0; i < totalGrid; i++) {
    const { row, col } = getCoords(i);
    if (isWall(row, col)) {
      occupiedPositions.push(i);
    }
  }

  // Exclude positions within radius 2 of player to prevent trapping
  const playerCoords = getCoords(playerPosition);
  const radius = 2;
  for (let i = 0; i < totalGrid; i++) {
    const { row, col } = getCoords(i);
    const dist = Math.abs(row - playerCoords.row) + Math.abs(col - playerCoords.col);
    if (dist <= radius && !occupiedPositions.includes(i)) {
      occupiedPositions.push(i);
    }
  }

  for (let i = 0; i < dogCount; i++) {
    const pos = getRandomPosition(occupiedPositions);
    occupiedPositions.push(pos);
    const dogImg = document.createElement("img");
    dogImg.className = "dog";
    dogImg.src = "/web-technology/MODULE_CLIENT_MEDIA/Images/dog_down.png";
    dogImg.alt = "dog";
    gridItems[pos].appendChild(dogImg);
    dogs.push({ position: pos, direction: 'down', element: dogImg });
  }

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

function showLoadingScreen() {
  document.getElementById("loading-overlay").style.display = "flex";
  let countdown = 3;
  const countdownElement = document.querySelector(".countdown");

  countdownElement.textContent = countdown;

  countdownInterval = setInterval(() => {
    countdown--;
    countdownElement.textContent = countdown;

    if (countdown <= 0) {
      clearInterval(countdownInterval);
      hideLoadingScreen();
    }
  }, 1000);
}

function hideLoadingScreen() {
  document.getElementById("loading-overlay").style.display = "none";
}

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
    const playerImg = document.querySelector(".player");
    const targetItem = gridItems[newIndex];
    targetItem.appendChild(playerImg);

    playerDirection = direction;
    playerImg.src = `/web-technology/MODULE_CLIENT_MEDIA/Images/char_${direction}.png`;

    playerPosition = newIndex;
    player.position = newIndex;
    checkItemPickup(gridItems[playerPosition]);

    // Check for dog collision after player move
    const dog = gridItems[playerPosition].querySelector(".dog");
    if (dog) {
      playerHit();
    }
  } else {
  }
}

function animateCollect(element, cell, remove = true) {
  element.classList.add("collecting");
  if (remove) {
    setTimeout(() => {
      if (cell.contains(element)) cell.removeChild(element);
    }, 500);
  } else {
    setTimeout(() => {
      element.classList.remove("collecting");
    }, 500);
  }
}

function checkItemPickup(cell) {
  const item = cell.querySelector(".item");
  if (item) {
    const type = item.classList[1];
    animateCollect(item, cell);
    setTimeout(() => applyItemEffect(type), 500);
  }

  const bomb = cell.querySelector(".bomb");
  if (bomb) {
    bomb.classList.add("passed");
    setTimeout(() => bomb.classList.remove("passed"), 500);
  }
}

function applyItemEffect(type) {
  const playerImg = document.querySelector(".player");
  switch (type) {
    case "heart":
      player.hearts = Math.max(0, player.hearts - 1);
      updateHeartUI();
      if (player.hearts <= 0) {
        triggerGameOver();
      }
      break;
    case "tnt":
      player.explosionRange += 1;
      tntsCollected++;
      updateTNTUI();
      // Add mark if not present
      if (!playerImg.querySelector(".tnt-mark")) {
        const tntMark = document.createElement("img");
        tntMark.src = "Images/tnt.png";
        tntMark.classList.add("tnt-mark", "item-mark");
        tntMark.style.width = "20px";
        tntMark.style.height = "auto";
        tntMark.style.position = "absolute";
        tntMark.style.top = "0";
        tntMark.style.right = "0";
        playerImg.parentElement.appendChild(tntMark);
      }
      break;
    case "ice":
      freezePlayerMovement(5000);
      icesCollected++;
      updateIceUI();
      // Add mark if not present
      if (!playerImg.querySelector(".ice-mark")) {
        const iceMark = document.createElement("img");
        iceMark.src = "Images/ice.png";
        iceMark.classList.add("ice-mark", "item-mark");
        iceMark.style.width = "20px";
        iceMark.style.height = "auto";
        iceMark.style.position = "absolute";
        iceMark.style.top = "0";
        iceMark.style.left = "0";
        playerImg.parentElement.appendChild(iceMark);
      }
      break;
  }
}

function freezePlayerMovement(duration) {
  player.frozenUntil = Date.now() + duration;
}

function flashPlayer() {
  const img = document.querySelector(".player");
  img.classList.add("hit");
  setTimeout(() => img.classList.remove("hit"), 500);
}

function playerHit() {
  player.hearts = Math.max(0, player.hearts - 1);
  updateHeartUI();
  flashPlayer();
  if (player.hearts <= 0) {
    triggerGameOver();
  }
}

function attemptDogMove(dog, dir) {
  const { row, col } = getCoords(dog.position);
  let newRow = row;
  let newCol = col;
  switch (dir) {
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
    gridItems[dog.position].removeChild(dog.element);
    gridItems[newIndex].appendChild(dog.element);
    dog.position = newIndex;
    dog.direction = dir;
    if (dog.position === player.position) playerHit();
  }
}

function moveDogTowardsPlayer(dog) {
  const dogCoords = getCoords(dog.position);
  const playerCoords = getCoords(player.position);
  let dir = "down";
  if (Math.abs(playerCoords.row - dogCoords.row) > Math.abs(playerCoords.col - dogCoords.col)) {
    dir = playerCoords.row > dogCoords.row ? "down" : "up";
  } else {
    dir = playerCoords.col > dogCoords.col ? "right" : "left";
  }
  attemptDogMove(dog, dir);
}

function moveDogRandomly(dog) {
  const directions = ["up", "down", "left", "right"];
  const dir = directions[Math.floor(Math.random() * directions.length)];
  attemptDogMove(dog, dir);
}

function updateDogImage(dog) {
  const dogImg = dog.element;
  dogImg.src = `/web-technology/MODULE_CLIENT_MEDIA/Images/dog_${dog.direction}.png`;
}

function updateDogs() {
  dogs.forEach((dog) => {
    if (Math.random() < 0.5) {
      moveDogTowardsPlayer(dog);
    } else {
      moveDogRandomly(dog);
    }
    updateDogImage(dog);
  });
}

function placeBombAtPlayerPosition() {
  const bomb = document.createElement("img");
  bomb.src = "Images/bomb.png";
  bomb.classList.add("bomb");
  const cell = gridItems[player.position];
  if (!cell.querySelector(".bomb")) {
    cell.appendChild(bomb);
    scheduleExplosion(bomb, cell);
  }
}

function destroyWall(cell) {
  const wall = cell.querySelector(".wall");
  if (wall) {
    cell.removeChild(wall);
    wallsDestroyed++;
    updateWallUI();
    setTimeout(() => maybeRevealItem(cell), 1000);
  }
}

function maybeRevealItem(cell) {
  const items = ["heart", "tnt", "ice"];
  if (Math.random() < 0.8) {
    const itemType = items[Math.floor(Math.random() * items.length)];
    const item = document.createElement("img");
    item.src = `Images/${itemType}.png`;
    item.classList.add("item", itemType);
    cell.appendChild(item);
  }
}

function applyExplosionEffect(cell) {
  if (cell.querySelector(".wall")) {
    destroyWall(cell);
  }
  const dog = cell.querySelector('.dog');
  if (dog) {
    cell.removeChild(dog);
    const index = dogs.findIndex(d => d.element === dog);
    if (index > -1) dogs.splice(index, 1);
  }
}

function clearExplosion(cell) {
  const explosion = cell.querySelector(".bomb");
  if (explosion) cell.removeChild(explosion);
}

function explodeBomb(bomb, cell) {
  bomb.src = "Images/bomb_explode.png";
  const index = Array.from(gridItems).indexOf(cell);
  const { row, col } = getCoords(index);
  const affectedCells = [];
  for (let r = row - player.explosionRange; r <= row + player.explosionRange; r++) {
    for (let c = col - player.explosionRange; c <= col + player.explosionRange; c++) {
      if (r === row || c === col) {
        const adjIndex = getIndex(r, c);
        if (adjIndex >= 0 && adjIndex < gridItems.length) {
          const adjCell = gridItems[adjIndex];
          applyExplosionEffect(adjCell);
          if (adjIndex === player.position) playerHit();
          // Add explosion visual to affected cells, but not the bomb cell itself
          if (adjIndex !== index && !adjCell.querySelector(".explosion")) {
            const explosionImg = document.createElement("img");
            explosionImg.src = "Images/bomb_explode.png";
            explosionImg.classList.add("explosion");
            explosionImg.style.width = "100%";
            explosionImg.style.height = "auto";
            adjCell.appendChild(explosionImg);
            affectedCells.push(adjCell);
          }
        }
      }
    }
  }
  setTimeout(() => {
    clearExplosion(cell);
    affectedCells.forEach(cell => {
      const explosion = cell.querySelector(".explosion");
      if (explosion) cell.removeChild(explosion);
    });
  }, 1000);
}

function scheduleExplosion(bomb, cell) {
  setTimeout(() => {
    explodeBomb(bomb, cell);
  }, 5000);
}

function updateHeartUI() {
  const heartIndicator = document.querySelector(".heart-indicator");
  if (player.hearts === 3) {
    heartIndicator.src = "/web-technology/MODULE_CLIENT_MEDIA/Images/heart_indicator.png";
  } else if (player.hearts === 2) {
    heartIndicator.src = "/web-technology/MODULE_CLIENT_MEDIA/Images/heart_indicator1.png";
  } else if (player.hearts === 1) {
    heartIndicator.src = "/web-technology/MODULE_CLIENT_MEDIA/Images/heart_indicator2.png";
  } else {
    heartIndicator.src = "/web-technology/MODULE_CLIENT_MEDIA/Images/heart_indicator3.png";
  }
}

function updateWallUI() {
  document.getElementById("walls").textContent = "= " + wallsDestroyed;
}

function updateTNTUI() {
  document.getElementById("tnt").textContent = "= " + tntsCollected;
}

function updateIceUI() {
  document.getElementById("ice").textContent = "= " + icesCollected;
}


function startTimer() {
  if (timerInterval) clearTimeout(timerInterval);
  const updateTimer = () => {
    const minutes = Math.floor(timeLeft / 60);
    const seconds = timeLeft % 60;
    timerElement.textContent = ": " + `${minutes}:${seconds.toString().padStart(2, "0")}`;
    if (timeLeft <= 10) {
      timerElement.style.color = "red";
    }
    if (timeLeft <= 0) {
      clearTimeout(timerInterval);
      triggerGameOver();
      return;
    }
    timeLeft--;
    timerInterval = setTimeout(updateTimer, 1000);
  };
  updateTimer();
}

function pauseGame() {
  if (!isPaused) {
    isPaused = true;
    clearTimeout(timerInterval);
    document.getElementById("pause-overlay").style.display = "flex";
  }
}

function resumeGame() {
  if (isPaused) {
    isPaused = false;
    document.getElementById("pause-overlay").style.display = "none";
    startTimer();
  }
}

function goToHome() {
  document.getElementById("pause-overlay").style.display = "none";
  document.getElementById("game").style.display = "none";
  document.getElementById("home").style.display = "block";
}

function Play() {
  if (!username.checkValidity()) {
    username.reportValidity();
    return;
  }

  if (difficulty.value === "0" || difficulty.value === "") {
    difficulty.setCustomValidity("Please select a difficulty level");
    difficulty.reportValidity();
    return;
  } else {
    difficulty.setCustomValidity("");
  }

  document.getElementById("nickname").textContent = ": " + username.value;
  showLoadingScreen();

  setTimeout(() => {
    document.getElementById("home").style.display = "none";
    document.getElementById("game").style.display = "block";
    placeRandomElements();
    const playerImg = document.querySelector(".player");
    gridItems[playerPosition].appendChild(playerImg);
    matchData.username = username.value;
    startTimer();
    gameInterval = setInterval(updateDogs, 1000);
  }, 3000);
}

function Instruction() {
  document.getElementById("instruction").style.display = "block";
  document.getElementById("home").style.display = "none";
}

function CloseInstruction() {
  document.getElementById("instruction").style.display = "none";
  document.getElementById("home").style.display = "block";
}

function triggerGameOver() {
  clearInterval(gameInterval);
  clearTimeout(timerInterval);
  matchData.time = timeLeft;
  matchData.walls = wallsDestroyed;
  matchData.tnts = tntsCollected;
  matchData.ices = icesCollected;
  let matches = JSON.parse(localStorage.getItem("matches")) || [];
  matches.push(matchData);
  localStorage.setItem("matches", JSON.stringify(matches));
  // Update gameover UI
  document.querySelector('.subtitle-gameover').textContent = `Good job ${matchData.username}! Your time ${Math.floor((180 - timeLeft) / 60)}:${((180 - timeLeft) % 60).toString().padStart(2, '0')} with result:`;
  document.getElementById('gameover-walls').textContent = '= ' + wallsDestroyed;
  document.getElementById('gameover-tnt').textContent = '= ' + tntsCollected;
  document.getElementById('gameover-ice').textContent = '= ' + icesCollected;
  document.getElementById("game").style.display = "none";
  document.getElementById("gameover").style.display = "block";
}

function displayLeaderboard() {
  const matches = JSON.parse(localStorage.getItem("matches") || "[]");
  matches.sort((a, b) => b.walls * 10 + b.tnts * 20 + b.ices * 5 - (a.walls * 10 + a.tnts * 20 + a.ices * 5));
  const tbody = document.querySelector("#leaderboard tbody");
  tbody.innerHTML = "";
  matches.forEach((match) => {
    const row = `<tr>
      <td>${match.username}</td>
      <td>${match.walls}</td>
      <td>${match.tnts}</td>
      <td>${match.ices}</td>
      <td>${match.time}</td>
    </tr>`;
    tbody.innerHTML += row;
  });
}

function leaderboard() {
  document.getElementById('gameover').style.display = 'none';
  document.getElementById('leaderboard').style.display = 'block';
  displayLeaderboard();
}

function playAgain() {
  // Reset variables
  player.hearts = 3;
  player.explosionRange = 1;
  player.frozenUntil = 0;
  wallsDestroyed = 0;
  tntsCollected = 0;
  icesCollected = 0;
  timeLeft = 180;
  dogs = [];
  // Hide leaderboard, call Play
  document.getElementById('leaderboard').style.display = 'none';
  Play();
}

function resetLeaderboard() {
  localStorage.removeItem('matches');
  displayLeaderboard();
}

document.addEventListener("keydown", function (event) {
  if (document.getElementById("game").style.display !== "block") {
    if (event.key === "Escape") {
      if (isPaused) {
        resumeGame();
      } else {
        pauseGame();
      }
    }
    return;
  }

  if (isPaused && event.key !== "Escape") return;
  if (Date.now() < player.frozenUntil && event.code !== "Space" && event.key !== "Escape") return;

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

  if (event.key === "Escape") {
    if (isPaused) {
      resumeGame();
    } else {
      pauseGame();
    }
  }

  if (event.code == "Space") {
    placeBombAtPlayerPosition();
  }

  if (["w", "s", "a", "d", "ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"].includes(event.key)) {
    event.preventDefault();
  }
});

document.addEventListener("DOMContentLoaded", function () {
  const form = document.querySelector(".form");
  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      Play();
    });
  }
});

document.getElementById("home").style.display = "block";