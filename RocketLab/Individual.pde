public static final int CHROMOSOME_LENGTH = 100; //first 50 for magnitude, last 50 for angle
public static final int ACTIONS_LENGTH = 50;
public enum GeneLengths { 
  //magnitude comes in increments of 1/150, up to 0.1
  //angle should be be in increments of (2 * PI)/511, up to 2 PI
  MAGNITUDE(4),
  ANGLE(9);

  private int length;
  
  private GeneLengths(int length) {
    this.length = length;
  }

  private int getLength() {
    return length;
  }
}

public class Individual{
  private Gene[] chromosome;
  private Rocket rocket;
  private float fitness;

  public Individual(boolean random){
    chromosome = new Gene[CHROMOSOME_LENGTH];
    for(int i = 0; i < ACTIONS_LENGTH; i++){
      chromosome[i] = new Gene(GeneLengths.MAGNITUDE.getLength());
      chromosome[i + ACTIONS_LENGTH] = new Gene(GeneLengths.ANGLE.getLength());
    }
    if(random) for(Gene g : chromosome) g.randomize();
  }
  public Individual(){
    this(false};
  }

  public String toString(){
    StringBuilder sb = new StringBuilder();
    for(Gene g : chromosome){
      sb.append(g.toString() + "|");
    }
    return sb.toString();
  }

  public void display(int x, int y, boolean showFitness){
    rocket.display(x, y);
    if(showFitness) text(fitness, x, y);
  }

  public float getFitness(){
    return fitness;
  }

  public Gene[] getChromosome(){
    return chromosome;
  }

  public void setRocket(){
    
  }

  public void mutate(float rate){
    for(Gene g : chromosome) if(random(1) < rate) g.mutate();
  }

  public Individual crossover(Individual partner){
    Individual child = new Individual(false);
    for(int i = 0; i < CHROMOSOME_LENGTH; i++){
      if(random(1) < 0.5) child.chromosome[i] = new Gene(chromosome[i]);
      else child.chromosome[i] = new Gene(parther.chromosome[i])
    }
    return child;
  }

  public void updateFitness(int x, int y){ //update fitness based on the center of the goal
    //update fitness based on distance from x, y.
    //FORMULA: 1/distance
    float fitness = 1 / dist(x, y, rocket.getX(), rocket.getY());
  }
}

//Complete overhaul of individual class
/* NEEDED:
 * setPhenotype() [calls constructor of rocket to update to the latest values?]
 * updateFitness() [has to change fitness of the individual based on how far away the target is, need a new formula somehow?]
 * crossover() [crossover between two individuals]
 * new constructor, where all the genes are for the angle + magnitude of each action of the rocket.
 */
