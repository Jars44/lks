document.getElementById("home").style.display = "block";

function Play() {
  var username = document.getElementById("username");
  console.log(username.value);
  var difficulty = document.getElementById("level");
  console.log(difficulty.value);

  if (username.value === "") {
    return;
  } else if (difficulty.value === "0") {
    return;
  } else {
    document.getElementById("game").style.opacity = "100%";
    document.getElementById("home").style.opacity = "0%";
  }
}

function Instruction() {
  document.getElementById("instruction").style.display = "block";
  document.getElementById("home").style.display = "none";
  // window.location.href = `game.html?difficulty=${difficulty}`;
}

function CloseInstruction() {
  document.getElementById("instruction").style.display = "none";
  document.getElementById("home").style.display = "block";
}
