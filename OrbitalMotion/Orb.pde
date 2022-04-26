class Orb {
  private PVector pos; //position
  private PVector vel; //velocity
  private PVector nextAccel; //acceleration for the next tick
  private float psize;
  private color orbColor;
  
  public Orb(int x, int y){
    if(psize == 0) psize = 10;
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    nextAccel = new PVector(0, 0);
  }
  
  public void display(){
    stroke(0);
    strokeWeight(1);
    fill(orbColor);
    circle(pos.x, pos.y, psize);
  }
  
  public void setSize(float psize){
    this.psize = psize;
  }
  public void setColor(color c){
    orbColor = c;
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
  
  public void run(boolean dampening){
    vel.add(nextAccel);
    if(!checkInXBound()){
      vel.x = dampening ? -0.9 * vel.x : -vel.x;
    } 
    if(!checkInYBound()){
      vel.y = dampening ? -0.9 * vel.y : -vel.y;
    }
    pos.add(vel);
    nextAccel = new PVector(0, 0);
  }
}
