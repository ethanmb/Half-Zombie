class Player {
  float bloodLevel, hunger, hungerRate, bleedingRate;
  int roll, maxRoll, numRolls, playerNumber;
  int dice[];
  float x, y;
  PImage blue, green, purple, red;
  
  Inventory inventory;

  BoardPiece currentPiece;

  Player(int p) {
    inventory = new Inventory();
    hunger = 100.0f;
    bloodLevel = 100.0f;
    roll = 0;
    maxRoll = 6;
    numRolls = 2;
    bleedingRate = 0.0f;
    hungerRate = 10.0f;
    playerNumber = p;
    dice = new int[numRolls];
    blue = loadImage("pieceBlue.png");
    green = loadImage("pieceGreen.png");
    purple = loadImage("piecePurple.png");
    red = loadImage("pieceRed.png");
  }

  void roll() {
    dice = new int[numRolls];
    roll = 0;
    for (int i  = 0; i < numRolls; i++) {
      dice[i] = (int) random(maxRoll) + 1;
      System.out.println(dice[i]);
    }
  }
  
  void endTurn(){
    hunger -= hungerRate;
    hungerRate += 2.0f;
    bloodLevel -= bleedingRate;
    currentPiece.landedOn();
    if (hunger <= 0 || bloodLevel <= 0) {
      death();
      return;
    }
  }

  void eat(float h, float b) {
    hunger += h;
    bleedingRate += b;
    hungerRate = 10.0f;
  }
  
  void updatePlayer() {
    for(int i = 0; i < 5; i++) {
      if(i == 0) {
        if(inventory.items[i] == 1) {
          btn_1.text = "Food";
        }
        else if(inventory.items[i] == 2) {
          btn_1.text = "Medkit";
        }
        else if(inventory.items[i] == 3) {
          btn_1.text = "Transfusion";
        }
        else if(inventory.items[i] == 4) {
          btn_1.text = "Trap";
        }
        else{
          btn_1.text = "Empty";
        }
      }
      if(i == 1) {
        if(inventory.items[i] == 1) {
          btn_2.text = "Food";
        }
        else if(inventory.items[i] == 2) {
          btn_2.text = "Medkit";
        }
        else if(inventory.items[i] == 3) {
          btn_2.text = "Transfusion";
        }
        else if(inventory.items[i] == 4) {
          btn_2.text = "Trap";
        }
        else{
          btn_2.text = "Empty";
        }
      }
      if(i == 2) {
        if(inventory.items[i] == 1) {
          btn_3.text = "Food";
        }
        else if(inventory.items[i] == 2) {
          btn_3.text = "Medkit";
        }
        else if(inventory.items[i] == 3) {
          btn_3.text = "Transfusion";
        }
        else if(inventory.items[i] == 4) {
          btn_3.text = "Trap";
        }
        else{
          btn_3.text = "Empty";
        }
      }
      if(i == 3) {
        if(inventory.items[i] == 1) {
          btn_4.text = "Food";
        }
        else if(inventory.items[i] == 2) {
          btn_4.text = "Medkit";
        }
        else if(inventory.items[i] == 3) {
          btn_4.text = "Transfusion";
        }
        else if(inventory.items[i] == 4) {
          btn_4.text = "Transfusion";
        }
        else{
          btn_4.text = "Empty";
        }
      }
      if(i == 4) {
        if(inventory.items[i] == 1) {
          btn_5.text = "Food";
        }
        else if(inventory.items[i] == 2) {
          btn_5.text = "Medkit";
        }
        else if(inventory.items[i] == 3) {
          btn_5.text = "Transfusion";
        }
        else if(inventory.items[i] == 3) {
          btn_5.text = "Trap";
        }
        else{
          btn_5.text = "Empty";
        }
      }
    }
  }

  void death() {
    System.out.println("Player " + playerNumber + " has died!");
    removePlayer(this);
    playerCounter--;
  }

  void drawPlayer(float x, float y, float size) {
    PImage img;
    if (playerNumber == 1) {
      img = red;
    } else if (playerNumber == 2) {
      img = green;
    } else if (playerNumber == 3) {
      img = blue;
    } else {
      img = purple;
    }
    imageMode(CENTER);
    image(img, x, y, size, size);
  }
}