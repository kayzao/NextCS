int NUM_MOVES = 500;
int goalX, goalY, goalSideLength = 50;
int moveCount;
int numRockets = 10;
int generationCount = 0;
int obstacleStartX, obstacleStartY, obstacleMinW, obstacleMaxW, obstacleMinL, obstacleMaxL;
float mutationRate;
Population pop;
int[][] obstacles;
boolean auto;
color OBSTACLE_COLOR = color(175);

void setup() {
  size(500, 500);
  frameRate(240);
  auto = false;
  mutationRate = 0.03;
  if (random(1) < (1.0 / 3.0)) { //along right side
    goalX = width - goalSideLength;
    goalY = int(random(goalSideLength * 0.5, height - goalSideLength * 0.5));
  } else if (random(1) < 0.5) { //along top side
    goalX = int(random(goalSideLength * 0.5, width - goalSideLength * 0.5));
    goalY = goalSideLength;
  } else { //along bottom side
    goalX = int(random(goalSideLength * 0.5, width - goalSideLength * 0.5));
    goalY = height - goalSideLength;
  }
  pop = new Population(numRockets, mutationRate);
  pop.randomPop();
  moveCount = 0;
  pop.setGoal(goalX, goalY, goalSideLength);
  pop.setFitness();
  //In the future make the number of obstacles change by keyboard input
  obstacleStartX = 75;
  obstacleStartY = 75;
  obstacleMinW = 10;
  obstacleMaxW = 75;
  obstacleMinL = 10;
  obstacleMaxL = 75;
  obstacles = new int[int(random(1, 10))][4];
  if(obstacles.length > 0) createObstacles();
  println("Press R to randomize layout, M to evolve rockets, SPACE to enable autonomous mode, and W and S to change the mutation rate");
}

void draw() {
  background(255);
  drawGoal();
  if(obstacles.length > 0) drawObstacles();
  fill(0);
  text("GEN " + generationCount + " | AUTO MODE: " + (auto ? "ACTIVE" : "INACTIVE"), 20, 10);
  text("MUTATION RATE: " + round(pop.getMutationRate() * 1000) / 1000.0, 20, 20);
  if (moveCount <= NUM_MOVES) {
    pop.display(false, true);
    moveCount++;
  } else {
    if (auto) evolve();
    else pop.display(true, false);
  }
  pop.setFitness();
}

void keyPressed() {

  if (key == 'r') {
    if (generationCount > 0) println("=============== RESET: GENERATION 0 ===============");
    obstacles = new int[int(random(1, 10))][4];
    if(obstacles.length > 0) createObstacles();
    generationCount = 0;
    if (random(1) < (1.0 / 3.0)) { //along right side
      goalX = width - goalSideLength;
      goalY = int(random(goalSideLength * 0.5, height - goalSideLength * 0.5));
    } else if (random(1) < 0.5) { //along top side
      goalX = int(random(goalSideLength * 0.5, width - goalSideLength * 0.5));
      goalY = goalSideLength;
    } else { //along bottom side
      goalX = int(random(goalSideLength * 0.5, width - goalSideLength * 0.5));
      goalY = height - goalSideLength;
    }
    pop = new Population(numRockets, mutationRate);
    pop.randomPop();
    moveCount = 0;
    pop.setGoal(goalX, goalY, goalSideLength);
    pop.setFitness();
  }

  if (key == 'm' && moveCount > NUM_MOVES) {
    evolve();
  }

  if (key == ' ') {
    auto= !auto;
  }

  if (key == 'w') {
    mutationRate += 0.001;
    pop.setMutationRate(mutationRate);
    mutationRate = pop.getMutationRate();
  }
  if (key == 's') {
    mutationRate -= 0.001;
    pop.setMutationRate(mutationRate);
    mutationRate = pop.getMutationRate();
  }
}

void drawGoal() {
  fill(255, 255, 0);
  stroke(0);
  strokeWeight(1);
  rect(goalX, goalY, goalSideLength / 2, goalSideLength / 2);
}

void createObstacles(){
  for(int i = 0; i < obstacles.length; i++){
    obstacles[i][0] = int(random(obstacleStartX, width - obstacleStartX - obstacleMaxW));
    obstacles[i][1] = int(random(obstacleStartY, height - obstacleStartY - obstacleMaxL));
    obstacles[i][2] = int(random(obstacleMinW, obstacleMaxW));
    obstacles[i][3] = int(random(obstacleMinL, obstacleMaxL));
  }
}

void drawObstacles(){
  for(int i = 0; i < obstacles.length; i++){
    fill(OBSTACLE_COLOR);
    rect(obstacles[i][0], obstacles[i][1], obstacles[i][2], obstacles[i][3]);
  }
}

void evolve() {
  for (int i = 0; i < numRockets; i++) {
    pop.setFitness();
  }
  float avg = pop.getAverageFitness();
  Population test = pop.evolve();
  pop = test;
  generationCount++;
  moveCount = 0;
  println("REPORT: Generation #" + (generationCount - 1) + ": Average fitness: " + avg);
}
