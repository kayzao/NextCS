class TreeNode {
  private PVector pos;
  private float psize; //diameter
  private color fillCol = color(255);
  private final color col_left = color(240,0,0);
  private final color col_right = color(50,250,50);
  private String name;
  private TreeNode left, right;
  private char c;
  
  public TreeNode(int x, int y) {
    pos = new PVector(x,y);
    psize = 20;
    c = char(int(random(1) * 26) + 97);
  }

  public PVector getPos(){
    return pos;
  }

  public TreeNode getLeft(){
    return left;
  }

  public TreeNode getRight(){
    return right;
  }

  public char getChar(){
    return c;
  }

  public void setChar(char c){
    this.c = c;
  }

  public void setLeft(TreeNode left){
    this.left = left;
  }

  public void setRight(TreeNode right){
    this.right = right;
  }

  public void setPos(PVector pos){
    this.pos = pos;
  }
 
  public void display() {
    stroke(0);
    fill(fillCol);
    circle(pos.x, pos.y, psize);
    //draw lines to left and right
    float OFFSET = 3;
    if (left != null) {
      stroke(col_left);
      line(pos.x - OFFSET, pos.y - 0, left.pos.x - OFFSET, left.pos.y - 0);
    }
    if (right != null) {
      stroke(col_right);
      line(pos.x + OFFSET, pos.y + 0, right.pos.x + OFFSET, right.pos.y + 0);
    }

    textAlign(CENTER);
    textSize(15);
    fill(0);
    text(c, pos.x, pos.y + psize / 3);
  }


}
