/*=====================
  Driver File

  On startup, a new OrbList will be displayed
  with 2 sentinel orbs and 2 regular orbs.

  Pressing space will allow the orbs to run,
  applying gravity and the spring force to
  each orb.

  Pressing m will cycle through different
  interactice modes, explained further in
  keyPressed anad mousePressed. The current
  mode will be displayed in the lower left corner.

  Clicking the mouse will either add a new
  orb or modify and existing orb. More details
  provided in mousePressed.
  =====================*/

int DELETE_MODE = 0;
int GROW_MODE = 1;
int SHRINK_MODE = 2;
int ADD_FIXED_MODE = 3;
int clickMode;

boolean moving;
OrbList slinky;
float GRAVITY = 0.2;
PVector g;

void setup() {
  size(500, 500);
  clickMode = DELETE_MODE;
  moving = false;
  g = new PVector(0, GRAVITY);
  makeSlinky(2, 100);
}

void draw() {
  background(255);
  if (moving) {
    slinky.applyExternalForce(g);
    slinky.applySprings();
    slinky.run();
  }
  slinky.display();
  displayMode();
}

/*=====================
  makeSlinky(int numParts, int y)

  Create a new OrbList with numParts orbs in
  addition to the 2 sentinel nodes (so if
  numParts = 2, 4 nodes in total).

  Every node should have the provided y value.

  The 2 sentinel nodes should be at (50, y)
  and (450, y).

  The rest of the nodes should be regular
  OrbNodes evely spaced between the two
  sentinel nodes.
  =====================*/
void makeSlinky(int numParts, int y) {
  OrbList orbs = new Orblist();
}

/*=====================
  keyPressed

  Respond to keyboard events in the following way:

  ' ' (space): set moving to it's opposite value.
  'r': Call makeSlinky with at least 2 nodes.
  'm': Cycle through the different clickMode values going
      DELETE_MODE, GROW_MODE, SHRINK_MODE, ADD_FIXED_MODE,
      back to DELETE_MODE and so on.
  =====================*/
void keyPressed() {
  if(key == ' ') {
    moving = !moving;
  }
  if(key == 'r') {
    makeSlinky(2, mouseY);
  }
  if(key == 'm') {
    clickMode = (clickMode + 1) % 4;
  }
}


/*=====================
  mousePressed

  Respond to mouse pressed based on clickMode:

  First, check if the mouse is currently over an
  existing orb.

  If the mouse is NOT selecting a current orb,
  add a new orb to the list with the following
  constraints.
    0) If the mouse is on the right half of the
       screen, add the orb to the end of the list.
    1) If the mouse is on the left half of the
       screen, add the orb to the front of the list.
    2) If clickMode is ADD_FIXED_MODE, then a
       FixedOrb should be added.

  If the mouse is selecting  a current (non sentinel)
  orb, perform the following action based on the
  current value of clickMode.
    DELETE_MODE: Remove the selected orb from the list.
    GROW_MODE: Increase the size of the orb by 1.
    SHRINK_MODE: Decrease the size of the orb by 1.
  =====================*/
void mousePressed() {
  if(detectMouse() == -1){ //mouse is not over orb
    if(mouseX > width/2) {
      orbs.append(x, y, false);
    }
  }
}//mousePressed

/*=====================
  displayMode should be left unmodified.
  =====================*/
void displayMode() {
  String message = "DELETE_MODE";
  if (clickMode == GROW_MODE) {
    message = "GROW MODE";
  }
  else if (clickMode == SHRINK_MODE) {
    message = "SHRINK MODE";
  }
  else if (clickMode == ADD_FIXED_MODE) {
    message = "ADD FIXED MODE";
  }
  fill(0);
  textSize(20);
  text(message, 10, height-10);
}