Individual i0, i1, i2;

void setup() {
  size(600, 200);
  makeIndividuals();
}

void draw() {
  background(255);
  i0.display(100, 100, true);
  i1.display(300, 100, true);
  i2.display(500, 100, true);
}

void makeIndividuals() {
  i0 = new Individual(true);
  i1 = new Individual(true);
  i2 = i0.mate(i1);
  i2.setPhenotype();
  i0.updateFitness(i0);
  i1.updateFitness(i0);
  i2.updateFitness(i0);
}

void keyPressed() {
  if (key == 'p') {
    makeIndividuals();
  }
  if (key == 'm') {
    i2.mutate(0.1);
    i2.updateFitness(i0);
  }
}
