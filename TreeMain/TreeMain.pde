Tree fir;
int state = 0;

void setup() {
  size(800, 500);
  fir = new Tree(width / 2, 20, 5);
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
    println(fir.preOrder(fir.getRoot()));
  }
}