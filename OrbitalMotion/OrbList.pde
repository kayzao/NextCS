class OrbList{
  private OrbNode startOrb, endOrb;
  private int length;
  
  public OrbList(){
    this(null);
    length = 0;
  }

  public OrbList(OrbNode startOrb){
    this.startOrb = startOrb;
    endOrb = startOrb;
    length = 1;
  }

  public OrbList(int x, int y){
    this(new OrbNode(x, y));
  }

  public PVector getPosOrb(int n){
    OrbNode current = startOrb;
    for(int i = 0; i < n; i++){
      current = current.getNext();
    }
    return current.getPos();
  }
  
  private void calculateLength(){
    length = 1;
    OrbNode test = startOrb;
    while(test.getNext() != null){
      test = test.getNext();
      length++;
    }
  }

  public void display(){
    OrbNode iter = startOrb;
    for(int i = 0; i < length; i++){
      iter.display();
      if(i < length - 1) iter = iter.getNext();
    }
  }
  
  public void addFront(int x, int y){
    OrbNode o = new OrbNode(x, y);
    if(length == 0){
      this.startOrb = startOrb;
      endOrb = startOrb;
      length = 1;
      return;
    }
    OrbNode prevStart = startOrb;
    startOrb = o;
    startOrb.setNext(prevStart);
    startOrb.setPrev(null);
    prevStart.setPrev(startOrb);
    length++;
  }
  
  public void append(int x, int y){
    OrbNode o = new OrbNode(x, y);
    if(length == 0){
      this.startOrb = startOrb;
      endOrb = startOrb;
      length = 1;
      return;
    }
    OrbNode prevLast = endOrb;
    endOrb = o;
    prevLast.setNext(endOrb);
    endOrb.setPrev(prevLast);
    endOrb.setNext(null);
    length ++;
  }

  public void run(){
    OrbNode iter = startOrb;
    for(int i = 0; i < length; i++){
      iter.run();
      if(i < length - 1) iter = iter.getNext();
    }
  }
  
  public void applySprings(int start){
    OrbNode iter = startOrb;
    for(int i = 0; i < length; i++){
      if(i < start){
        iter = iter.getNext();
        continue;
      }
      iter.applySpringForce();
      if(i < length - 1) iter = iter.getNext();
    }
  }

  public void applyForceAll(PVector force){
    OrbNode iter = startOrb;
    for(int i = 0; i < length; i++){
      iter.applyForce(force);
      if(i < length - 1) iter = iter.getNext();
    }
  }

  public void applyForce(PVector force, int start){
    OrbNode iter = startOrb;
    for(int i = 0; i < length; i++){
      if(i < start){
        iter = iter.getNext();
        continue;
      }
      iter.applyForce(force);
      if(i < length - 1) iter = iter.getNext();
    }
  }
}
