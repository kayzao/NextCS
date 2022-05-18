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
    root.setLeft(makeTree(x - 20 * numLevels, y + 20 * numLevels, numLevels - 1));
    root.setRight(makeTree(x + 20 * numLevels, y + 20 * numLevels, numLevels - 1));
    return root;
  }

  public void display(){
    recursiveDisplay(root);
  }

  private void recursiveDisplay(TreeNode root){
    if(root == null) return;
    root.display();
    recursiveDisplay(root.getLeft());
    recursiveDisplay(root.getRight());
  }
}