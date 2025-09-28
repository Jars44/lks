# BOMBSKUY Client-Side Module Implementation Guide

This guide provides detailed step-by-step instructions to implement the client-side features of the BOMBSKUY game based on the project requirements and existing code structure. Each section includes explanations, implementation tips, and example code snippets to help you understand and apply the concepts effectively.

---

## 1. Bomb Placement and Explosion Timing

- **Trigger bomb placement:**

  - Add an event listener for the Space key press in your keydown event handler.
  - Before placing a bomb, check if the player is allowed to place a bomb at the current position (e.g., no existing bomb in that cell).
  - If allowed, proceed to place the bomb.
  - Example snippet to detect Space key and place bomb:

  ```javascript
  document.addEventListener("keydown", (event) => {
    if (event.code === "Space") {
      placeBombAtPlayerPosition();
    }
  });
  ```

- **Bomb object creation:**

  - Create a bomb element, such as an `<img>` tag with the bomb image source.
  - Append this bomb element to the grid cell corresponding to the player's current position.
  - Example:

  ```javascript
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
  ```

- **Explosion timer:**

  - Use JavaScript's `setTimeout` function to schedule the bomb explosion 5 seconds after placement.
  - Store the timer ID if you need to cancel or manage multiple bombs.
  - Example:

  ```javascript
  function scheduleExplosion(bomb, cell) {
    setTimeout(() => {
      explodeBomb(bomb, cell);
    }, 5000);
  }
  ```

- **Explosion effect:**

  - When the timer triggers, replace the bomb element with an explosion animation element or change its image to an explosion.
  - Apply the explosion effect to the bomb's cell and adjacent cells in the four directions (up, down, left, right) based on the current explosion range.
  - Use CSS animations or swap images to show the explosion visually.
  - Example:

  ```javascript
  function explodeBomb(bomb, cell) {
    bomb.src = "Images/bomb_explode.png";
    applyExplosionEffect(cell);
    setTimeout(() => {
      clearExplosion(cell);
    }, 1000);
  }
  ```

- **Explosion range:**

  - Initialize the explosion range to 1 cell in each direction.
  - Increase this range dynamically if the player collects TNT items.
  - Keep track of the current explosion range in a variable, e.g., `player.explosionRange`.

- **Remove bomb element:**
  - After the explosion animation completes (e.g., after a short delay), remove the explosion elements from the grid cells to clear the effect.

---

## 2. Explosion Effects on Walls and Revealing Items

- **Detect walls in explosion range:**

  - For each cell affected by the explosion, check if it contains a wall element.
  - Example:

  ```javascript
  function applyExplosionEffect(cell) {
    if (cell.querySelector(".wall")) {
      destroyWall(cell);
    }
    // Apply explosion visuals here
  }
  ```

- **Destroy walls:**

  - Remove the wall element from the grid cell if it is hit by the explosion.
  - Example:

  ```javascript
  function destroyWall(cell) {
    const wall = cell.querySelector(".wall");
    if (wall) {
      cell.removeChild(wall);
      maybeRevealItem(cell);
    }
  }
  ```

- **Reveal hidden items:**

  - Some walls hide items (Broken Heart, TNT, Ice Cube). When a wall is destroyed, randomly decide if an item should be revealed in that cell.
  - If yes, append the corresponding item element to the cell.
  - Example:

  ```javascript
  function maybeRevealItem(cell) {
    const items = ["heart", "tnt", "ice"];
    if (Math.random() < 0.3) {
      // 30% chance to reveal
      const itemType = items[Math.floor(Math.random() * items.length)];
      const item = document.createElement("img");
      item.src = `Images/${itemType}.png`;
      item.classList.add("item", itemType);
      cell.appendChild(item);
    }
  }
  ```

- **Item images:**
  - Use the provided images for each item type and append them to the grid cell.

---

## 3. Item Effects on Player and Status Marks

- **Item pickup detection:**

  - When the player moves onto a cell containing an item, detect the collision and remove the item from the grid.
  - Example:

  ```javascript
  function checkItemPickup(cell) {
    const item = cell.querySelector(".item");
    if (item) {
      applyItemEffect(item.classList[1]);
      cell.removeChild(item);
    }
  }
  ```

- **Apply item effects:**

  - **Broken Heart:** Decrease the player's hearts by 1 and update the heart indicator UI.
  - **TNT:** Double the bomb explosion range for subsequent bombs.
  - **Ice Cube:** Freeze the player's movement for 5 seconds (disable movement input).
  - Example:

  ```javascript
  function applyItemEffect(type) {
    switch (type) {
      case "heart":
        player.hearts = Math.max(0, player.hearts - 1);
        updateHeartUI();
        break;
      case "tnt":
        player.explosionRange *= 2;
        showStatusMark("tnt");
        break;
      case "ice":
        freezePlayerMovement(5000);
        showStatusMark("ice");
        break;
    }
  }
  ```

- **Player status marks:**

  - Display visual marks or icons on the player character to indicate collected items (e.g., overlay TNT or Ice Cube icons).

- **Counters:**
  - Maintain counters for destroyed walls, TNT earned, and ice cubes obtained. Update and display these counters in the UI.

---

## 4. Player Walking Animation

- **Animation frames:**

  - Use different character images for walking in each direction (already available in the images folder).
  - Example:

  ```javascript
  function updatePlayerImage(direction) {
    player.img.src = `Images/char_${direction}.png`;
  }
  ```

- **Animation trigger:**

  - Change the player image source to the appropriate walking frame when the player moves in a direction.

- **Smooth movement:**
  - Optionally, implement CSS transitions or JavaScript animations to make movement smoother.

---

## 5. Dog AI Movement and Player Search

- **Dog movement:**

  - Implement periodic random movement for each dog on the grid, ensuring they avoid walls, bombs, and other obstacles.
  - Example:

  ```javascript
  function moveDogRandomly(dog) {
    const directions = ["up", "down", "left", "right"];
    const dir = directions[Math.floor(Math.random() * directions.length)];
    attemptMoveDog(dog, dir);
  }
  ```

- **Player search AI:**

  - Implement a simple AI algorithm where dogs move towards the player if within a certain detection range.
  - Example:

  ```javascript
  function dogChasePlayer(dog) {
    if (distance(dog, player) < detectionRange) {
      moveDogTowardsPlayer(dog);
    }
  }
  ```

- **Dog images:**
  - Change dog images based on their movement direction to simulate walking.

---

## 6. Player Health Decrease and Animations on Hit

- **Health decrease:**

  - Decrease the player's hearts if they are hit by a bomb explosion or touch a dog.

- **Hit animation:**

  - Show a brief animation or visual effect on the player character when hit (e.g., flashing or shaking).
  - Example:

  ```javascript
  function playerHit() {
    player.hearts--;
    flashPlayer();
    if (player.hearts <= 0) {
      triggerGameOver();
    }
  }
  ```

- **Game over condition:**
  - Trigger the game over state when the player's hearts reach zero.

---

## 7. Defining Player Object and Global Variables

- **Player object:**

  - Replace the simple `playerPosition` variable with a player object to hold more properties.
  - Example:

  ```javascript
  let player = {
    position: 23,
    hearts: 3,
    explosionRange: 1,
    direction: 'down',
    frozenUntil: 0
  };
  ```

- **Global counters:**

  - Add counters for game statistics.
  - Example:

  ```javascript
  let wallsDestroyed = 0;
  let tntsCollected = 0;
  let icesCollected = 0;
  ```

- **Match data object:**

  - Store match information for leaderboards.
  - Example:

  ```javascript
  let matchData = {
    username: '',
    time: 180,
    walls: 0,
    tnts: 0,
    ices: 0
  };
  ```

- **Update references:**

  - Change all `playerPosition` to `player.position`.
  - In `Play()`: Set `matchData.username = username.value; matchData.time = timeLeft;`

---

## 8. Enhancing Bomb Explosion with Range

- **Fix placeBombAtPlayerPosition:**

  - Use `gridItems[player.position]` instead of undefined `player.x, player.y`.
  - Example:

  ```javascript
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
  ```

- **Add getGridCell function:**

  - If needed, but since gridItems is an array, use index directly.

- **Enhance explodeBomb:**

  - Propagate explosion to adjacent cells based on `player.explosionRange`.
  - Example:

  ```javascript
  function explodeBomb(bomb, cell) {
    bomb.src = "Images/bomb_explode.png";
    const index = Array.from(gridItems).indexOf(cell);
    const { row, col } = getCoords(index);
    for (let r = row - player.explosionRange; r <= row + player.explosionRange; r++) {
      for (let c = col - player.explosionRange; c <= col + player.explosionRange; c++) {
        if (r === row || c === col) {
          const adjIndex = getIndex(r, c);
          if (adjIndex >= 0 && adjIndex < gridItems.length) {
            applyExplosionEffect(gridItems[adjIndex]);
          }
        }
      }
    }
    setTimeout(() => {
      clearExplosion(cell);
    }, 1000);
  }
  ```

- **Add clearExplosion:**

  - Remove explosion image after delay.
  - Example:

  ```javascript
  function clearExplosion(cell) {
    const explosion = cell.querySelector(".bomb");
    if (explosion) cell.removeChild(explosion);
  }
  ```

- **Update range on TNT:**

  - In `applyItemEffect`, for 'tnt': `player.explosionRange *= 2;`

---

## 9. Item Pickup Integration and Freeze Movement

- **Integrate checkItemPickup in movePlayer:**

  - After moving, check the new cell for items.
  - Example: In `movePlayer`, after `playerPosition = newIndex;`, add `checkItemPickup(gridItems[newIndex]);`

- **Fix checkItemPickup:**

  - Take cell as parameter.
  - Example:

  ```javascript
  function checkItemPickup(cell) {
    const item = cell.querySelector(".item");
    if (item) {
      const type = item.classList[1];
      applyItemEffect(type);
      cell.removeChild(item);
    }
  }
  ```

- **Update applyItemEffect:**

  - For 'tnt': `player.explosionRange *= 2; tntsCollected++;`
  - For 'ice': `freezePlayerMovement(5000); icesCollected++;`

- **Implement freezePlayerMovement:**

  - Set `player.frozenUntil = Date.now() + duration;`
  - Example:

  ```javascript
  function freezePlayerMovement(duration) {
    player.frozenUntil = Date.now() + duration;
  }
  ```

- **Check frozen in keydown:**

  - In keydown event, before handling keys: `if (Date.now() < player.frozenUntil) return;`

- **Update counters and UI:**

  - Implement `updateWallUI()`, `updateTNTUI()`, `updateIceUI()` to display counters.

---

## 10. Dog AI Movement

- **Dogs array:**

  - Add `let dogs = [];`

- **Update placeRandomElements:**

  - Push dog objects to dogs array.
  - Example: Instead of appending img, `dogs.push({ position: pos, direction: 'down' });` and append img.

- **Add gameInterval:**

  - `gameInterval = setInterval(updateDogs, 1000);`

- **Implement updateDogs:**

  - For each dog, decide to chase or random move.
  - Example:

  ```javascript
  function updateDogs() {
    dogs.forEach(dog => {
      if (Math.random() < 0.5) {
        moveTowardsPlayer(dog);
      } else {
        moveDogRandomly(dog);
      }
      updateDogImage(dog);
    });
  }
  ```

- **Implement moveDogRandomly and moveTowardsPlayer:**

  - Similar to player move, but for dogs, check if move to player position triggers hit.

- **Update dog img:**

  - `function updateDogImage(dog) { const img = gridItems[dog.position].querySelector('.dog'); img.src = `Images/dog_${dog.direction}.png`; }`

- **Remove dogs in explosion:**

  - In `applyExplosionEffect`, if cell has dog, remove and splice from dogs array.

---

## 11. Player Health and Hit Detection

- **Implement playerHit:**

  - As above.

- **In explosion:**

  - If player's position is in affected cells, call `playerHit()`.

- **In dog move:**

  - If dog moves to `player.position`, call `playerHit()`.

- **Implement flashPlayer:**

  - Toggle a class or change img briefly.
  - Example:

  ```javascript
  function flashPlayer() {
    const img = document.querySelector('.player');
    img.classList.add('hit');
    setTimeout(() => img.classList.remove('hit'), 500);
  }
  ```

- **Implement updateHeartUI:**

  - Show/hide heart images based on `player.hearts`.

---

## 12. UI Updates and Counters

- **Implement update functions:**

  - `function updateWallUI() { document.getElementById('walls').textContent = wallsDestroyed; }`
  - Similarly for TNT and Ice.

- **In gameover:**

  - Update matchData with final values, save to localStorage.

- **Implement triggerGameOver:**

  - Show gameover screen, stop intervals.

---

## 13. Local Storage for Leaderboards

- **Save in gameover:**

  - `let matches = JSON.parse(localStorage.getItem('matches') || '[]'); matches.push(matchData); localStorage.setItem('matches', JSON.stringify(matches));`

- **Implement leaderboard:**

  - Load, sort by score (e.g., walls + tnts*10 + ices*5), render table.

- **Reset function:**

  - `localStorage.removeItem('matches');`

- **Play Again:**

  - Reset variables, call Play().

---

## 14. Other Fixes

- **showStatusMark:**

  - Append img to player cell, remove after duration.
  - Example:

  ```javascript
  function showStatusMark(type) {
    const mark = document.createElement('img');
    mark.src = `Images/${type}.png`;
    mark.classList.add('status-mark');
    gridItems[player.position].appendChild(mark);
    setTimeout(() => mark.remove(), 3000);
  }
  ```

- **Timer end:**

  - In startTimer, when timeLeft <=0, call `triggerGameOver()`.

---

## 15. Integrating Item Pickup in Player Movement

- **Fix checkItemPickup function:**

  - The function currently has an undefined `cell` variable. Update it to accept `cell` as a parameter.
  - Example:

  ```javascript
  function checkItemPickup(cell) {
    const item = cell.querySelector(".item");
    if (item) {
      const type = item.classList[1];
      applyItemEffect(type);
      cell.removeChild(item);
    }
  }
  ```

- **Integrate in movePlayer:**

  - After successfully moving the player and updating `playerPosition`, call `checkItemPickup(gridItems[playerPosition]);`
  - This ensures items are picked up when the player steps on them.
  - Example: Add `checkItemPickup(gridItems[playerPosition]);` after `playerPosition = newIndex;`

---

## 16. Populating Dogs Array and Starting Dog AI

- **Update placeRandomElements:**

  - Instead of just appending dog images, create dog objects and push to the `dogs` array.
  - Each dog object should have `position`, `direction`, and `element` (the img).
  - Example:

  ```javascript
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
  ```

- **Start dog AI in Play:**

  - After starting the timer, set `gameInterval = setInterval(updateDogs, 1000);`
  - This will periodically update dog movements.

- **Clear interval in game over:**

  - In `triggerGameOver`, add `clearInterval(gameInterval);`

---

## 17. Defining Missing Dog AI Functions

- **Define detectionRange:**

  - Add `const detectionRange = 5;` at the top with other constants.

- **Define distance function:**

  - A simple distance based on grid positions.
  - Example:

  ```javascript
  function distance(dog, player) {
    const dogCoords = getCoords(dog.position);
    const playerCoords = getCoords(player.position);
    return Math.abs(dogCoords.row - playerCoords.row) + Math.abs(dogCoords.col - playerCoords.col);
  }
  ```

- **Implement attemptDogMove:**

  - Similar to movePlayer, but for dogs. Update position and direction if valid.
  - Example:

  ```javascript
  function attemptDogMove(dog, dir) {
    const { row, col } = getCoords(dog.position);
    let newRow = row;
    let newCol = col;
    switch (dir) {
      case "up": newRow--; break;
      case "down": newRow++; break;
      case "left": newCol--; break;
      case "right": newCol++; break;
    }
    const newIndex = getIndex(newRow, newCol);
    if (isValidMove(newIndex)) {
      gridItems[dog.position].removeChild(dog.element);
      gridItems[newIndex].appendChild(dog.element);
      dog.position = newIndex;
      dog.direction = dir;
    }
  }
  ```

- **Implement moveTowardsPlayer:**

  - Calculate the direction towards the player and attempt to move.
  - Example:

  ```javascript
  function moveTowardsPlayer(dog) {
    const dogCoords = getCoords(dog.position);
    const playerCoords = getCoords(player.position);
    let dir = 'down';
    if (Math.abs(playerCoords.row - dogCoords.row) > Math.abs(playerCoords.col - dogCoords.col)) {
      dir = playerCoords.row > dogCoords.row ? 'down' : 'up';
    } else {
      dir = playerCoords.col > dogCoords.col ? 'right' : 'left';
    }
    attemptDogMove(dog, dir);
  }
  ```

- **Update updateDogs:**

  - Ensure it calls the correct functions. Currently, it has `moveDogTowardsPlayer`, but we defined `moveTowardsPlayer`. Adjust accordingly.

---

## 18. Implementing UI Update Functions

- **Implement updateHeartUI:**

  - Update the heart indicators based on `player.hearts`.
  - Assuming there are elements with ids like 'heart1', 'heart2', 'heart3'.
  - Example:

  ```javascript
  function updateHeartUI() {
    for (let i = 1; i <= 3; i++) {
      const heart = document.getElementById(`heart${i}`);
      if (i <= player.hearts) {
        heart.style.display = 'block';
      } else {
        heart.style.display = 'none';
      }
    }
  }
  ```

- **Implement updateWallUI, updateTNTUI, updateIceUI:**

  - Display the counters in UI elements.
  - Example:

  ```javascript
  function updateWallUI() {
    document.getElementById('walls').textContent = wallsDestroyed;
  }
  function updateTNTUI() {
    document.getElementById('tnts').textContent = tntsCollected;
  }
  function updateIceUI() {
    document.getElementById('ices').textContent = icesCollected;
  }
  ```

- **Call these functions:**

  - In `applyItemEffect`, after updating counters.
  - In `destroyWall`, after incrementing wallsDestroyed.

---

## 19. Implementing Game Over and Leaderboard

- **Implement triggerGameOver:**

  - Stop the game, show gameover screen, update matchData, save to localStorage.
  - Example:

  ```javascript
  function triggerGameOver() {
    clearInterval(gameInterval);
    clearTimeout(timerInterval);
    matchData.username = username.value;
    matchData.time = timeLeft;
    matchData.walls = wallsDestroyed;
    matchData.tnts = tntsCollected;
    matchData.ices = icesCollected;
    let matches = JSON.parse(localStorage.getItem('matches') || '[]');
    matches.push(matchData);
    localStorage.setItem('matches', JSON.stringify(matches));
    document.getElementById('game').style.display = 'none';
    document.getElementById('gameover').style.display = 'block';
  }
  ```

- **Implement displayLeaderboard:**

  - Load matches, sort by score (e.g., walls * 10 + tnts * 20 + ices * 5), render in a table.
  - Example:

  ```javascript
  function displayLeaderboard() {
    const matches = JSON.parse(localStorage.getItem('matches') || '[]');
    matches.sort((a, b) => (b.walls * 10 + b.tnts * 20 + b.ices * 5) - (a.walls * 10 + a.tnts * 20 + a.ices * 5));
    const tbody = document.querySelector('#leaderboard tbody');
    tbody.innerHTML = '';
    matches.forEach(match => {
      const row = `<tr><td>${match.username}</td><td>${match.walls}</td><td>${match.tnts}</td><td>${match.ices}</td><td>${match.time}</td></tr>`;
      tbody.innerHTML += row;
    });
  }
  ```

- **Implement playAgain:**

  - Reset variables, call Play().
  - Example:

  ```javascript
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
    // Hide gameover, call Play
    document.getElementById('gameover').style.display = 'none';
    Play();
  }
  ```

- **Implement resetLeaderboard:**

  - `localStorage.removeItem('matches'); displayLeaderboard();`

---

## 20. Hit Detection and Player Health

- **Player hit in explosion:**

  - In `explodeBomb`, after applying effects to adjacent cells, check if any affected cell is the player's position.
  - Example: Add after the loop: `if (gridItems[adjIndex] === gridItems[player.position]) playerHit();`

- **Player hit by dog:**

  - In `attemptDogMove`, after moving, if `dog.position === player.position`, call `playerHit()`.

- **Remove dogs in explosion:**

  - In `applyExplosionEffect`, add:

  ```javascript
  const dog = cell.querySelector('.dog');
  if (dog) {
    cell.removeChild(dog);
    const index = dogs.findIndex(d => d.element === dog);
    if (index > -1) dogs.splice(index, 1);
  }
  ```

---

## 21. Updating Counters and Item Effects

- **Update applyItemEffect:**

  - For 'tnt': `player.explosionRange *= 2; tntsCollected++; updateTNTUI();`
  - For 'ice': `icesCollected++; updateIceUI();`
  - For 'heart': already decreases hearts.

- **Update destroyWall:**

  - After removing wall: `wallsDestroyed++; updateWallUI();`

---

## 22. Fixing Bugs and Final Integrations

- **Fix checkItemPickup:**

  - As in section 15.

- **Ensure frozen check in keydown:**

  - In the keydown for movement: `if (Date.now() < player.frozenUntil) return;`

- **Update matchData in Play:**

  - In Play: `matchData.username = username.value;`

- **Call displayLeaderboard on page load or in home.**

- **Add event listeners for play again and reset buttons.**

---

## Extending Existing Code

- Add bomb placement and explosion logic inside the keydown event handler for the Space key in `script.js`.
- Extend the `placeRandomElements` function to include hidden items inside walls.
- Implement new functions to handle item pickup, player status updates, dog AI movement, and player search.
- Create new UI elements for pause and game over popups in `index.html` and style them in `style.css`.
- Use existing player and dog image assets for animations and status marks.

---

This detailed guide should help you implement the full client-side functionality for the BOMBSKUY game as per the project requirements.
This detailed guide should help you implement the full client-side functionality for the BOMBSKUY game as per the project requirements.

This detailed guide should help you implement the full client-side functionality for the BOMBSKUY game as per the project requirements.
