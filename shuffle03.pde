import processing.video.*;
Capture cap;
MoveCap mvcap;

PImage testImg;
void setup() {
  size(640, 480);
  testImg = loadImage("IMG_3284.JPG");
  testImg.resize(640, 480);
  testImg.updatePixels();
  mvcap = new MoveCap(3, 3);
}

void draw() {
  background(0);
  mvcap.update(testImg);
  mvcap.display();
  mvcap.moveCap();
}
