class SplitCap {
  int splitNum, x, y;
  PImage[] spImages;
  PImage hole;
  float imgWidth, imgHeight;

  SplitCap(int _x, int _y) {
    x = _x;
    y = _y;
    splitNum = x*y;
    spImages = new PImage[splitNum];
    hole = createImage(int(width/x), int(height/y), RGB);
    for (int i=0; i< hole.pixels.length; i++) {
      hole.pixels[i] = color(0);
    }
    hole.updatePixels();
  }

  void update(PImage img) {
    img.loadPixels();
    imgWidth = img.pixelWidth;
    imgHeight = img.pixelHeight;
    for (int i=0; i<y; i++) {
      for (int j=0; j<x; j++) {
        if (i*x+j != splitNum-1) {
          spImages[i * x + j] = img.get(img.pixelWidth/x*j, img.pixelHeight/y*i, img.pixelWidth/x, img.pixelHeight/y);
        } else {
          spImages[i * x + j] = hole;
        }
      }
    }
  }

  void display() {
    for (int i=0; i<y; i++) {
      for (int j=0; j<x; j++) {
        image(spImages[i*x + j], imgWidth/x*j, imgHeight/y*i);
      }
    }
  }
}
