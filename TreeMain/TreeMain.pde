TreeNode root, a, b, c, d;

void setup(){
  size(400, 400);
  root = new TreeNode(width / 2, 25, "root");
  a = new TreeNode(width / 2 - 50, 75, "a");
  b = new TreeNode(width / 2 + 50, 75, "b");
  c = new TreeNode(width / 2 - 100, 125, "c");
  d = new TreeNode(width / 2 + 100, 125, "d");

  root.left = a;
  root.right = b;
  a.left = c;
  b.right = d;
}

void draw(){
  recursiveDisplay(root);
}

void recursiveDisplay(TreeNode t){
  t.display();
  if(t.left != null) recursiveDisplay(t.left);
  if(t.right != null) recursiveDisplay(t.right);
}
