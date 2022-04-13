int NUM_MOVES = 375;
int goalX;
int goalY;
int goalSideLength = 50;
int moveCount;
int numRockets = 5;
int generationCount = 0;
Population pop;

void setup() {
  size(500, 500);
  goalX = width - 50;
  goalY = height / 2;
  pop = new Population(numRockets);
  pop.randomPop();
  moveCount = 0;
  println("Generation: " + generationCount);
  pop.setFitness(goalX, goalY);
}
void draw(){
  background(255);
  drawGoal();
  pop.setFitness(goalX, goalY);
  println(moveCount);
  if (moveCount <= NUM_MOVES) {
    pop.display(false);
    moveCount++;
  } else {
    pop.display(true);
  }
}
void keyPressed(){
  if(key == 'r'){
    pop.randomPop();
    moveCount = 0;
  }
  if(key == ' ' && moveCount > NUM_MOVES){
    Population test = pop.evolve();
    pop = test;
    
    moveCount = 0;
    for(int i = 0; i < numRockets; i++){
      pop.setFitness(goalX, goalY);
    }
    println("Generation: " + generationCount + " Average fitness: " + pop.getAverageFitness());
  }
}

void drawGoal(){
  fill(255, 255, 0);
  stroke(255);
  strokeWeight(1);
  rect(goalX, goalY, goalSideLength / 2, goalSideLength / 2);
}
