int NUM_MOVES = 250;
int moveCount;
Population pop;

void setup() {
  size(500, 500);
  pop = new Population(5);
  pop.randomPop();
  pop.setup();
  moveCount = 0;
}
void draw(){
  if (moveCount < NUM_MOVES) {
    for(Individual i : pop){
      i.rocket.run();
      i.rocket.display();
    }
    moveCount++;
  }
  else {
    for(Individual i : pop) i.r.display
  }
}
