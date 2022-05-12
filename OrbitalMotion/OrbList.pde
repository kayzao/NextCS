public class OrbList {

  private OrbNode front;
  private OrbNode back;

  /*=====================
    Constructor

    Create FixedOrbs at (x0, y0) and (x1, y1).
    Set front to the orb at (x0, y0).
    Set back to the orb at (x1, y1).
    Connect front and back accordingly.
    =====================*/
  public OrbList(int x0, int y0, int x1, int y1) {
    front = new FixedOrbNode(x0, y0);
    back = new FixedOrbNode(x1, y1);
    front.setNext(back);
    back.setPrev(front);
  }

  public OrbNode getFront() {
    return front;
  }

  public OrbNode getBack() {
    return back;
  }

  public void addFront(int x, int y, boolean fixed) {
    OrbNode o;
    if(fixed) o = new FixedOrbNode(x, y);
    else o = new OrbNode(x, y);
    OrbNode nxt = front.getNext();
    nxt.setPrev(o);
    o.setNext(nxt);
    o.setPrev(front);
    front.setNext(o);
  }

  public void append(int x, int y, boolean fixed) {
    OrbNode o;
    if(fixed) o = new FixedOrbNode(x, y);
    else o = new OrbNode(x, y);
    OrbNode prv = back.getPrev();
    prv.setNext(o);
    o.setPrev(prv);
    o.setNext(back);
    back.setPrev(o);
  }

  public void removeNode(OrbNode pn) {
    if(pn == front || pn == back) return;
    OrbNode prv = pn.getPrev();
    OrbNode nxt = pn.getNext();
    prv.setNext(nxt);
    nxt.setPrev(prv);
  }


  /*=====================
    selectNode(int x, int y)

    If (x, y) is a position inside a NON
    SENTINEL node in this list (as defined
    by the constains()method in OrbNode),
    return a reference to that node.

    In all other cases, return null.
    =====================*/
  public OrbNode selectNode(int x, int y) {
    OrbNode i = front.getNext();
    while(i != null) {
      if(i.contains(new PVector(x, y))) return i;
      i = i.getNext();
    }
    return null;
  }
  

  //finds the leftmost node right of the given x pos
  OrbNode findNextNode(float x) {
    OrbNode i = front.getNext();
    if(x < i.getPos().x) return i;
    while(i != null) {
      if(i.getPos().x > x) return i;
      i = i.getNext();
    }
    return back;
  }

  public void display() {
    OrbNode current = front;
    while (current != null) {
      current.display();
      current = current.next;
    }
  }

  public void applySprings() {
    OrbNode current = front;
    while (current != null) {
      current.applySpringForce();
      current = current.next;
    }
  }

  public void applyExternalForce(PVector force) {
    OrbNode current = front;
    while (current != null) {
      current.applyForce(force);
      current = current.next;
    }
  }

  public int detectMouse(){
    OrbNode current = front.getNext();
    int index = 1;
    while(current.getNext() != null){ //while current is not the back sentinel
      if(current.contains(new PVector(mouseX, mouseY))){
        return index;
      }
      index++;
      current = current.getNext();
    }
    return -1;
  }

  public void run() {
    OrbNode current = front;
    while (current.getNext() != null) {
      current.run();
      current = current.next;
    }
  }

  public String toString() {
    String s = "";
    OrbNode current = front;
    while (current != null) {
      s+= current;
      current = current.next;
    }
    return s;
  }

}
