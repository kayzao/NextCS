int NUM_MOVES = 250;
int moveCount;
Rocket r;

void setup() {
  size(500, 500);
  r = new Rocket(new PVector(250, 250), NUM_MOVES);
  r.randomMoves();
  moveCount = 0;
}

void draw() {
  background(255);
  if (moveCount < NUM_MOVES) {
    r.run();
    r.display();
    moveCount++;
  }
  else {
    r.display();
  }
}
