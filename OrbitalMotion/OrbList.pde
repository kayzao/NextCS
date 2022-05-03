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
  
  public void calculateLength(){
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
  
  public void addFront(OrbNode o){
    OrbNode prevStart = startOrb;
    startOrb = o;
    startOrb.setNext(prevStart);
    startOrb.setPrev(null);
    prevStart.setPrev(startOrb);
    length++;
  }
  
  public void append(OrbNode o){
    OrbNode prevLast = endOrb;
    endOrb = o;
    prevLast.setNext(endOrb);
    endOrb.setPrev(prevLast);
    endOrb.setNext(null);
    length ++;
  }
}
