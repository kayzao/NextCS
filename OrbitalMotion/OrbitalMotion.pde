//Constants
float GRAVITY = 0.1;

Orb orb1, orb2;
PVector g;

boolean moving;

void setup() {
  size(800, 400);
  g = new PVector(0, GRAVITY);
  reset();
}//setup

void reset() {
  moving = false;
  orb1 = new Orb(20, 50);
  orb2 = new Orb(20, 150);
}//reset


void draw() {
  background(255);
  if (moving) {
    runAStep();
  }
  orb1.display();
  orb2.display();
}

void runAStep() {
  orb2.applyForce(g);
  orb2.applyForce(orb2.calculateSpringForceY(orb1));
  orb2.run();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
    println(moving);
  }
  /*
  if (key == 'h') {
    orb2.applyForce(new PVector(0, -6));
    moving = true;
  }
  */
  if (key == 'r') {
    reset();
  }
}