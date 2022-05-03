class OrbList{
  private OrbNode startOrb;
  private int length;
  
  public OrbList(OrbNode startOrb){
    this.startOrb = startOrb;
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
    calculateLength();
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
    OrbNode last = startOrb;
    for(int i = 1; i < length; i++){
      last = last.getNext();
    }
    if(last == null){
      println("fuck");
      return;
    }
    o.setPrev(last);
    o.setNext(null);
    last.setNext(o);
    length ++;
  }
}
