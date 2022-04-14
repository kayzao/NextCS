int NUM_MOVES = 500;
int goalX;
int goalY;
int goalSideLength = 50;
int moveCount;
int numRockets = 20;
int generationCount = 0;
Population pop;

boolean auto;

void setup() {
  size(500, 500);
  frameRate(240);
  /*
  goalX = width - 50;
  goalY = height / 2;
  */
  auto = false;
  if(random(1) < (1.0 / 3.0)){ //along right side
    goalX = width - goalSideLength;
    goalY = int(random(goalSideLength * 0.5, height - goalSideLength * 0.5));
  } else if(random(1) < 0.5){ //along top side
    goalX = int(random(goalSideLength * 0.5, width - goalSideLength * 0.5));
    goalY = goalSideLength;
  } else { //along bottom side
    goalX = int(random(goalSideLength * 0.5, width - goalSideLength * 0.5));
    goalY = height - goalSideLength;
  }
  pop = new Population(numRockets, 0.03);
  pop.randomPop();
  moveCount = 0;
  pop.setGoal(goalX, goalY, goalSideLength);
  pop.setFitness();
  
}

void draw(){
  background(255);
  drawGoal();
  fill(0);
  text("GEN #" + generationCount + " AUTO MODE: " + auto, 20, 20);

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
    setup();
  }

  if((key == 'm' || auto) && moveCount > NUM_MOVES){
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

  if(key == ' '){
    auto = !auto;
  }
}

void drawGoal(){
  fill(255, 255, 0);
  stroke(0);
  strokeWeight(1);
  rect(goalX, goalY, goalSideLength / 2, goalSideLength / 2);
}
