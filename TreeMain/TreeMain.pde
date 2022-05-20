Tree fir;
int state = 0;

void setup() {
  size(800, 500);
  fir = new Tree(width / 2, 20, 5, true);
}

void draw(){
  background(200);
  String str;
  if(state == 0) {
    fir.inOrderDisplay();
    str = "inOrderDisplay";
  } else if(state == 1){
    fir.postOrderDisplay();
    str = "postOrderDisplay";
  } else {
    fir.preOrderDisplay();
    str = "preOrderDisplay";
  }
  fill(0);
  textSize(30);
  text(str, 100, 20);
}

void mouseReleased() {
  state = (state + 1) % 3;
}

void keyPressed(){
  if(key == ' '){
    println("order of nodes in preorder form: " + fir.preOrder(fir.getRoot()));
  }
  if(key == 'r'){
    fir = new Tree(width / 2, 20, 5, true);
  }
  if(key == 'n'){
    println("number of nodes: " + fir.numNodes());
  }
  if(key == 'h'){
    println("height: " + fir.getHeight());
  }
  if(key == 'c'){
    fir.colorCode();
    println("colored nodes based on height");
  }
}