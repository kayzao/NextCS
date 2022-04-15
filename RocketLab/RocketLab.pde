int NUM_MOVES = 500;
int goalX;
int goalY;
int goalSideLength = 50;
int moveCount;
int numRockets = 10;
int generationCount = 0;
float mutationRate;
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
  println("Press R to randomize layout, M to evolve rockets, SPACE to enable autonomous mode, and W and S to change the mutation rate");
}

void draw() {
  background(255);
  drawGoal();
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
