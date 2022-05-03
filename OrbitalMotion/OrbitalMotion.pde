float GRAVITY = 0.1;

OrbList orbs;
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
  int y = 200;
  orbs = new OrbList(new OrbNode(x, y));
  x += 50;
  for(int i = 1; i < 3; i++){
    orbs.append(new OrbNode(x, y));
    x += 50;
  }
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
}

void runAStep() {
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  
  if (key == 'h') {
    moving = true;
    //orbs[1].applyForce(new PVector((mouseX - orbs[1].getPos().x) * 0.01, (mouseY - orbs[1].getPos().y) * 0.01));
  }

  if (key == 'r') {
    reset();
  }
}
