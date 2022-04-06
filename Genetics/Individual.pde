public enum GeneLengths {
  RADIUS(6),
    NUM_SIDES(5),
    SPIN_RATE(4),
    RED(8),
    BLUE(8),
    GREEN(8);

  private int length;

  private GeneLengths(int length) {
    this.length = length;
  }

  public int getLength() {
    return length;
  }
}

public class Individual {
  private Gene[] chromosome;
  private RegularGon phenotype;
  private float fitness;
  public Individual(Boolean randInd) {
    chromosome = new Gene[CHROMOSOME_LENGTH];
    chromosome[0] = new Gene(GeneLengths.RADIUS.getLength());
    chromosome[1] = new Gene(GeneLengths.NUM_SIDES.getLength());
    chromosome[2] = new Gene(GeneLengths.SPIN_RATE.getLength());
    chromosome[3] = new Gene(GeneLengths.RED.getLength());
    chromosome[4] = new Gene(GeneLengths.GREEN.getLength());
    chromosome[5] = new Gene(GeneLengths.BLUE.getLength());
    if (randInd) for (Gene g : chromosome) g.randomize();
    setPhenotype();
  }

  public Individual() {
    this(false);
  }

  public Individual crossover(Individual partner) {
    Individual child = new Individual(false);
    for (int i = 0; i < chromosome.length; i++) {
      if (random(1) < 0.5) child.chromosome[i] = new Gene(chromosome[i]);
      else child.chromosome[i] = new Gene(partner.chromosome[i]);
    }
    return child;
  }

  public void updateFitness(Individual target) {
    //PLAN: find the percentage of booleans in each genotype[] of gene in chromosome[] that are the same
    float newFitness = 0.0;
    int numSame = 0;
    int total = 0;
    for (int i = 0; i < chromosome.length; i++) {
      for (int j = 0; j < chromosome[i].getGenotype().length; j++) {
        total++;
        if (chromosome[i].getGenotype()[j] == target.chromosome[i].getGenotype()[j]) numSame++;
      }
    }
    newFitness = (float)numSame / total;
    fitness = newFitness;
    
  }

  public float getFitness() {
    return fitness;
  }
  
  public Gene[] getChromosome(){
    return chromosome;
  }

  private void setPhenotype() {
    RegularGon tempGon = new RegularGon(chromosome[1].getValue(), chromosome[0].getValue(), chromosome[2].getValue() - 7.0, color(chromosome[3].getValue(), chromosome[4].getValue(), chromosome[5].getValue()));
    phenotype = tempGon;
  }

  public void mutate(float rate) {
    for (int i = 0; i < chromosome.length; i++) {
      if (random(1) < rate) chromosome[i].mutate();
    }
    setPhenotype();
  }

  public String toString() {
    String str = "";
    for (Gene g : chromosome) str += g.toString() + "|";
    return str;
  }

  public void display(int x, int y, boolean showFitness) {
    phenotype.display(x, y);
    if (showFitness) {
      text(fitness, x, y);
    }
  }
}
