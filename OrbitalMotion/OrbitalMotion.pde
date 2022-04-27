//Constants
float GRAVITY = 0.1;

Orb orb1, orb2;
PVector g;

boolean moving;

void setup() {
  size(800, 400);
  g = new PVector(0, GRAVITY);
  println("================================================================================");
  println("SPACE to enable/disable movement, H to apply a force to the ball, and R to reset");
  println("================================================================================");
  reset();
}

void reset() {
  moving = false;
  orb1 = new Orb(width / 2, height / 2);
  orb2 = new Orb(int(orb1.getX()), int(orb1.getY()) + 100);
  orb2.setColor(color(255));
  orb1.setColor(color(50, 175, 255));
  orb1.drawVector(false);
}


void draw() {
  background(255);
  fill(255);
  strokeWeight(1);
  if (moving) {
    runAStep();
  }
  orb1.display();
  orb2.display();
  strokeWeight(1);
  fill(255, 0, 0); 
  rect(orb1.getX() + 20, orb1.getY(), 10, orb2.SPRING_LENGTH);
  rect(orb1.getX() + 20, orb1.getY() - orb2.SPRING_LENGTH, 10, orb2.SPRING_LENGTH);
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