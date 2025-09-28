// CONFIGURATION
const config = {
  gridSize: 11,
  gridHeight: 9,
  playerStartPosition: 23,
  wallCount: 15,
  exclusionRadius: 2,
  initialTime: 180,
  maxHearts: 3,
  initialExplosionRange: 1,
  itemRevealProbability: 0.9,
  dogChaseProbability: 0.5,
  bombTimer: 5000,
  freezeDuration: 5000,
  explosionDisplayTime: 1000,
  collectAnimationTime: 500,
  loadingCountdown: 3000,
  dogUpdateInterval: 1000,
  imageBasePath: "Images/",
  winWallsRequired: 15,
};

// GAME STATE
let isPaused = false;
let gameInterval;
let countdownInterval;

const username = document.getElementById("username");
const difficulty = document.getElementById("level");
const timerElement = document.getElementById("time");
let timeLeft = config.initialTime;
let timerInterval;
let difficultyLevel = 1;

let playerDirection = "down";
const gridItems = document.querySelectorAll(".grid-item");

let player = {
  position: config.playerStartPosition,
  hearts: config.maxHearts,
  explosionRange: config.initialExplosionRange,
  direction: playerDirection,
  frozenUntil: 0,
};

let wallsDestroyed = 0;
let tntsCollected = 0;
let icesCollected = 0;

let matchData = {
  username: "",
  time: config.initialTime,
  walls: 0,
  tnts: 0,
  ices: 0,
};

let dogs = [];

// UTILITY FUNCTIONS
function getCoords(index) {
  return {
    row: Math.floor(index / config.gridSize),
    col: index % config.gridSize,
  };
}

function isWall(row, col) {
  if (row === 0 || row === config.gridHeight - 1) return true;
  if (col === 0 || col === config.gridSize - 1) return true;
  if (row % 2 === 0 && col % 2 === 0) return true;
  return false;
}

function getIndex(row, col) {
  return row * config.gridSize + col;
}

function isValidMove(newIndex) {
  if (newIndex < 0 || newIndex >= config.gridSize * config.gridHeight) return false;
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

function clearGrid() {
  gridItems.forEach(cell => {
    const elementsToRemove = cell.querySelectorAll('.wall, .dog, .item, .bomb, .explosion, .tnt-mark, .ice-mark');
    elementsToRemove.forEach(el => cell.removeChild(el));
  });
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

  const dogCount = difficultyLevel;
  const wallCount = config.wallCount;
  const occupiedPositions = [player.position];

  for (let i = 0; i < totalGrid; i++) {
    const { row, col } = getCoords(i);
    if (isWall(row, col)) {
      occupiedPositions.push(i);
    }
  }

  const playerCoords = getCoords(player.position);
  const radius = config.exclusionRadius;
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
    dogImg.src = `${config.imageBasePath}dog_down.png`;
    dogImg.alt = "dog";
    gridItems[pos].appendChild(dogImg);
    dogs.push({ position: pos, direction: "down", element: dogImg });
  }

  for (let i = 0; i < wallCount; i++) {
    const pos = getRandomPosition(occupiedPositions);
    occupiedPositions.push(pos);
    const wallImg = document.createElement("img");
    wallImg.className = "wall";
    wallImg.src = `${config.imageBasePath}wall.png`;
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

// PLAYER MECHANICS
function movePlayer(direction) {
  const { row, col } = getCoords(player.position);
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
    playerImg.src = `${config.imageBasePath}char_${direction}.png`;

    player.position = newIndex;
    checkItemPickup(gridItems[player.position]);

    const dog = gridItems[player.position].querySelector(".dog");
    if (dog) {
      playerHit();
    }
  }
}

function animateCollect(element, cell, remove = true) {
  element.classList.add("collecting");
  if (remove) {
    setTimeout(() => {
      if (cell.contains(element)) cell.removeChild(element);
    }, config.collectAnimationTime);
  } else {
    setTimeout(() => {
      element.classList.remove("collecting");
    }, config.collectAnimationTime);
  }
}

function checkItemPickup(cell) {
  const item = cell.querySelector(".item");
  if (item) {
    const type = item.classList[1];

    animateCollect(item, cell);
    setTimeout(() => applyItemEffect(type), config.collectAnimationTime);
  }
}

function applyItemEffect(type) {
  const playerImg = document.querySelector(".player");
  switch (type) {
    case "heart":
      player.hearts = Math.max(0, player.hearts - 1);
      updateHeartUI();
      flashPlayer();
      if (player.hearts <= 0) {
        triggerGameOver();
      }
      break;
    case "tnt":
      player.explosionRange += 1;
      tntsCollected++;
      updateTNTUI();
      if (!playerImg.querySelector(".tnt-mark")) {
        const tntMark = document.createElement("img");
        tntMark.src = `${config.imageBasePath}tnt.png`;
        tntMark.classList.add("tnt-mark", "item-mark");
        tntMark.style.width = "20px";
        tntMark.style.height = "auto";
        tntMark.style.position = "absolute";
        tntMark.style.top = "0";
        tntMark.style.right = "0";
        playerImg.parentElement.appendChild(tntMark);
        const mark = playerImg.parentElement.querySelector(".tnt-mark");
        if (mark) playerImg.parentElement.removeChild(mark);
      }
      break;
    case "ice":
      freezePlayerMovement(config.freezeDuration);
      icesCollected++;
      updateIceUI();
      if (!playerImg.querySelector(".ice-mark")) {
        const iceMark = document.createElement("img");
        iceMark.src = `${config.imageBasePath}ice.png`;
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
  setTimeout(() => {
    const playerImg = document.querySelector(".player");
    const iceMark = playerImg.parentElement.querySelector(".ice-mark");
    if (iceMark) playerImg.parentElement.removeChild(iceMark);
  }, duration);
}

function flashPlayer() {
  const img = document.querySelector(".player");
  img.classList.add("hit");
  setTimeout(() => img.classList.remove("hit"), config.collectAnimationTime);
}

function playerHit() {
  player.hearts = Math.max(0, player.hearts - 1);
  updateHeartUI();
  flashPlayer();
  if (player.hearts <= 0) {
    triggerGameOver();
  }
}

// ENEMY MECHANICS
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
  dogImg.src = `${config.imageBasePath}dog_${dog.direction}.png`;
}

function updateDogs() {
  dogs.forEach((dog) => {
    if (Math.random() < config.dogChaseProbability) {
      moveDogTowardsPlayer(dog);
    } else {
      moveDogRandomly(dog);
    }
    updateDogImage(dog);
  });
}

// BOMB MECHANICS
function placeBombAtPlayerPosition() {
  const bomb = document.createElement("img");
  bomb.src = `${config.imageBasePath}bomb.png`;
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
    if (wallsDestroyed === config.winWallsRequired) {
      triggerGameOver();
    }
    setTimeout(() => maybeRevealItem(cell), config.explosionDisplayTime);
  }
}

function maybeRevealItem(cell) {
  const items = ["heart", "tnt", "ice"];
  if (Math.random() < config.itemRevealProbability) {
    const itemType = items[Math.floor(Math.random() * items.length)];
    const item = document.createElement("img");
    item.src = `${config.imageBasePath}${itemType}.png`;
    item.classList.add("item", itemType);
    cell.appendChild(item);
  }
}

function applyExplosionEffect(cell) {
  if (cell.querySelector(".wall")) {
    destroyWall(cell);
  }
  const dog = cell.querySelector(".dog");
  if (dog) {
    cell.removeChild(dog);
    const index = dogs.findIndex((d) => d.element === dog);
    if (index > -1) dogs.splice(index, 1);
  }
}

function clearExplosion(cell) {
  const explosion = cell.querySelector(".bomb");
  if (explosion) cell.removeChild(explosion);
}

function explodeInDirection(row, col, deltaRow, deltaCol, range, index, affectedCells) {
  for (let i = 1; i <= range; i++) {
    const r = row + deltaRow * i;
    const c = col + deltaCol * i;
    if (isWall(r, c)) break;
    const adjIndex = getIndex(r, c);
    if (adjIndex >= 0 && adjIndex < gridItems.length) {
      const adjCell = gridItems[adjIndex];
      applyExplosionEffect(adjCell);
      if (adjIndex === player.position) playerHit();
      if (adjIndex !== index && !adjCell.querySelector(".explosion")) {
        const explosionImg = document.createElement("img");
        explosionImg.src = `${config.imageBasePath}bomb_explode.png`;
        explosionImg.classList.add("explosion");
        explosionImg.style.width = "100%";
        explosionImg.style.height = "auto";
        adjCell.appendChild(explosionImg);
        affectedCells.push(adjCell);
      }
    }
  }
}

function explodeBomb(bomb, cell) {
  bomb.src = `${config.imageBasePath}bomb_explode.png`;
  const index = Array.from(gridItems).indexOf(cell);
  const { row, col } = getCoords(index);
  const affectedCells = [];

  // Up
  explodeInDirection(row, col, -1, 0, player.explosionRange, index, affectedCells);
  // Down
  explodeInDirection(row, col, 1, 0, player.explosionRange, index, affectedCells);
  // Left
  explodeInDirection(row, col, 0, -1, player.explosionRange, index, affectedCells);
  // Right
  explodeInDirection(row, col, 0, 1, player.explosionRange, index, affectedCells);

  setTimeout(() => {
    clearExplosion(cell);
    affectedCells.forEach((cell) => {
      const explosion = cell.querySelector(".explosion");
      if (explosion) cell.removeChild(explosion);
    });
  }, config.explosionDisplayTime);
}

function scheduleExplosion(bomb, cell) {
  setTimeout(() => {
    explodeBomb(bomb, cell);
  }, config.bombTimer);
}

// UI UPDATES
function updateHeartUI() {
  const heartIndicator = document.querySelector(".heart-indicator");
  const heartImages = [
    `${config.imageBasePath}heart_indicator3.png`, // 0 hearts
    `${config.imageBasePath}heart_indicator2.png`, // 1 heart
    `${config.imageBasePath}heart_indicator1.png`, // 2 hearts
    `${config.imageBasePath}heart_indicator.png`, // 3 hearts
  ];
  heartIndicator.src = heartImages[player.hearts] || heartImages[0];
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

// GAME CONTROL
function startTimer() {
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

  difficultyLevel = parseInt(difficulty.value);

  document.getElementById("nickname").textContent = ": " + username.value;
  showLoadingScreen();

  setTimeout(() => {
    document.getElementById("home").style.display = "none";
    document.getElementById("game").style.display = "block";
    clearGrid();
    dogs = [];
    placeRandomElements();
    const playerImg = document.querySelector(".player");
    gridItems[player.position].appendChild(playerImg);
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
  matchData.time = config.initialTime - timeLeft;
  matchData.walls = wallsDestroyed;
  matchData.tnts = tntsCollected;
  matchData.ices = icesCollected;
  // Update gameover UI
  document.querySelector(".subtitle-gameover").textContent = `Good job ${matchData.username}! Your time ${Math.floor(
    matchData.time / 60
  )}:${(matchData.time % 60).toString().padStart(2, "0")} with result:`;
  document.getElementById("gameover-walls").textContent = "= " + wallsDestroyed;
  document.getElementById("gameover-tnt").textContent = "= " + tntsCollected;
  document.getElementById("gameover-ice").textContent = "= " + icesCollected;
  document.getElementById("game").style.display = "none";
  document.getElementById("gameover").style.display = "block";
}

function formatTime(seconds) {
  const minutes = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${minutes}:${secs.toString().padStart(2, "0")}`;
}

function displayLeaderboard() {
  let matches = JSON.parse(localStorage.getItem("matches") || "[]");
  const score = (match) => match.walls * 10 + match.tnts * 20 + match.ices * 5;
  matches.sort((a, b) => score(b) - score(a));
  const topMatches = matches.slice(0, 3);
  const tbody = document.querySelector("#leaderboard tbody");
  tbody.innerHTML = "";
  topMatches.forEach((match, index) => {
    const rowClass = index === 1 ? 'class="row-mid-leaderboard"' : '';
    const row = `<tr ${rowClass}>
      <td class="stat-leaderboard">${match.username}</td>
      <td class="stats-leaderboard">${formatTime(match.time)}</td>
      <td class="stats-leaderboard">${match.walls}</td>
      <td class="stats-leaderboard">${match.tnts}</td>
      <td class="stats-leaderboard">${match.ices}</td>
    </tr>`;
    tbody.innerHTML += row;
  });
}

function saveScore() {
  let matches = JSON.parse(localStorage.getItem("matches")) || [];
  matches.push(matchData);
  localStorage.setItem("matches", JSON.stringify(matches));
  leaderboard();
}

function leaderboard() {
  document.getElementById("gameover").style.display = "none";
  document.getElementById("leaderboard").style.display = "block";
  displayLeaderboard();
}

function playAgain() {
  player.position = config.playerStartPosition;
  player.hearts = config.maxHearts;
  player.explosionRange = config.initialExplosionRange;
  player.frozenUntil = 0;
  wallsDestroyed = 0;
  tntsCollected = 0;
  icesCollected = 0;
  timeLeft = config.initialTime;
  dogs = [];
  updateHeartUI();
  updateWallUI();
  updateTNTUI();
  updateIceUI();
  document.getElementById("leaderboard").style.display = "none";
  document.getElementById("gameover").style.display = "none";
  showLoadingScreen();
  setTimeout(() => {
    document.getElementById("game").style.display = "block";
    clearGrid();
    placeRandomElements();
    const playerImg = document.querySelector(".player");
    gridItems[player.position].appendChild(playerImg);
    startTimer();
    gameInterval = setInterval(updateDogs, 1000);
  }, 3000);
}

function resetLeaderboard() {
  localStorage.removeItem("matches");
  displayLeaderboard();
}

// EVENT HANDLING
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

// INITIALIZATION
document.getElementById("home").style.display = "block";

document.addEventListener("DOMContentLoaded", function () {
  const form = document.querySelector(".form");
  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      Play();
    });
  }
});