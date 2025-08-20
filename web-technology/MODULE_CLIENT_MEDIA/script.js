document.getElementById("home").style.display = "none";

// Game state variables
let isPaused = false;
let gameInterval;

// Loading screen and pause functionality
function showLoadingScreen() {
  document.getElementById("loading").style.display = "flex";
  document.getElementById("home").style.display = "none";
  document.getElementById("game").style.display = "none";
}

function hideLoadingScreen() {
  document.getElementById("loading").style.display = "none";
  document.getElementById("game").style.display = "block";
}

function pauseGame() {
  if (!isPaused) {
    isPaused = true;
    document.getElementById("pause-overlay").style.display = "flex";
    console.log("Game paused");
  }
}

function resumeGame() {
  if (isPaused) {
    isPaused = false;
    document.getElementById("pause-overlay").style.display = "none";
    console.log("Game resumed");
  }
}

function goToHome() {
  document.getElementById("pause-overlay").style.display = "none";
  document.getElementById("home").style.display = "block";
}

function Play() {
  var username = document.getElementById("username");
  var difficulty = document.getElementById("level");
  
  // Validasi username
  if (!username.checkValidity()) {
    username.reportValidity();
    return;
  }
  
  // Validasi level - pastikan bukan value "0" (default)
  if (difficulty.value === "0" || difficulty.value === "") {
    difficulty.setCustomValidity("Please select a difficulty level");
    difficulty.reportValidity();
    return;
  } else {
    difficulty.setCustomValidity("");
  }
  
  // Show loading screen
  showLoadingScreen();
  
  // Simulate loading for 3 seconds
  setTimeout(() => {
    hideLoadingScreen();
    document.getElementById("home").style.display = "none";
    document.getElementById("game").style.display = "block";
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

// ESC key for pause
document.addEventListener('keydown', function(event) {
  if (event.key === 'Escape') {
    if (document.getElementById("game").style.display === "block") {
      if (isPaused) {
        resumeGame();
      } else {
        pauseGame();
      }
    }
  }
});

// Add event listener for form submission
document.addEventListener('DOMContentLoaded', function() {
  const form = document.querySelector('.form');
  if (form) {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      Play();
    });
  }
});
