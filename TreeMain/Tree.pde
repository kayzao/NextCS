class Tree{
  private TreeNode root;
  private int totalLevels;
  private color codeColor, defaultColor;

  public Tree(int x, int y, int numLevels, boolean random){
    totalLevels = numLevels;
    if(!random) root = makeTree(x, y, numLevels);
    else root = makeRandomTree(x, y, numLevels);
    codeColor = color(100, 205, 255);
    defaultColor = color(255);
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

  public TreeNode makeRandomTree(int x, int y, int numLevels){
    if(numLevels <= 0) return null;
    TreeNode root = new TreeNode(x, y);
    if(random(1) < ((numLevels * 1.0) / (totalLevels * 1.0))){
      TreeNode left = makeRandomTree(x - int(width / (pow(2, (totalLevels - numLevels) +2))), min(y + 20 * numLevels, y+50), numLevels - 1);
      root.setLeft(left);
    }
    if(random(1) < ((numLevels * 1.0) / (totalLevels * 1.0))){
      TreeNode right = makeRandomTree(x + int(width / (pow(2, (totalLevels - numLevels) +2))), min(y + 20 * numLevels, y+50), numLevels - 1);
      root.setRight(right);
    }
    root.setChar((char(int(random(1) * 26) + 97)));    
    return root;
  }

  public TreeNode getRoot(){
    return root;
  }

  public int getHeight(){
    return getHeightRecursive(root);
  }

  private int getHeightRecursive(TreeNode root){
    if(root == null) return 0;
    return 1 + max(getHeightRecursive(root.getLeft()), getHeightRecursive(root.getRight()));
  }

  public int numNodes(){
    return numNodesRecursive(root);
  }

  private int numNodesRecursive(TreeNode root){
    if(root == null) return 0;
    return 1 + numNodesRecursive(root.getLeft()) + numNodesRecursive(root.getRight());
  }

  public void colorCode(){
    colorCodeRecursive(root);
  }

  public void colorCodeRecursive(TreeNode root){
    if(root == null) return;
    if(getHeightRecursive(root.left) == getHeightRecursive(root.right)){
      root.setColor(codeColor);
    } else {
      root.setColor(defaultColor);
    }
    colorCodeRecursive(root.left);
    colorCodeRecursive(root.right);
  }

  public String preOrder(TreeNode tn){
    if(tn == null) return "";
    return tn.c + preOrder(tn.getLeft()) + preOrder(tn.getRight());
  }

  public String inOrder(TreeNode tn){
    if(tn == null) return "";
    return tn.c + preOrder(tn.getLeft()) + preOrder(tn.getRight());
  }

  public String postOrder(TreeNode tn){
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