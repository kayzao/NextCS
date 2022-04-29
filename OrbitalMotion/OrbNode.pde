class OrbNode {
  private PVector pos, vel, nextAccel;
  private float psize;
  private color orbColor;
  private boolean drawVector;
  private OrbNode next, prev;
  static final float SPRING_LENGTH = 50, SPRING_CONST = 0.005, AIR_DAMPING = 0.995, VECTOR_SIZE = 3;

  public OrbNode(int x, int y){
    if(psize == 0) psize = 20;
    drawVector = true;
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    nextAccel = new PVector(0, 0);
    next = null;
    prev = null;
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
    if(next != null){
      stroke(0, 255, 255);
      strokeWeight(2);
      line(pos.x + 5, pos.y + 5, next.getPos().x + 5, next.getPos().y + 5);
    }
    if(prev != null){
      stroke(255, 0, 0);
      strokeWeight(2);
      line(pos.x, pos.y, prev.getPos().x, prev.getPos().y);
    }
  }

  public PVector getPos(){
    return pos;
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
  
  public void connectNext(OrbNode next){
    this.next = next;
  }
  
  public void connectPrev(OrbNode prev){
    this.prev = prev;
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
  
  public void applySpringForce(){
    if(next != null) this.applyForce(calculateSpringForce(next));
    if(prev != null) this.applyForce(calculateSpringForce(prev));
  }

  private PVector calculateSpringForce(OrbNode other){
    float displacement = -(pos.dist(other.getPos()) - SPRING_LENGTH);
    PVector force = new PVector(other.getPos().x - pos.x, other.getPos().y - pos.y);
    force.setMag(-SPRING_CONST * displacement);
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
