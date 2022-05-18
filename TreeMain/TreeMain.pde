TreeNode root;

void setup(){
  size(400, 400);
  root = new TreeNode(width / 2, 25);
  root = growTree(4, int(root.getPos().x), int(root.getPos().y));
}

void draw(){
  recursiveDisplay(root);
}

void recursiveDisplay(TreeNode t){
  if(t == null) return;
  t.display();
  recursiveDisplay(t.getLeft());
  recursiveDisplay(t.getRight());
}

TreeNode growTree(int levels, int x, int y){
  if(levels <= 0) return null;
  TreeNode root = new TreeNode(x, y);
  TreeNode left = growTree(levels - 1, x - 20 * levels, y + 50);
  TreeNode right = growTree(levels - 1, x + 20 * levels, y + 50);
  root.setLeft(left);
  root.setRight(right);
  return root;
}

void keyPressed(){
  if(key == ' '){
    println(root.getPos());
  }
}