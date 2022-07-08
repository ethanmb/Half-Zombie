final int NUM_OF_PIECES = 285;
boolean playing, player_has_rolled, gameOver, playerJustDied, rolling, inventoryOpen = false;
int numPlayers, currentPlayer, winnerInt, playerCounter;
PImage die1, die2, die3, die4, die5, die6;
Board board;
Button btn_3_players, btn_4_players, btn_roll, btn_okay, btn_eat, btn_endTurn;
Button btn_inventory, btn_1, btn_2, btn_3, btn_4, btn_5;
Player[] players;
Player winner;

void setup() {
  playerJustDied = false;
  rolling = false;
  gameOver = false;
  size(1600, 900);
  playing = false;
  player_has_rolled = false;
  rectMode(CENTER);
  btn_3_players = new Button(width/2, height/2 - 100, 200, 125, #006622, #00DD66, "3 Players");
  btn_4_players = new Button(width/2, height/2 + 100, 200, 125, #006622, #00DD66, "4 Players");
  btn_roll = new Button(width - 150, height - 50, 100, 50, #660000, #BB0000, "Roll");
  btn_eat = new Button(width - 150, height - 100, 100, 50, #660000, #BB0000, "Eat Self");
  btn_okay = new Button(width - 100, height/2 + 50, 100, 50, #006622, #00DD66, "Okay");
  btn_endTurn = new Button(width/2, height - 30, 150, 50, #660000, #BB0000, "End Turn");
  btn_inventory = new Button(200, height - 50, 100, 100, #000044, #0000AA, "Inventory");
  btn_1 = new Button(200, height - 150, 100, 100, #000044, #0000AA, "Empty");
  btn_2 = new Button(200, height - 250, 100, 100, #000044, #0000AA, "Empty");
  btn_3 = new Button(200, height - 350, 100, 100, #000044, #0000AA, "Empty");
  btn_4 = new Button(200, height - 450, 100, 100, #000044, #0000AA, "Empty");
  btn_5 = new Button(200, height - 550, 100, 100, #000044, #0000AA, "Empty");
  die1 = loadImage("dieWhite_border1.png");
  die2 = loadImage("dieWhite_border2.png");
  die3 = loadImage("dieWhite_border3.png");
  die4 = loadImage("dieWhite_border4.png");
  die5 = loadImage("dieWhite_border5.png");
  die6 = loadImage("dieWhite_border6.png");
}

void draw() {
  background(200);
  if (!playing) {
    newGame();
  } else {
    update();
  }
}

void newGame() {
  btn_3_players.update();
  btn_4_players.update();
  board = new Board();
  board.generateBoard();
  textSize(50);
  text("HALF-ZOMBIE, THE BOARD GAME", width/2, 50);
  textSize(12);
}

void mousePressed() {
  if (!playing) {
    if (btn_3_players.hovering()) {
      playing = true;
      numPlayers = 3;
      playerCounter = numPlayers;
      players = new Player[3];
      System.out.println("3 Players");
      currentPlayer = 0;
      for (int i  = 0; i < 3; i++) {
        players[i] = new Player(i + 1);
        players[i].currentPiece = board.pieces[(int) random(285)];
        players[i].x = players[i].currentPiece.x;
        players[i].y = players[i].currentPiece.y;
      }
      return;
    }
    if (btn_4_players.hovering()) {
      playing = true;
      numPlayers = 4;
      playerCounter = numPlayers;
      players = new Player[4];
      System.out.println("4 Players");
      currentPlayer = 0;
      for (int i  = 0; i < 4; i++) {
        players[i] = new Player(i + 1);
        players[i].currentPiece = board.pieces[(int) random(285)];
        players[i].x = players[i].currentPiece.x;
        players[i].y = players[i].currentPiece.y;
      }
      return;
    }
  } else {
    if (!gameOver) {
      if (inventoryOpen) {
        if(btn_1.hovering() && players[currentPlayer].inventory.items[0] != -1) {
          players[currentPlayer].inventory.itemUsed(0);
        }
        if(btn_2.hovering() && players[currentPlayer].inventory.items[1] != -1) {
          players[currentPlayer].inventory.itemUsed(1);
        }
        if(btn_3.hovering() && players[currentPlayer].inventory.items[2] != -1) {
          players[currentPlayer].inventory.itemUsed(2);
        }
        if(btn_4.hovering() && players[currentPlayer].inventory.items[3] != -1) {
          players[currentPlayer].inventory.itemUsed(3);
        }
        if(btn_5.hovering() && players[currentPlayer].inventory.items[4] != -1) {
          players[currentPlayer].inventory.itemUsed(4);
        }
        if(btn_inventory.hovering()) {
          inventoryOpen = false;
          return;
        }
      }
      if (!inventoryOpen) {
        if(btn_inventory.hovering()) {
          inventoryOpen = true;
          return;
        }
      }
      if (!player_has_rolled && btn_roll.hovering()) {
        players[currentPlayer].roll();
        player_has_rolled = true;
        rolling = true;
        return;
      }
      if (btn_eat.hovering()) {
        players[currentPlayer].eat(100 - players[currentPlayer].hunger, 2);
        return;
      }
      if (player_has_rolled && !rolling && btn_endTurn.hovering() && players[currentPlayer].roll ==0) {
        players[currentPlayer].endTurn();
        if (!playerJustDied) {
          currentPlayer = (currentPlayer + 1) % numPlayers;
        }
        playerJustDied = false;
        player_has_rolled = false;
        rolling = false;
        return;
      }
      if (rolling && player_has_rolled && btn_okay.hovering() && players[currentPlayer].roll > 0) {
        rolling = false;
        return;
      }
      
    }
  }
}
void gameOver(Player w) {
  gameOver = true;
  winner = w;
  winnerInt = w.playerNumber;
}

void gameOverScreen() {
  fill(#BB0000);
  rect(width/2, height/2, 600, 400);
  fill(0);
  text("Game over!\n" + "Winner : Player " + winnerInt, width/2, height/2 - 50);
}

void removePlayer(Player p) {
  int temp = 0;
  for (int i = 0; i < numPlayers; i++) {
    if (players[i] == p) {
      temp = i;
      break;
    }
  }
  for (int i = temp; i < numPlayers - 1; i++) {
    players[i] = players[i+1];
  }
  players[--numPlayers] = null;
  playerJustDied = true;
}

void keyPressed() {
  Player temp = players[currentPlayer];
  // Moving up
  if (keyCode == UP && temp.roll > 0 && temp.y > 100 && !rolling) {
    temp.roll--;
    temp.y-=50;
    for(int i = 0; i < NUM_OF_PIECES; i++) {
      if(board.pieces[i].x == players[currentPlayer].x && board.pieces[i].y == players[currentPlayer].y) {
        players[currentPlayer].currentPiece = board.pieces[i];
      }
    }
  }
  // Moving down
  if (keyCode == DOWN && temp.roll > 0 && temp.y < 800&& !rolling) {
    temp.roll--;
    temp.y+=50;
    for(int i = 0; i < NUM_OF_PIECES; i++) {
      if(board.pieces[i].x == players[currentPlayer].x && board.pieces[i].y == players[currentPlayer].y) {
        players[currentPlayer].currentPiece = board.pieces[i];
      }
    }
  }
  // Moving left
  if (keyCode == LEFT && temp.roll > 0 && temp.x > 370&& !rolling) {
    temp.roll--;
    temp.x-=50;
    for(int i = 0; i < NUM_OF_PIECES; i++) {
      if(board.pieces[i].x == players[currentPlayer].x && board.pieces[i].y == players[currentPlayer].y) {
        players[currentPlayer].currentPiece = board.pieces[i];
      }
    }
  }
  // Moving right
  if (keyCode == RIGHT && temp.roll > 0 && temp.x < 1250&& !rolling) {
    temp.roll--;
    temp.x+=50;
    for(int i = 0; i < NUM_OF_PIECES; i++) {
      if(board.pieces[i].x == players[currentPlayer].x && board.pieces[i].y == players[currentPlayer].y) {
        players[currentPlayer].currentPiece = board.pieces[i];
      }
    }
  }
}

void update() {
  players[currentPlayer].updatePlayer();
  if (!gameOver) {
    if (playerCounter == 1) {
      gameOver = true;
    }
    if (inventoryOpen) {
      btn_1.update();
      btn_2.update();
      btn_3.update();
      btn_4.update();
      btn_5.update();
    }
    btn_inventory.update();
    if (!rolling) {

      if (player_has_rolled) {
        btn_endTurn.update();
        text(players[currentPlayer].roll, width - 100, height/2);
      } else {
        btn_roll.update();
      }
      btn_eat.update();
      board.drawBoard();

      //draws players at current position
      for (int i = 0; i < playerCounter; i++) {
        players[i].drawPlayer(players[i].x+ (numPlayers * 3.33333) - i * 10, players[i].y, 25);
      }
    } else {
      fill(0);
      text(players[currentPlayer].roll, width - 100, height/2);
      imageMode(CORNER);
      for (int i = 0; i < players[currentPlayer].numRolls; i++) {
        if (players[currentPlayer].dice[i] == 1) {
          if ((mouseX > width - 100 && mouseX < width - 100 + 68) && (mouseY > 0 + 100 + (100 * i) && mouseY < 0 + 100 + (100 * i) + 68)) {
            if (mousePressed) {
              players[currentPlayer].roll = 1;
            }
            fill(#FF0000);
            rectMode(CORNER);
            rect(width - 100 -1.25, 0 + 100 + (100 * i)-1.25, 70, 70);
            rectMode(CENTER);
          }
          image(die1, width - 100, 0 + 100 + (100 * i));
        } else if (players[currentPlayer].dice[i] == 2) {

          if ((mouseX > width - 100 && mouseX < width - 100 + 68) && (mouseY > 0 + 100 + (100 * i) && mouseY < 0 + 100 + (100 * i) + 68)) {
            if (mousePressed) {
              players[currentPlayer].roll = 2;
            }
            fill(#FF0000);
            rectMode(CORNER);
            rect(width - 100 -1.25, 0 + 100 + (100 * i)-1.25, 70, 70);
            rectMode(CENTER);
          }
          image(die2, width - 100, 0 + 100 + (100 * i));
        } else if (players[currentPlayer].dice[i] == 3) {

          if ((mouseX > width - 100 && mouseX < width - 100 + 68) && (mouseY > 0 + 100 + (100 * i) && mouseY < 0 + 100 + (100 * i) + 68)) {
            if (mousePressed) {
              players[currentPlayer].roll = 3;
            }
            fill(#FF0000);
            rectMode(CORNER);
            rect(width - 100 -1.25, 0 + 100 + (100 * i)-1.25, 70, 70);
            rectMode(CENTER);
          }
          image(die3, width - 100, 0 + 100 + (100 * i));
        } else if (players[currentPlayer].dice[i] == 4) {

          if ((mouseX > width - 100 && mouseX < width - 100 + 68) && (mouseY > 0 + 100 + (100 * i) && mouseY < 0 + 100 + (100 * i) + 68)) {
            if (mousePressed) {
              players[currentPlayer].roll = 4;
            }
            fill(#FF0000);
            rectMode(CORNER);
            rect(width - 100 -1.25, 0 + 100 + (100 * i)-1.25, 70, 70);
            rectMode(CENTER);
          }
          image(die4, width - 100, 0 + 100 + (100 * i));
        } else if (players[currentPlayer].dice[i] == 5) {

          if ((mouseX > width - 100 && mouseX < width - 100 + 68) && (mouseY > 0 + 100 + (100 * i) && mouseY < 0 + 100 + (100 * i) + 68)) {
            if (mousePressed) {
              players[currentPlayer].roll = 5;
            }
            fill(#FF0000);
            rectMode(CORNER);
            rect(width - 100 -1.25, 0 + 100 + (100 * i)-1.25, 70, 70);
            rectMode(CENTER);
          }
          image(die5, width - 100, 0 + 100 + (100 * i));
        } else {

          if ((mouseX > width - 100 && mouseX < width - 100 + 68) && (mouseY > 0 + 100 + (100 * i) && mouseY < 0 + 100 + (100 * i) + 68)) {
            if (mousePressed) {
              players[currentPlayer].roll = 6;
            }
            fill(#FF0000);
            rectMode(CORNER);
            rect(width - 100 -1.25, 0 + 100 + (100 * i)-1.25, 70, 70);
            rectMode(CENTER);
          }
          image(die6, width - 100, 0 + 100 + (100 * i));
        }
      }
      imageMode(CENTER);
      keyReleased();
      board.drawBoard();
      btn_okay.update();
    }
    fill(0);
    textAlign(LEFT);

    text("Hunger : " + players[currentPlayer].hunger, 0, 100);
    text("Blood : " + players[currentPlayer].bloodLevel, 0, 125);
    text("Hunger Rate : -" + players[currentPlayer].hungerRate + "/round", 0, 150);
    text("Bleeding Rate : -" + players[currentPlayer].bleedingRate + "/round", 0, 175);
    text("Max roll : " + players[currentPlayer].maxRoll, 0, 200);
    text("Amount of Dice : " + players[currentPlayer].numRolls, 0, 225);
    textAlign(CENTER);
    text("Player " + players[currentPlayer].playerNumber, 50, 575);
    players[currentPlayer].drawPlayer(50, 525, 50);
    for (int i = 0; i < playerCounter; i++) {
      players[i].drawPlayer(players[i].x+ (numPlayers * 3.33333) - i * 10, players[i].y, 25);
    }
  } else {
    gameOver(players[currentPlayer]);
    gameOverScreen();
  }
}
