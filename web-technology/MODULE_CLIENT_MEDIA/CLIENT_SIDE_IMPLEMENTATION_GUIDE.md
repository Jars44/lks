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

## 9. Local Storage Usage for Match History and Leaderboard Sorting

- **Save match data:**  
  Store player match data (username, time, score, items collected) in local storage as an array of match objects.
- **Retrieve leaderboard:**  
  Load the match data from local storage and sort it based on the criteria (walls destroyed, TNTs, ice cubes).
- **Display leaderboard:**  
  Render the sorted leaderboard in a popup or dedicated UI section.

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
