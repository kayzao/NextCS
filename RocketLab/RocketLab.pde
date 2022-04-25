int NUM_MOVES = 600;
int goalX, goalY, goalSideLength = 50;
int moveCount;
int numRockets = 10;
int generationCount = 0;
int obstacleStartX, obstacleStartY, obstacleMinW, obstacleMaxW, obstacleMinL, obstacleMaxL;
float mutationRate;
Population pop;
int[][] obstacles;
boolean autoMode;
boolean obstaclesEnabled;
color OBSTACLE_COLOR = color(175);

void setup() {
  size(500, 500);
  frameRate(240);
  autoMode = false;
  obstaclesEnabled = true;
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
  obstacleStartX = 100;
  obstacleStartY = 100;
  obstacleMinW = 10;
  obstacleMaxW = 75;
  obstacleMinL = 10;
  obstacleMaxL = 75;
  obstacles = new int[int(random(1, 10))][4];
  if(obstacles.length <= 0) obstaclesEnabled = false;
  if(obstaclesEnabled) createObstacles();
  println("========================== WELCOME ==========================");
  println("Press: R to randomize layout, M to evolve rockets, SPACE to enable autonomous mode");
  println("       W and S to change the mutation rate, and O to toggle on/off obstacles");
  println("=============================================================");
}

void draw() {
  background(255);
  rectMode(CENTER);
  drawGoal();
  if(obstaclesEnabled || moveCount > NUM_MOVES) drawObstacles();
  if (moveCount <= NUM_MOVES) {
    pop.display(false, true);
    moveCount++;
  } else {
    if (autoMode) evolve();
    else pop.display(true, false);
  }

  fill(255, 255, 255, 175);
  stroke(200);
  rectMode(CORNER);
  String m0 = "GEN " + generationCount + " | AUTO MODE: " + (autoMode ? "ACTIVE" : "INACTIVE") + " | OBSTACLES: " + (obstaclesEnabled ? "ENABLED" : "DISABLED");
  String m1 = "MUTATION RATE: " + roundDigits(pop.getMutationRate(), 3);
  rect(11, 0, m0.length() * 6, 25, 5);
  fill(0);
  text(m0, 20, 11);
  text(m1, 60, 22);

  pop.setFitness();
}

void keyPressed() {

  if (key == 'r') {
    if (generationCount > 0) println("=============== RESET: GENERATION 0 ===============");
    if(obstaclesEnabled){
      obstacles = new int[int(random(1, 10))][4];
      createObstacles();
    } else {
      obstacles = new int[0][4];
    }
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
    autoMode = !autoMode;
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
  if (key == 'o'){
    if(moveCount < NUM_MOVES) return;
    obstaclesEnabled = !obstaclesEnabled;
    if(obstaclesEnabled){
      obstacles = new int[0][4];
      obstacles = new int[int(random(1, 10))][4];
      createObstacles();
    } 
  }
}

void drawGoal() {
  fill(255, 255, 0);
  stroke(0);
  strokeWeight(1);
  rectMode(CENTER);
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
  rectMode(CENTER);
  for(int i = 0; i < obstacles.length; i++){
    fill(OBSTACLE_COLOR);
    rect(obstacles[i][0], obstacles[i][1], obstacles[i][2], obstacles[i][3]);
  }
}

void evolve() {
  for (int i = 0; i < numRockets; i++) {
    pop.setFitness();
  }
  String avg = roundDigits(pop.getAverageFitness(), 6);
  String best = roundDigits(pop.getBestFitness(), 6);
  Population test = pop.evolve();
  pop = test;
  generationCount++;
  moveCount = 0;
  println("REPORT: Generation #" + (generationCount - 1) + ": Average fitness: " + avg + " Best fitness: " + best);
}

String roundDigits(float num, int digits){ //rounds a decimal from 0-1 to a certain amount of digits
  if(num > 1 || num < 0) return "[Limit of input exceeded]";
  if(!(digits > 0)) return "[Invalid number of digits]";
  String str = String.valueOf(round(num * pow(10, digits)) / pow(10, digits));
  for(int i = str.length() - 1; i < digits + 1; i++){
    str += "0";
  }
  return str;
}
