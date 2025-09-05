let isPaused = false;
let gameInterval;
let countdownInterval;

const username = document.getElementById("username");
const difficulty = document.getElementById("level");
const timerElement = document.getElementById("time");
let timeLeft = 180;
let timerInterval;

const map = [x][x][x][x][x][x][x][x][x][x][x]
[x][0][0][0][0][0][0][0][0][0][x]
[x][0][x][0][x][0][x][0][x][0][x]
[x][0][0][0][0][0][0][0][0][0][x]
[x][0][x][0][x][0][x][0][x][0][x]
[x][0][0][0][0][0][0][0][0][0][x]
[x][0][x][0][x][0][x][0][x][0][x]
[x][0][0][0][0][0][0][0][0][0][x]
[x][x][x][x][x][x][x][x][x][x][x]

document.getElementById("home").style.display = "block";

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

function assignTileIds() {
  const gridItems = document.querySelectorAll(".grid-item");
  gridItems.forEach((item, index) => {
    item.id = `tile-${index + 1}`;
  });
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
    assignTileIds();
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
