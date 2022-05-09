final float GRAVITY = 0.1;
OrbList orbs;
PVector g;
boolean moving, gravity;

void setup() {
  size(800, 400);
  g = new PVector(0, GRAVITY);
  println("==========================================================================================");
  println("SPACE to enable/disable movement, H to apply force, G to toggle gravity, and R to reset");
  println("==========================================================================================");
  reset();
}

void reset() {
  moving = false;
  gravity = true;
  int x = width / 2 - 50;
  int y = 100;
  orbs = new OrbList();
  orbs.append(new FixedOrbNode(x, y));
  x += OrbNode.SPRING_LENGTH;
  for (int i = 1; i < 20; i++) {
    orbs.append(new OrbNode(x, y));
    x += OrbNode.SPRING_LENGTH;
    if(i == 10){
      orbs.append(new FixedOrbNode(x, y));
      x+= OrbNode.SPRING_LENGTH;
    }
  }
  orbs.append(new FixedOrbNode(x, y));
}


void draw() {
  background(255);
  fill(255);
  strokeWeight(1);
  if (moving) {
    runAStep();
  }
  strokeWeight(1);
  fill(255, 0, 0, 100);
  orbs.display();

  fill(0);
  text("Movement: " + (moving ? "ENABLED" : "DISABLED"), 10, 20);
  text("Gravity: " + (gravity ? "ENABLED" : "DISABLED"), 10, 30);
}

void runAStep() {
  orbs.applySprings();
  if (gravity) orbs.applyForce(g);
  orbs.run();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }

  if (key == 'h') {
    moving = true;
    orbs.applyForce(new PVector((mouseX - orbs.getPosOrb(2).x) * 0.01, (mouseY - orbs.getPosOrb(2).y) * 0.01));
  }

  if (key == 'g') {
    gravity = !gravity;
  }

  if (key == 'r') {
    reset();
  }
}
