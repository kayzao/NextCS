color col_red = color(240,0,0);
color col_green = color(50,250,50);

class TreeNode {
  PVector pos;
  float psize; //diameter
  color fillCol = color(255);
  String name;
  
  TreeNode left, right;
  
  TreeNode(int x, int y, String name) {
    pos = new PVector(x,y);
    psize = 20;
    this.name = name;
  }
 
  void display() {
    stroke(0);
    fill(fillCol);
    circle(pos.x, pos.y, psize);
    
    fill(0);
    textAlign(CENTER);
    text(name, pos.x, pos.y);
    
    //draw lines to left and right
    float OFFSET = 3;
    if (left != null) {
      stroke(col_red);
      line(pos.x - OFFSET, pos.y - 0, left.pos.x - OFFSET, left.pos.y - 0);
    }
    if (right != null) {
      stroke(col_green);
      line(pos.x + OFFSET, pos.y + 0, right.pos.x + OFFSET, right.pos.y + 0);
    }
  }
}
