//Constants
float GRAVITY = 0.1;

Orb orb1, orb2;
PVector g;

boolean moving;

void setup() {
  size(800, 400);
  g = new PVector(0, GRAVITY);
  println("SPACE to enable/disable movement, H to apply a force to the ball, and R to reset");
  reset();
}

void reset() {
  moving = false;
  orb1 = new Orb(20, 50);
  orb2 = new Orb(20, 150);
  orb2.setColor(color(255));
  orb1.setColor(color(50, 175, 255));
}


void draw() {
  background(255);
  fill(255);
  if (moving) {
    runAStep();
  }
  orb1.display();
  orb2.display();
  fill(255, 0, 0);  
  rect(50, 50, 10, orb2.SPRING_LENGTH);
}

void runAStep() {
  orb2.applyForce(g);
  orb2.applyForce(orb2.calculateSpringForceY(orb1));
  orb2.run();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  
  if (key == 'h') {
    orb2.applyForce(new PVector(0, -6));
    moving = true;
  }

  if (key == 'r') {
    reset();
  }
}