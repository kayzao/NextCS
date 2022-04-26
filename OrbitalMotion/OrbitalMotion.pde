//Constants
float GRAVITY = 0.1;

Orb orb1;
PVector g;

boolean moving;



void setup() {
  size(800, 400);
  g = new PVector(0, GRAVITY);
  reset();
}//setup

void reset() {
  moving = false;
  orb1 = new Orb(20, height - 20);
}//reset


void draw() {
  background(255);
  if (moving) {
    runAStep();
  }
  orb1.display();
}//draw

void runAStep() {
    orb1.applyForce(g);
    orb1.run();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  if (key == 'h') {
    orb1.applyForce(new PVector(6, -6));
    moving = true;
  }
  if (key == 'r') {
    reset();
  }
}//keyPressed
