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
  const wallCount = 10;
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