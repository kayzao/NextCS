float GRAVITY = 0.1;

Orb orb1, orb2;
PVector g;

boolean moving;

void setup() {
  size(800, 400);
  g = new PVector(0, GRAVITY);
  println("==========================================================================================");
  println("SPACE to enable/disable movement, H to apply force based on mouse position, and R to reset");
  println("==========================================================================================");
  reset();
}

void reset() {
  moving = false;
  orb1 = new Orb(width / 2, height / 2);
  orb2 = new Orb(int(orb1.getPos().x), int(orb1.getPos().y) + 100);
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
  fill(255, 0, 0, 100); 
  rect(orb1.getPos().x - orb1.SPRING_LENGTH, orb1.getPos().y - orb1.SPRING_LENGTH, orb1.SPRING_LENGTH * 2, orb1.SPRING_LENGTH * 2);
}

void runAStep() {
  orb2.applyForce(g);
  orb2.applyForce(orb2.calculateSpringForce(orb1));
  orb2.run();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  
  if (key == 'h') {
    PVector force = new PVector(mouseX - orb2.getPos().x, mouseY - orb2.getPos().y);
    orb2.applyForce(force.setMag(dist(mouseX, mouseY, orb2.getPos().x, orb2.getPos().y) / 75f));
    moving = true;
  }

  if (key == 'r') {
    reset();
  }
}