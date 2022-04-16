class Population {
  private Individual[] pop;
  private float totalFitness;
  private float mutationRate;
  private int goalX, goalY, goalSideLength;

  Population(int popSize) {
    this(popSize, 0.05);
  }

  Population(int popSize, float mutationRate) {
    pop = new Individual[popSize];
    totalFitness = 0.0;
    if (mutationRate > 1 || mutationRate <= 0) mutationRate = 0.05;
    this.mutationRate = mutationRate;
  }

  public float getMutationRate() {
    return mutationRate;
  }

  public float getTotalFitness() {
    return totalFitness;
  }

  public Individual get(int ind) {
    return pop[ind];
  }

  public void display(boolean showFitness, boolean move) {
    for (int i = 0; i < pop.length; i++) {
      float posX = pop[i].getX();
      float posY = pop[i].getY();
      //if inside border and move is true
      if (posX >= 0 && posX <= width && posY >= 0 && posY <= height && move) {
        //if not touching goal
        if (!(posX >= goalX - (0.5 * goalSideLength) && posX <= goalX + (0.5 * goalSideLength) && posY >= goalY - (0.5 * goalSideLength) && posY <= goalY + (0.5 * goalSideLength))) {
          pop[i].moveRocket();
        }
      }
      if(i == getBestIndex()) pop[i].display(showFitness, true);
      else pop[i].display(showFitness, false);
    }
  }

  public void setGoal(int x, int y, int sideLength) {
    goalX = x;
    goalY = y;
    goalSideLength = sideLength;
  }
  public void setFitness() {
    totalFitness = 0;
    for (int i = 0; i < pop.length; i++) {
      pop[i].updateFitness(goalX, goalY);
      totalFitness += pop[i].getFitness();
    }
  }

  public int getBestIndex() {
    float bestFitness = 0.0;
    int bestIndex = 0;
    for (int i = 1; i < pop.length; i++) {
      if (pop[i].getFitness() > bestFitness) {
        bestFitness = pop[i].getFitness();
        bestIndex = i;
      }
    }
    return bestIndex;
  }

  public float getBestFitness() {
    float bestFitness = 0.0;
    for (int i = 1; i < pop.length; i++) {
      if (pop[i].getFitness() > bestFitness) {
        bestFitness = pop[i].getFitness();
      }
    }
    return bestFitness;
  }

  public float getAverageFitness() {
    return totalFitness / float(pop.length);
  }

  public void set(int index, Individual indiv) {
    pop[index] = indiv;
  }

  public void setMutationRate(float mutationRate) {
    if (mutationRate > 1) mutationRate = 1;
    if (mutationRate <= 0.001) mutationRate = 0.001;
    this.mutationRate = mutationRate;
  }
  public void setup() {
    for (Individual i : pop) i.setRocket();
  }

  public Individual select() {
    float sumFitness = 0;
    float aimFitness = random(1, totalFitness);
    for (int i = 1; i < pop.length; i++) {
      sumFitness += pop[i].getFitness();
      if (sumFitness >= aimFitness) return pop[i];
    }
    return pop[pop.length-1];
  }

  public void randomPop() {
    for (int i = 0; i < pop.length; i++) {
      pop[i] = new Individual(true);
    }
    setup();
  }

  public Population evolve() {
    Population newPop = new Population(pop.length, mutationRate);
    newPop.setGoal(goalX, goalY, goalSideLength);
    int bestInd = getBestIndex();
    for (int i = 0; i < pop.length; i++) {
      if (i == bestInd) {
        pop[i].resetRocket();
        newPop.set(i, pop[i]);
        continue;
      }

      Individual parent1 = select();
      Individual parent2 = select();
      Individual child = parent1.crossover(parent2);
      child.mutate(mutationRate);
      child.resetRocket();
      newPop.set(i, child);
    }
    return newPop;
  }
}
