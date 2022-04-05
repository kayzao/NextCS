class Population{
  private Individual[] pop;
  private float totalFitness;
  private float mutationRate;
    
  Population(int popSize) {
    this(popSize, 0.05);
  }

  Population(int popSize, float mutationRate){
    pop = new Individual[popSize];
    totalFitness = 0.0;
    this.mutationRate = mutationRate;
  }

  public float getMutationRate(){
    return mutationRate;
  }

  public float getTotalFitness(){
    return totalFitness;
  }

  public Individual get(int ind){
    return pop[ind];
  }

  public void set(int ind, Individual indiv){
    pop[ind] = indiv;
  }

  public Individual select(){
    float sumFitness = 0;
    float aimFitness = random(1, totalFitness);
    for(int i = 1; i < pop.length; i++){
      sumFitness += pop[i].getFitness();
      if(sumFitness >= aimFitness) return pop[i];
    }
    return pop[pop.length-1];
  }
  
  public void setFitness(Individual target){
    totalFitness = 0;                                  
    for(int i = 0; i < pop.length; i++){
      pop[i].updateFitness(target);
      totalFitness += pop[i].getFitness();
    }
  }
  
  public void randomPop() {
    for (int i = 0; i < pop.length; i++) {
      pop[i] = new Individual(true);
    }
  }

  public Population evolve(){ //not calling this mating season
    Population newPop = new Population(pop.length, mutationRate);
    newPop.set(0, pop[0]);
    for(int i = 1; i < pop.length; i++){
      Individual parent1 = select();
      Individual parent2 = select();
      Individual child = parent1.crossover(parent2);
      child.mutate(mutationRate);
      newPop.pop[i] = child;
    }
    return newPop;
  }
    
  public void drawPopGrid(int cols, int rows, int gridSize, int offSet, boolean showFitness) {
    int x = width / (2 * cols) + OFFSET;
    int xd = (width / cols) + OFFSET;
    int y = height / (rows * 2) + OFFSET;
    int yd = (height / rows) + OFFSET;

    for(int j = 0; j < rows; j++){
      x = width / (2 * cols);
      for(int i = 0; i < cols; i++) {
        pop[i + (j * cols)].display(x, y, showFitness);
        x += xd;
      }
      y += yd;
    } 
  }
    
}
