class Orb {
  private PVector pos; //position
  private PVector vel; //velocity
  private PVector nextAccel; //acceleration for the next tick
  private float psize;
  private color orbColor;
  private boolean drawVector;
  static final float SPRING_LENGTH = 100;
  static final float SPRING_CONST = 0.005;
  static final float AIR_DAMPING = 0.995;
  static final float VECTOR_SIZE = 3;

  public Orb(int x, int y){
    if(psize == 0) psize = 20;
    drawVector = true;
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    nextAccel = new PVector(0, 0);
  }
  
  public void display(){
    stroke(0);
    strokeWeight(1);
    fill(orbColor);
    circle(pos.x, pos.y, psize);
    if(drawVector){
      stroke(0);
      strokeWeight(5);
      line(pos.x, pos.y, pos.x + vel.x * VECTOR_SIZE , pos.y + vel.y * VECTOR_SIZE);
    }
  }

  public float getY(){
    return pos.y;
  }

  public float getX(){
    return pos.x;
  }
  
  public void setSize(float psize){
    this.psize = psize;
  }

  public void setColor(color c){
    orbColor = c;
  }

  public void drawVector(boolean b){
    drawVector = b;
  }

  public void applyForce(PVector f){
    nextAccel.add(f);
  }
  
  public boolean checkInXBound(){
    return pos.x >= psize / 2f && pos.x <= width - psize / 2f; 
  }
  
  public boolean checkInYBound(){
    return pos.y >= psize / 2f && pos.y <= height - psize / 2f; 
  }

  public PVector calculateSpringForceY(Orb other){
    //f = kx, x is displacement from rest length, k is spring constant
    PVector force = new PVector(0, -SPRING_CONST * (SPRING_LENGTH - abs(other.getY() - pos.y)));
    if(other.getY() < pos.y) force.mult(-1);
    return force;
  }
  
  public void run(){
    vel.add(nextAccel);
    if(!checkInXBound()){
      if(pos.x < psize / 2f) pos.x = psize / 2f;
      if(pos.x > width - psize / 2f) pos.x = width - psize / 2f;
      vel.x = -vel.x;
    } 
    if(!checkInYBound()){
      if(pos.y < psize / 2f) pos.y = psize / 2f;
      if(pos.y > height - psize / 2f) pos.y = height - psize / 2f;
      vel.y = -vel.y;
    }
    vel.mult(AIR_DAMPING);
    pos.add(vel);
    nextAccel = new PVector(0, 0);
  }
}
