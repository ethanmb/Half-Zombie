class Board {
  BoardPiece[] pieces;
  int bHeight = 19;
  int bWidth = 15;
  int pieceCounter = 0;
  Board() {
    pieces = new BoardPiece[NUM_OF_PIECES];
  }

  void generateBoard() {


    for (int i = 0; i < bHeight; i++) {


      for (int z = 0; z < bWidth; z++) {
        int j = 0;
        int randomizer =(int) random(100);
        if (randomizer > 75) {
          j =(int) random(5);
        }
        pieces[pieceCounter] = new BoardPiece(j, 360 + (i*50), 100 + (z* 50));
        pieceCounter++;
      }
    }
  }
  void drawBoard() {
    for (int i  = NUM_OF_PIECES-1; i > -1; i--) {
      pieces[i].drawPiece(pieces[i].x, pieces[i].y);
    }
  }
}