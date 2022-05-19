class Tree{
  private TreeNode root;
  private int totalLevels;

  public Tree(int x, int y, int numLevels){
    totalLevels = numLevels;
    root = makeTree(x, y, numLevels);
  }

  public TreeNode makeTree(int x, int y, int numLevels){
    if(numLevels <= 0) return null;
    TreeNode root = new TreeNode(x, y);
    TreeNode left = makeTree(x - int(width / (pow(2, (totalLevels - numLevels) +2))), min(y + 20 * numLevels, y+50), numLevels - 1);
    TreeNode right = makeTree(x + int(width / (pow(2, (totalLevels - numLevels) +2))), min(y + 20 * numLevels, y+50), numLevels - 1);
    root.setChar((char(int(random(1) * 26) + 97)));
    root.setLeft(left);
    root.setRight(right);
    return root;
  }
  private TreeNode getRoot(){
    return root;
  }

  public String preOrder(TreeNode tn){
    if(tn == null) return "";
    return tn.c + preOrder(tn.getLeft()) + preOrder(tn.getRight());
  }

  public void inOrderDisplay(){
    inOrderDisplay(root);
  }

  private void inOrderDisplay(TreeNode root){
    if(root == null) return;
    inOrderDisplay(root.getLeft());
    root.display();
    inOrderDisplay(root.getRight());
  }

  public void postOrderDisplay(){
    postOrderDisplay(root);
  }
  
  private void postOrderDisplay(TreeNode root){
    if(root == null) return;
    postOrderDisplay(root.getLeft());
    postOrderDisplay(root.getRight());
    root.display();
  }

  public void preOrderDisplay(){
    preOrderDisplay(root);
  }

  private void preOrderDisplay(TreeNode root){
    if(root == null) return;
    root.display();
    preOrderDisplay(root.getLeft());
    preOrderDisplay(root.getRight());
  }
}