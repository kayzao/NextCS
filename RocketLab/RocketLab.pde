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
  background(255);
  if (moveCount < NUM_MOVES) {
    for(int i = 0; i < 5; i++){
      pop.get(i).rocket.run();
      pop.get(i).rocket.display();
    }
    moveCount++;
  }
  else {
    for(int i = 0; i < 5; i++) pop.get(i).rocket.display();
  }
}
