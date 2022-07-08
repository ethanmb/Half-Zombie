class BoardPiece {
  int effect;
  float x, y;
  PImage needle;
  PImage medPack;
  PImage ham;
  PImage chest;
  BoardPiece (int e, float thisx, float thisy) {
    effect = e;
    x = thisx;
    y = thisy;
    needle = loadImage("needle.png");
    medPack = loadImage("medPack.png");
    ham = loadImage("ham.png");
    chest = loadImage("chest.png");
  } 

  void landedOn() {
    Player temp = players[currentPlayer];
    if (temp.roll == 0) {
      if (effect == 1) {
        if (temp.hunger <= 50) {
          temp.hunger += 50.0f;
          temp.hungerRate = 8.0f; // "Well fed" so hunger rate is slightly lower than usual
        } else {
          if(temp.inventory.numItems < temp.inventory.maxItems) {
            temp.inventory.items[temp.inventory.numItems] = 1;
            temp.inventory.numItems++;
          }
        }
        effect = -1;
      }
      if (effect == 2) {
        // Remove bleeding effect
        if (temp.bleedingRate != 0) {
          temp.bleedingRate = 0.0f;
        } else {
          if(temp.inventory.numItems < temp.inventory.maxItems) {
            temp.inventory.items[temp.inventory.numItems] = 2;
            temp.inventory.numItems++;
          }
        }
        effect = -1;
      }
      if (effect == 3) {
        if (temp.bloodLevel <= 50) {
          temp.bloodLevel += 50.0f;
        } else {
          if(temp.inventory.numItems < temp.inventory.maxItems) {
            temp.inventory.items[temp.inventory.numItems] = 3;
            temp.inventory.numItems++;
          }
        }
        effect = -1;
      }
      if (effect == 4) {
        int randomInt = (int) random(5);
        if(randomInt == 0) {
          players[currentPlayer].numRolls++;
        }
        if(randomInt == 1) {
          if(temp.inventory.numItems < temp.inventory.maxItems) {
            temp.inventory.items[temp.inventory.numItems] = 1;
            temp.inventory.numItems++;
          }
        }
        if(randomInt == 2) {
          if(temp.inventory.numItems < temp.inventory.maxItems) {
            temp.inventory.items[temp.inventory.numItems] = 2;
            temp.inventory.numItems++;
          }
        }
        if(randomInt == 3) {
          if(temp.inventory.numItems < temp.inventory.maxItems) {
            temp.inventory.items[temp.inventory.numItems] = 3;
            temp.inventory.numItems++;
          }
        }
        if(randomInt == 4) {
          if(temp.inventory.numItems < temp.inventory.maxItems) {
            temp.inventory.items[temp.inventory.numItems] = 4;
            temp.inventory.numItems++;
          }
        }
        effect = -1;
      }
      if(effect == 5) {
        players[currentPlayer].bleedingRate += 10;
        effect = -1;
      }
    }
  }

  void drawPiece(float thisx, float thisy) {
    x = thisx;
    y = thisy;
    fill(#FFFFFF);
    rectMode(CENTER);
    textAlign(CENTER);
    rect(thisx, thisy, 50, 50);
    fill(0);
    if (effect ==1) {//types of tiles
      image(ham, thisx, thisy);
    } else if (effect ==2) {
      image(medPack, thisx, thisy);
    } else if (effect ==3) {
      image(needle, thisx, thisy);
    } else if (effect == 4) {
      image(chest, thisx, thisy);
    }
  }
}