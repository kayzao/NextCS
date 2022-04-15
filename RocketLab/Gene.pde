public class Gene {
  private boolean[] genotype;

  Gene(int geneLength) {
    genotype = new boolean[geneLength];
  }

  Gene(Gene original) {
    this(original.getGenotype().length);
    arrayCopy(original.getGenotype(), genotype);
  }

  public int getValue() {
    int value = 0;
    //converts to base10 from the back, and ending at the front
    for (int i = genotype.length - 1; i >= 0; i--) value += genotype[i] ? pow(2, genotype.length - (i + 1)) : 0;
    return value;
  }

  public void mutate() {
    int randomInd = int(random(genotype.length));
    genotype[randomInd] = !genotype[randomInd];
  }

  public String toString() {
    String ans = "BE->";
    for (boolean b : genotype) ans += b ? "1" : "0";
    return ans + " " + getValue();
  }

  public void setGenotype(boolean[] genotype) {
    arrayCopy(genotype, this.genotype);
  }

  public void setGenotype(int[] genotype) { //converts from binary 1s and 0s to boolean
    for (int i = 0; i < this.genotype.length; i++) this.genotype[i] = genotype[i] == 1;
  }

  public void randomize() {
    boolean[] newGenotype = new boolean[genotype.length];
    for (int i = 0; i < genotype.length; i++) {
      newGenotype[i] = int(random(2)) == 0;
    }
    setGenotype(newGenotype);
  }

  public boolean[] getGenotype() {
    return genotype;
  }
}
