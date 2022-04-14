int NUM_MOVES = 500;
int goalX;
int goalY;
int goalSideLength = 50;
int moveCount;
int numRockets = 20;
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
  pop.setGoal(goalX, goalY, goalSideLength);
  pop.setFitness();
}
void draw(){
  background(255);
  drawGoal();
  if (moveCount <= NUM_MOVES) {
    pop.display(false, true);
    moveCount++;
  } else {
    pop.display(true, false);
  }
  pop.setFitness();
}
void keyPressed(){
  
  if(key == 'r'){
    pop.randomPop();
    moveCount = 0;
    generationCount = 0;
  }

  if(key == ' ' && moveCount > NUM_MOVES){
    for(int i = 0; i < numRockets; i++){
      pop.setFitness();
    }
    float avg = pop.getAverageFitness();
    Population test = pop.evolve();
    pop = test;
    generationCount++;
    moveCount = 0;
    println("REPORT: Generation #" + generationCount + ": Average fitness: " + avg);
  }
}

void drawGoal(){
  fill(255, 255, 0);
  stroke(255);
  strokeWeight(1);
  rect(goalX, goalY, goalSideLength / 2, goalSideLength / 2);
}
