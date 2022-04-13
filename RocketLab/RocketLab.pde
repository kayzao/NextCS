int NUM_MOVES = 250;
int goalX = width = 50;
int goalY = height / 2;
int goalSideLength = 50;
int moveCount;
int numRockets = 5;
Population pop;

void setup() {
  size(500, 500);
  pop = new Population(numRockets);
  pop.randomPop();
  moveCount = 0;
}
void draw(){
  background(255);
  if (moveCount < NUM_MOVES) {
    for(int i = 0; i < numRockets; i++){
      pop.get(i).rocket.run();
      pop.get(i).rocket.display();
    }
    moveCount++;
  }
  else {
    for(int i = 0; i < numRockets; i++) pop.get(i).rocket.display();
  }
}
void keyPressed(){
  if(key == 'r'){
    pop.randomPop();
    moveCount = 0;
  }
  if(key == ' '){
    pop.evolve();
    moveCount = 0;
    for(int i = 0; i < numRockets; i++){
      pop.get[i].updateFitness(goalX - goalSideLength / 2, goalY - goalSideLength / 2);
    }
  }
}

void drawGoal(){
  fill(255, 255, 0);
  stroke(255);
  strokeWeight(1);
  rect(goalX, goalY, goalSideLength / 2, goalSideLength / 2);
}