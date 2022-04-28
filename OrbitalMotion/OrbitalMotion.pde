float GRAVITY = 0.1;

OrbNode orbs[] = new OrbNode[3];
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
  int x = width / 2 - 50;
  int y = 100;
  for(int i = 0; i < orbs.length; i++){
    orbs[i] = new OrbNode(x, y);
    x += 100;
    orbs[i].setColor(255);
  }
  orbs[1].connectNext(orbs[2]);
  orbs[1].connectPrev(orbs[0]);
  orbs[2].connectPrev(orbs[1]);
}


void draw() {
  background(255);
  fill(255);
  strokeWeight(1);
  if (moving) {
    runAStep();
  }
  for(OrbNode o : orbs) o.display();
  strokeWeight(1);
  fill(255, 0, 0, 100); 
}

void runAStep() {
  orbs[1].applySpringForce();
  orbs[1].applyForce(g);
  orbs[2].applySpringForce();
  orbs[2].applyForce(g);
  orbs[1].run();
  orbs[2].run();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  
  if (key == 'h') {
    moving = true;
    orbs[2].applyForce(new PVector((mouseX - orbs[2].getPos().x) * 0.01, (mouseY - orbs[2].getPos().y) * 0.01));
    orbs[1].applyForce(new PVector((mouseX - orbs[1].getPos().x) * 0.01, (mouseY - orbs[1].getPos().y) * 0.01));
  }

  if (key == 'r') {
    reset();
  }
}
