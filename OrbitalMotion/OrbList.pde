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

  /*=====================
    addFront(int x, int y, boolean fixed)

    Create a new OrbNode at (x, y), if fixed
    is true, make that orb a FixedOrd.

    Add the new OrbNode to the front, AFTER
    the sentinel node (see explanation at the
    top of this file).
    =====================*/
  public void addFront(int x, int y, boolean fixed) {

  }

  /*=====================
    append(int x, int y, boolean fixed)

    Create a new OrbNode at (x, y), if fixed
    is true, make that orb a FixedOrd.

    Add the new OrbNode to the back, BEFORE
    the sentinel node (see explanation at the
    top of this file).
    =====================*/
  public void append(int x, int y, boolean fixed) {

  }


  /*=====================
    removeNode(OrbNode pn)

    Assume that pn is an OrbNode in this list.

    Remove pn from the list by changing the
    appropriate links.
    =====================*/
  public void removeNode(OrbNode pn) {

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

    return null;
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
    while (current != null) {
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