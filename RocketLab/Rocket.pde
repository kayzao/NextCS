class Rocket {

  static final int START_X = 250;
  static final int START_Y = 250;

  // All of our physics stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector[] angles;
  float[] mags;
  int moveCount;
  // Size
  float r;


  Rocket(PVector l, int numMoves) {
    acceleration = new PVector();
    velocity = new PVector();
    angles = new PVector[numMoves];
    mags = new float[numMoves];
    position = l.copy();
    moveCount = 0;
    r = 4;
  }

  Rocket(PVector[] as, float[] ms, int numMoves) {
    this(new PVector(START_X, START_Y), numMoves);
    angles = as;
    mags = ms;
  }

  void randomMoves() {
    for (int m=0; m < angles.length; m++) {
      float theta = random(TWO_PI);
      angles[m] = new PVector(cos(theta), sin(theta));
      mags[m] = random(0.1);
    }
  }

  void reset() {
    acceleration = new PVector();
    velocity = new PVector();
    position = new PVector(START_X, START_Y);
    moveCount = 0;
  }

  void run() {
    PVector move = angles[moveCount].copy();
    move.mult(mags[moveCount]);
    applyForce(move);
    moveCount = (moveCount+1) % angles.length;
    update();
  }


  void applyForce(PVector f) {
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    float theta = velocity.heading() + PI/2;
    fill(200, 100);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    // Thrusters
    rectMode(CENTER);
    fill(0);
    rect(-r/2, r*2, r/2, r);
    rect(r/2, r*2, r/2, r);

    // Rocket body
    fill(175);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();

    popMatrix();
  }

}
