class RegularGon extends PathShape {
  int MAX_SIDES = 20;
  int numSides;
  int radius;

  RegularGon(int cx, int cy, int sides, int length) {
    centroid[0] = cx;
    centroid[1] = cy;
    numSides = sides;
    if (numSides < 3) numSides = int(random(3, 32));
    radius = length;
    leftX = centroid[0] - radius;
    topY = centroid[1] - radius;
    shapeWidth = radius;
    shapeHeight = radius;

    generateRegularPolygon();
  }

  RegularGon(int sides, int length, float rSpeed, color c) {
    this(0, 0, sides, length);
    rotationSpeed = rSpeed;
    inside = c;
  }

  boolean isValid() {
    return xs.size() > 0;
  }//isValid

  void randomize() {
    centroid[0] = leftX + shapeWidth/2;
    centroid[1] = topY+ shapeHeight/2;
    numSides = int(random(3, MAX_SIDES+1));

    radius = int(random(5, shapeWidth/2));
    generateRegularPolygon();
  }

  void generateRegularPolygon() {
    if (numSides > 0) {
      float theta = radians(360 / numSides);
      for (int n=0; n < numSides; n++) {
        int x = int(radius * cos(n * theta)) + centroid[0];
        int y = int(radius * sin(n * theta)) + centroid[1];
        xs.append(x);
        ys.append(y);
      }
    }
  }
}
