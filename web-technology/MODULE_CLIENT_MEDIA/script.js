// BOMSKUY - client-side game (ES5 only, no modules)

// CONFIG
var config = {
  gridSize: 11,
  gridHeight: 9,
  playerStartPosition: 12, // top-left walkable corner (row 1, col 1)
  wallCount: 15,
  exclusionRadius: 2,
  initialTime: 180,
  maxHearts: 3,
  initialExplosionRange: 1,
  itemRevealProbability: 0.5,
  bombTimer: 5000,
  freezeDuration: 5000,
  explosionDisplayTime: 1000,
  collectAnimationTime: 500,
  loadingCountdown: 3000,
  tickInterval: 250, // game loop tick (ms)
  dogMoveEveryTicks: 4, // dog moves every 1000ms
  timerEveryTicks: 4, // timer decrements every 1000ms
  imageBasePath: "Images/"
};

// STATE
var isPaused = false;
var gameLoopInterval = null;
var tickCount = 0;
var timeLeft = config.initialTime;
var difficultyLevel = 1;
var isGameRunning = false;

var player = {
  position: config.playerStartPosition,
  hearts: config.maxHearts,
  explosionRange: config.initialExplosionRange,
  frozenUntil: 0
};

var wallsDestroyed = 0;
var tntsCollected = 0;
var icesCollected = 0;

var matchData = { username: "", time: 0, walls: 0, tnts: 0, ices: 0, score: 0 };

var dogs = [];
var bombs = []; // { cell, element, explodeAt }
var username = null;
var gridItems = [];

// UTILITY FUNCTIONS
function getCoords(index) {
  return { row: Math.floor(index / config.gridSize), col: index % config.gridSize };
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
  var coords = getCoords(newIndex);
  if (isWall(coords.row, coords.col)) return false;
  var targetItem = gridItems[newIndex];
  if (targetItem === undefined) return false;
  return !targetItem.querySelector(".wall") && !targetItem.querySelector(".dog");
}

function getDirectionTowardsPlayer(dogPos, playerPos) {
  var dogCoords = getCoords(dogPos);
  var playerCoords = getCoords(playerPos);
  var dir = "down";
  if (Math.abs(playerCoords.row - dogCoords.row) > Math.abs(playerCoords.col - dogCoords.col)) {
    dir = playerCoords.row > dogCoords.row ? "down" : "up";
  } else {
    dir = playerCoords.col > dogCoords.col ? "right" : "left";
  }
  return dir;
}

function formatTime(seconds) {
  var minutes = Math.floor(seconds / 60);
  var secs = seconds % 60;
  var secsStr = "" + secs;
  if (secsStr.length < 2) secsStr = "0" + secsStr;
  return minutes + ":" + secsStr;
}

// GRID SETUP
function clearGrid() {
  for (var i = 0; i < gridItems.length; i++) {
    var cell = gridItems[i];
    var junk = cell.querySelectorAll(".wall, .dog, .item, .bomb, .explosion, .item-mark");
    for (var j = 0; j < junk.length; j++) {
      if (junk[j].parentNode === cell) cell.removeChild(junk[j]);
    }
  }
}

function placeRandomElements() {
  var totalGrid = gridItems.length;
  var occupiedPositions = [player.position];
  var i;

  for (i = 0; i < totalGrid; i++) {
    var c = getCoords(i);
    if (isWall(c.row, c.col)) occupiedPositions.push(i);
  }

  var playerCoords = getCoords(player.position);
  var radius = config.exclusionRadius;
  for (i = 0; i < totalGrid; i++) {
    var cc = getCoords(i);
    var dist = Math.abs(cc.row - playerCoords.row) + Math.abs(cc.col - playerCoords.col);
    if (dist <= radius && occupiedPositions.indexOf(i) === -1) occupiedPositions.push(i);
  }

  function getRandomPosition(exclude) {
    var pos;
    var guard = 0;
    do {
      pos = Math.floor(Math.random() * totalGrid);
      guard++;
    } while (exclude.indexOf(pos) !== -1 && guard < 1000);
    return pos;
  }

  var dogCount = difficultyLevel;
  for (i = 0; i < dogCount; i++) {
    var dogPos = getRandomPosition(occupiedPositions);
    if (occupiedPositions.indexOf(dogPos) !== -1) continue;
    occupiedPositions.push(dogPos);
    var dogImg = document.createElement("img");
    dogImg.className = "dog";
    dogImg.src = config.imageBasePath + "dog_down.png";
    dogImg.alt = "dog";
    gridItems[dogPos].appendChild(dogImg);
    dogs.push({ position: dogPos, direction: "down", element: dogImg });
  }

  for (i = 0; i < config.wallCount; i++) {
    var wallPos = getRandomPosition(occupiedPositions);
    if (occupiedPositions.indexOf(wallPos) !== -1) continue;
    occupiedPositions.push(wallPos);
    var wallImg = document.createElement("img");
    wallImg.className = "wall";
    wallImg.src = config.imageBasePath + "wall.png";
    wallImg.alt = "wall";
    gridItems[wallPos].appendChild(wallImg);
  }
}

// LOADING / COUNTDOWN
function showLoadingScreen() {
  document.getElementById("loading-overlay").style.display = "flex";
  var countdown = 3;
  var countdownElement = document.querySelector(".countdown");
  countdownElement.textContent = countdown;
  var iv = setInterval(function () {
    countdown--;
    countdownElement.textContent = countdown;
    if (countdown <= 0) clearInterval(iv);
  }, 1000);
}

function hideLoadingScreen() {
  document.getElementById("loading-overlay").style.display = "none";
}

// PLAYER MECHANICS
function getPlayerWrap() {
  return document.querySelector(".player-wrap");
}

function movePlayer(direction) {
  if (Date.now() < player.frozenUntil) return;
  var coords = getCoords(player.position);
  var newRow = coords.row;
  var newCol = coords.col;

  switch (direction) {
    case "up": newRow--; break;
    case "down": newRow++; break;
    case "left": newCol--; break;
    case "right": newCol++; break;
  }

  var newIndex = getIndex(newRow, newCol);
  if (!isValidMove(newIndex)) return;

  var wrap = getPlayerWrap();
  var targetItem = gridItems[newIndex];
  targetItem.appendChild(wrap);

  var playerImg = wrap.querySelector(".player");
  playerImg.src = config.imageBasePath + "char_" + direction + ".png";

  // walking animation
  playerImg.classList.remove("walking");
  void playerImg.offsetWidth; // restart animation
  playerImg.classList.add("walking");

  player.position = newIndex;
  checkItemPickup(gridItems[player.position]);

  if (gridItems[player.position].querySelector(".dog")) {
    playerHit();
  }
}

function animateCollect(element, cell) {
  element.classList.add("collecting");
  setTimeout(function () {
    if (cell.contains(element)) cell.removeChild(element);
  }, config.collectAnimationTime);
}

function checkItemPickup(cell) {
  var item = cell.querySelector(".item");
  if (item) {
    var type = item.className.replace("item", "").replace("collecting", "").trim();
    animateCollect(item, cell);
    var capturedType = type;
    setTimeout(function () {
      applyItemEffect(capturedType);
    }, config.collectAnimationTime / 2);
  }
}

function applyItemEffect(type) {
  var wrap = getPlayerWrap();
  switch (type) {
    case "heart":
      player.hearts = Math.max(0, player.hearts - 1);
      updateHeartUI();
      flashPlayer();
      if (player.hearts <= 0) triggerGameOver();
      break;
    case "tnt":
      player.explosionRange += 1;
      tntsCollected++;
      updateTNTUI();
      if (!wrap.querySelector(".tnt-mark")) {
        var tntMark = document.createElement("img");
        tntMark.src = config.imageBasePath + "tnt.png";
        tntMark.className = "tnt-mark item-mark";
        wrap.appendChild(tntMark);
      }
      break;
    case "ice":
      freezePlayerMovement(config.freezeDuration);
      icesCollected++;
      updateIceUI();
      if (!wrap.querySelector(".ice-mark")) {
        var iceMark = document.createElement("img");
        iceMark.src = config.imageBasePath + "ice.png";
        iceMark.className = "ice-mark item-mark";
        wrap.appendChild(iceMark);
      }
      break;
  }
}

function freezePlayerMovement(duration) {
  player.frozenUntil = Date.now() + duration;
  var wrap = getPlayerWrap();
  var playerImg = wrap.querySelector(".player");
  if (playerImg) playerImg.classList.add("frozen");
  setTimeout(function () {
    if (playerImg) playerImg.classList.remove("frozen");
  }, duration);
}

function flashPlayer() {
  var img = document.querySelector(".player");
  if (!img) return;
  img.classList.add("hit");
  setTimeout(function () {
    img.classList.remove("hit");
  }, config.collectAnimationTime);
}

function playerHit() {
  player.hearts = Math.max(0, player.hearts - 1);
  updateHeartUI();
  flashPlayer();
  if (player.hearts <= 0) triggerGameOver();
}

// ENEMY MECHANICS
function attemptDogMove(dog, dir) {
  var coords = getCoords(dog.position);
  var newRow = coords.row;
  var newCol = coords.col;
  switch (dir) {
    case "up": newRow--; break;
    case "down": newRow++; break;
    case "left": newCol--; break;
    case "right": newCol++; break;
  }
  var newIndex = getIndex(newRow, newCol);
  if (!isValidMove(newIndex)) return false;
  var oldCell = gridItems[dog.position];
  if (dog.element.parentNode === oldCell) oldCell.removeChild(dog.element);
  gridItems[newIndex].appendChild(dog.element);
  dog.position = newIndex;
  dog.direction = dir;
  updateDogImage(dog);
  if (dog.position === player.position) playerHit();
  return true;
}

function updateDogImage(dog) {
  dog.element.src = config.imageBasePath + "dog_" + dog.direction + ".png";
}

function updateDogs() {
  for (var i = 0; i < dogs.length; i++) {
    var dog = dogs[i];
    var primaryDir = getDirectionTowardsPlayer(dog.position, player.position);
    if (attemptDogMove(dog, primaryDir)) continue;

    var dogCoords = getCoords(dog.position);
    var playerCoords = getCoords(player.position);
    var secondaryDir;
    if (primaryDir === "up" || primaryDir === "down") {
      secondaryDir = playerCoords.col > dogCoords.col ? "right" : "left";
    } else {
      secondaryDir = playerCoords.row > dogCoords.row ? "down" : "up";
    }
    if (attemptDogMove(dog, secondaryDir)) continue;

    var oppositeDir;
    switch (primaryDir) {
      case "up": oppositeDir = "down"; break;
      case "down": oppositeDir = "up"; break;
      case "left": oppositeDir = "right"; break;
      case "right": oppositeDir = "left"; break;
    }
    attemptDogMove(dog, oppositeDir);
  }
}

// BOMB MECHANICS
function placeBombAtPlayerPosition() {
  var cell = gridItems[player.position];
  if (cell.querySelector(".bomb")) return;
  var bomb = document.createElement("img");
  bomb.src = config.imageBasePath + "bomb.png";
  bomb.className = "bomb";
  cell.appendChild(bomb);
  bombs.push({ cell: cell, element: bomb, explodeAt: Date.now() + config.bombTimer });
}

function destroyWall(cell) {
  var wall = cell.querySelector(".wall");
  if (wall) {
    cell.removeChild(wall);
    wallsDestroyed++;
    updateWallUI();
    setTimeout(function () {
      maybeRevealItem(cell);
    }, config.explosionDisplayTime);
  }
}

function maybeRevealItem(cell) {
  var items = ["heart", "tnt", "ice"];
  if (Math.random() < config.itemRevealProbability) {
    var itemType = items[Math.floor(Math.random() * items.length)];
    var item = document.createElement("img");
    item.src = config.imageBasePath + itemType + ".png";
    item.className = "item " + itemType;
    cell.appendChild(item);
  }
}

function applyExplosionEffect(cell) {
  if (cell.querySelector(".wall")) {
    destroyWall(cell);
  }
  var dogEl = cell.querySelector(".dog");
  if (dogEl) {
    cell.removeChild(dogEl);
    for (var i = 0; i < dogs.length; i++) {
      if (dogs[i].element === dogEl) {
        dogs.splice(i, 1);
        break;
      }
    }
  }
}

function explodeInDirection(row, col, deltaRow, deltaCol, range, index, affectedCells) {
  for (var i = 1; i <= range; i++) {
    var r = row + deltaRow * i;
    var c = col + deltaCol * i;
    if (isWall(r, c)) break;
    var adjIndex = getIndex(r, c);
    if (adjIndex >= 0 && adjIndex < gridItems.length) {
      var adjCell = gridItems[adjIndex];
      applyExplosionEffect(adjCell);
      if (adjIndex === player.position) playerHit();
      if (!adjCell.querySelector(".explosion")) {
        var explosionImg = document.createElement("img");
        explosionImg.src = config.imageBasePath + "bomb_explode.png";
        explosionImg.className = "explosion";
        adjCell.appendChild(explosionImg);
        affectedCells.push(adjCell);
      }
    }
  }
}

function explodeBomb(bombObj) {
  var cell = bombObj.cell;
  cell.querySelector(".bomb").src = config.imageBasePath + "bomb_explode.png";
  var index = -1;
  for (var i = 0; i < gridItems.length; i++) {
    if (gridItems[i] === cell) { index = i; break; }
  }
  var coords = getCoords(index);
  var affectedCells = [];

  explodeInDirection(coords.row, coords.col, -1, 0, player.explosionRange, index, affectedCells);
  explodeInDirection(coords.row, coords.col, 1, 0, player.explosionRange, index, affectedCells);
  explodeInDirection(coords.row, coords.col, 0, -1, player.explosionRange, index, affectedCells);
  explodeInDirection(coords.row, coords.col, 0, 1, player.explosionRange, index, affectedCells);

  // player standing on bomb cell
  if (index === player.position) playerHit();

  setTimeout(function () {
    var bombEl = cell.querySelector(".bomb");
    if (bombEl) cell.removeChild(bombEl);
    for (var j = 0; j < affectedCells.length; j++) {
      var explosion = affectedCells[j].querySelector(".explosion");
      if (explosion) affectedCells[j].removeChild(explosion);
    }
  }, config.explosionDisplayTime);
}

function tickBombs() {
  var now = Date.now();
  var exploded = [];
  for (var i = 0; i < bombs.length; i++) {
    if (now >= bombs[i].explodeAt) {
      exploded.push(bombs[i]);
    }
  }
  for (var j = 0; j < exploded.length; j++) {
    var idx = bombs.indexOf(exploded[j]);
    if (idx !== -1) bombs.splice(idx, 1);
    if (!isGameRunning) continue;
    explodeBomb(exploded[j]);
  }
}

// UI UPDATES
function updateHeartUI() {
  var heartIndicator = document.querySelector(".heart-indicator");
  var heartImages = [
    config.imageBasePath + "heart_indicator3.png", // 0 hearts
    config.imageBasePath + "heart_indicator2.png", // 1 heart
    config.imageBasePath + "heart_indicator1.png", // 2 hearts
    config.imageBasePath + "heart_indicator.png" // 3 hearts
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

function updateTimerUI() {
  var timerElement = document.getElementById("time");
  timerElement.textContent = ": " + formatTime(timeLeft);
  if (timeLeft <= 10) {
    timerElement.style.color = "red";
  } else {
    timerElement.style.color = "";
  }
}

// GAME LOOP
function gameTick() {
  tickCount++;
  tickBombs();
  if (tickCount % config.dogMoveEveryTicks === 0) {
    updateDogs();
  }
  if (tickCount % config.timerEveryTicks === 0) {
    if (timeLeft <= 0) {
      triggerGameOver();
      return;
    }
    timeLeft--;
    updateTimerUI();
  }
}

function startGameLoop() {
  isGameRunning = true;
  tickCount = 0;
  gameLoopInterval = setInterval(gameTick, config.tickInterval);
}

function stopGameLoop() {
  isGameRunning = false;
  if (gameLoopInterval) {
    clearInterval(gameLoopInterval);
    gameLoopInterval = null;
  }
}

// GAME CONTROL
function pauseGame() {
  if (isPaused || !isGameRunning) return;
  isPaused = true;
  stopGameLoop();
  // freeze pending bombs
  var now = Date.now();
  for (var i = 0; i < bombs.length; i++) {
    bombs[i].pauseRemaining = bombs[i].explodeAt - now;
  }
  document.getElementById("pause-overlay").style.display = "flex";
}

function resumeGame() {
  if (!isPaused) return;
  isPaused = false;
  document.getElementById("pause-overlay").style.display = "none";
  // unfreeze bombs
  var now = Date.now();
  for (var i = 0; i < bombs.length; i++) {
    if (typeof bombs[i].pauseRemaining === "number") {
      bombs[i].explodeAt = now + bombs[i].pauseRemaining;
      bombs[i].pauseRemaining = undefined;
    }
  }
  startGameLoop();
}

function resetGameState() {
  stopGameLoop();
  isPaused = false;
  player.position = config.playerStartPosition;
  player.hearts = config.maxHearts;
  player.explosionRange = config.initialExplosionRange;
  player.frozenUntil = 0;
  wallsDestroyed = 0;
  tntsCollected = 0;
  icesCollected = 0;
  timeLeft = config.initialTime;
  dogs = [];
  bombs = [];
  var playerImg = document.querySelector(".player");
  if (playerImg) {
    playerImg.src = config.imageBasePath + "char_down.png";
    playerImg.classList.remove("frozen", "hit");
  }
  updateHeartUI();
  updateWallUI();
  updateTNTUI();
  updateIceUI();
  updateTimerUI();
  var timerElement = document.getElementById("time");
  timerElement.style.color = "";
  document.getElementById("pause-overlay").style.display = "none";
}

function hideAllScreens() {
  var ids = ["home", "difficulty-screen", "instruction", "game", "gameover", "leaderboard"];
  for (var i = 0; i < ids.length; i++) {
    document.getElementById(ids[i]).style.display = "none";
  }
}

function beginRound() {
  resetGameState();
  showLoadingScreen();
  setTimeout(function () {
    hideAllScreens();
    hideLoadingScreen();
    document.getElementById("game").style.display = "block";
    clearGrid();
    placeRandomElements();
    var wrap = getPlayerWrap();
    gridItems[player.position].appendChild(wrap);
    matchData.username = username.value;
    document.getElementById("nickname").textContent = ": " + username.value;
    startGameLoop();
  }, config.loadingCountdown);
}

function Play() {
  if (!username.value || username.value.trim() === "") {
    username.reportValidity();
    return;
  }
  hideAllScreens();
  document.getElementById("difficulty-screen").style.display = "block";
}

function selectDifficulty(level) {
  difficultyLevel = level;
  beginRound();
}

function Instruction() {
  hideAllScreens();
  document.getElementById("instruction").style.display = "block";
}

function CloseInstruction() {
  hideAllScreens();
  document.getElementById("home").style.display = "block";
}

function goToHome() {
  hideAllScreens();
  resetGameState();
  document.getElementById("home").style.display = "block";
}

function triggerGameOver() {
  stopGameLoop();
  matchData.time = config.initialTime - timeLeft;
  matchData.walls = wallsDestroyed;
  matchData.tnts = tntsCollected;
  matchData.ices = icesCollected;
  matchData.score = wallsDestroyed * 10 + tntsCollected * 20 + icesCollected * 5;

  var subtitle = document.querySelector(".subtitle-gameover");
  subtitle.textContent = "Good job " + matchData.username + "! Your time " + formatTime(matchData.time) + " with result:";
  document.getElementById("gameover-score").textContent = "Total Score: " + matchData.score;
  document.getElementById("gameover-walls").textContent = "= " + wallsDestroyed;
  document.getElementById("gameover-tnt").textContent = "= " + tntsCollected;
  document.getElementById("gameover-ice").textContent = "= " + icesCollected;

  hideAllScreens();
  document.getElementById("gameover").style.display = "block";
}

// LEADERBOARD
function computeScore(match) {
  return match.walls * 10 + match.tnts * 20 + match.ices * 5;
}

function displayLeaderboard() {
  var matches = [];
  try {
    matches = JSON.parse(localStorage.getItem("matches") || "[]");
  } catch (e) {
    matches = [];
  }
  // sort by walls desc, then tnts desc, then ices desc
  matches.sort(function (a, b) {
    if (b.walls !== a.walls) return b.walls - a.walls;
    if (b.tnts !== a.tnts) return b.tnts - a.tnts;
    return b.ices - a.ices;
  });
  var topMatches = matches.slice(0, 3);
  var tbody = document.querySelector("#leaderboard tbody");
  var html = "";
  for (var i = 0; i < topMatches.length; i++) {
    var match = topMatches[i];
    var rowClass = i === 0 ? ' class="row-mid-leaderboard"' : "";
    html += "<tr" + rowClass + ">" +
      '<td class="stat-leaderboard">' + match.username + "</td>" +
      '<td class="stats-leaderboard">' + formatTime(match.time) + "</td>" +
      '<td class="stats-leaderboard">' + match.walls + "</td>" +
      '<td class="stats-leaderboard">' + match.tnts + "</td>" +
      '<td class="stats-leaderboard">' + match.ices + "</td>" +
      "</tr>";
  }
  tbody.innerHTML = html;
}

function saveScore() {
  var matches = [];
  try {
    matches = JSON.parse(localStorage.getItem("matches") || "[]");
  } catch (e) {
    matches = [];
  }
  matches.push(matchData);
  localStorage.setItem("matches", JSON.stringify(matches));
  leaderboard();
}

function leaderboard() {
  hideAllScreens();
  document.getElementById("leaderboard").style.display = "block";
  displayLeaderboard();
}

function playAgain() {
  hideAllScreens();
  beginRound();
}

function resetLeaderboard() {
  localStorage.removeItem("matches");
  displayLeaderboard();
}

// EVENT HANDLING
document.addEventListener("keydown", function (event) {
  var gameVisible = document.getElementById("game").style.display === "block";

  if (event.key === "Escape") {
    if (gameVisible) {
      if (isPaused) {
        resumeGame();
      } else {
        pauseGame();
      }
      event.preventDefault();
    }
    return;
  }

  if (!gameVisible || isPaused) return;
  if (Date.now() < player.frozenUntil && event.code !== "Space") return;

  switch (event.key) {
    case "w":
    case "ArrowUp":
      movePlayer("up");
      event.preventDefault();
      break;
    case "s":
    case "ArrowDown":
      movePlayer("down");
      event.preventDefault();
      break;
    case "a":
    case "ArrowLeft":
      movePlayer("left");
      event.preventDefault();
      break;
    case "d":
    case "ArrowRight":
      movePlayer("right");
      event.preventDefault();
      break;
  }

  if (event.code === "Space") {
    placeBombAtPlayerPosition();
    event.preventDefault();
  }
});

// INITIALIZATION
document.addEventListener("DOMContentLoaded", function () {
  username = document.getElementById("username");
  gridItems = document.querySelectorAll(".grid-item");
  gridItems = Array.prototype.slice.call(gridItems);

  var playBtn = document.getElementById("button-play");
  playBtn.disabled = true;

  username.addEventListener("input", function () {
    playBtn.disabled = !username.value || username.value.trim() === "";
  });

  var form = document.querySelector(".form");
  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      Play();
    });
  }

  document.getElementById("home").style.display = "block";
});
