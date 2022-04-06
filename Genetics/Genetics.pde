int POP_COLS = 6, POP_ROWS = 5, OFFSET = 1, POP_SIZE = POP_COLS * POP_ROWS;
int CHROMOSOME_LENGTH = 6;
int GRID_SIZE = int(pow(2, CHROMOSOME_LENGTH + 1) - 1);
int generationCount = 0;
float MUTATION_RATE = 0.01;
color bestIndivColor = color(50, 200, 255);
color targetColor = color(255, 255, 0);
Population pop;

void settings() {
  size(POP_COLS * GRID_SIZE + (POP_COLS - 1) * OFFSET, POP_ROWS * GRID_SIZE + (POP_ROWS - 1) * OFFSET);
}

void setup() {
  pop = new Population(POP_SIZE, MUTATION_RATE);
  makePopulation();
}

void draw() {
  strokeWeight(1);
  stroke(0);
  background(255);
  pop.drawPopGrid(POP_COLS, POP_ROWS, GRID_SIZE, OFFSET, true);
  drawGrid();
  pop.drawHighlight(pop.getBestIndex(), bestIndivColor);
  pop.drawHighlight(0, targetColor);
}

void keyPressed() {
  if(key == 'p') {
    makePopulation();
  } else if(key == 'm'){
    generationCount++;
    pop = pop.evolve();
    pop.setFitness(pop.get(0));
    println("GENERATION: " + generationCount, "\nBest fitness: " + pop.getBestFitness(), "\nAverage fitness: " + pop.getAverageFitness());
  }
}


void makePopulation() {
  generationCount = 0;
  pop.randomPop();
  pop.setFitness(pop.get(0));
  println("Total fitness: ", pop.totalFitness);
}


void drawGrid() {
  stroke(0);
  for (int i = 1; i < POP_COLS; i++) {
    int x = i * (GRID_SIZE + OFFSET);
    line(x, 0, x, height - 1);
  }
    
  for (int i = 1; i < POP_ROWS; i++) {
    int y = i * (GRID_SIZE + OFFSET);
    line(0, y, width - 1, y);
  }
}
