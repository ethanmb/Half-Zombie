class Inventory{
  int numItems, maxItems, selectedItem;
  int[] items;
  
  Inventory() {
    maxItems = 5;
    numItems = 0;
    selectedItem = -1;
    items = new int[5];
    for(int i = 0; i < 5; i++) {
      items[i] = -1;
    }
  }
  
  void itemUsed(int i) {
    selectedItem = items[i];
    if(i <= numItems) {
      Player temp  = players[currentPlayer];
      // Food
      if(selectedItem == 1) {
        temp.hunger += 50;
        temp.hungerRate = 8;
        if(temp.hunger > 100) {
          temp.hunger = 100;
        }
      }
      // Bandage
      else if(selectedItem == 2) {
        temp.bleedingRate = 0.0f;
      }
      // Transfusion
      else if(selectedItem == 3) {
        temp.bloodLevel += 50.0f;
        if(temp.bloodLevel > 100) {
          temp.bloodLevel = 100.0f;
        }
      }
      else if(selectedItem == 4) {
        players[currentPlayer].currentPiece.effect = 5;
      }
      // Remove item from inventory
      if(selectedItem != -1) {
        items[i] = items[--numItems];
        items[numItems] = -1;
      }
    }
  }
}