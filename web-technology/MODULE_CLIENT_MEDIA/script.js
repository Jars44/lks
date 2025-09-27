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

function placeRandomElements() {
  const totalGrid = gridItems.length;
  gridItems.forEach((item) => {
    const dog = item.querySelector(".dog");
    if (dog) dog.remove();
    const wall = item.querySelector(".wall");
    if (wall) wall.remove();
  });

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

  for (let i = 0; i < dogCount; i++) {
    const pos = getRandomPosition(occupiedPositions);
    occupiedPositions.push(pos);
    const dogImg = document.createElement("img");
    dogImg.className = "dog";
    dogImg.src = "/web-technology/MODULE_CLIENT_MEDIA/Images/dog_down.png";
    dogImg.alt = "dog";
    gridItems[pos].appendChild(dogImg);
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
    console.log(`Player moved to ${direction}, new position: ${playerPosition}`);
  } else {
    console.log(`Invalid move in direction ${direction}: wall, dog, or out of bounds`);
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
      document.getElementById("game").style.display = "none";
      document.getElementById("gameover").style.display = "block";
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
    console.log("Game paused");
  }
}

function resumeGame() {
  if (isPaused) {
    isPaused = false;
    document.getElementById("pause-overlay").style.display = "none";
    console.log("Game resumed");
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
    startTimer();
    console.log("Game started with username:", username.value, "and difficulty:", difficulty.value);
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

function placeBombAtPlayerPosition() {
  const bomb = document.createElement("img");
  bomb.src = "Images/bomb.png";
  bomb.classList.add("bomb");
  const cell = getGridCell(player.x, player.y);
  if (!cell.querySelector(".bomb")) {
    cell.appendChild(bomb);
    scheduleExplosion(bomb, cell);
  }
}

function destroyWall(cell) {
  const wall = cell.querySelector(".wall");
  if (wall) {
    cell.removeChild(wall);
    maybeRevealItem(cell);
  }
}

function maybeRevealItem(cell) {
  const items = ["heart", "tnt", "ice"];
  if (Math.random() < 0.3) {
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
}

function applyItemEffect(type) {
  switch (type) {
    case "heart":
      player.hearts = Math.max(0, player.hearts - 1);
      updateHeartUI();
      break;
    case "tnt":
      player.explosionRange += 1;
      showStatusMark("tnt");
      break;
    case "ice":
      freezePlayerMovement(5000);
      showStatusMark("ice");
      break;
  }
}

function checkItemPickup() {
  const item = cell.querySelector(".item");
  if (item) {
    applyItemEffect(item);
    cell.removeChild(item);
  }
}

function explodeBomb(bomb, cell) {
  bomb.src = "Images/bomb_explode.png";
  applyExplosionEffect(cell);
  setTimeout(() => {
    clearExplosion(cell);
  }, 1000);
}

function scheduleExplosion(bomb, cell) {
  setTimeout(() => {
    explodeBomb(bomb, cell);
  }, 5000);
}

document.addEventListener("keydown", function (event) {
  if (document.getElementById("game").style.display !== "block") return;
  if (isPaused) return;

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
  event.preventDefault();
});

document.addEventListener("keydown", function (event) {
  if (event.key === "Escape") {
    if (document.getElementById("game").style.display === "block") {
      if (isPaused) {
        resumeGame();
      } else {
        pauseGame();
      }
    }
  }
});

document.addEventListener("keydown", function (event) {
  if (event.code == "Space") {
    placeBombAtPlayerPosition();
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
