Star[] stars = new Star[1000];

void setupStars() {
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void drawStars() {
  background(0);
  translate(width/2, height/2);
  
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}
void showGreets() {
  PFont font;
  font = createFont("../data/METAG.TTF", 48);
  textFont(font);
  fill(244, 34, 90);
  text("G r e e t i n g s", width / 200, -70);
  textAlign(CENTER, TOP);
  text("G r a f f a t h o n  2 O 1 B", width / 200, -50);
  textAlign(CENTER, CENTER);
  text("m a h a p o y d a l _ A T K", width / 200, height / 15);
  textAlign(CENTER, BOTTOM); 
}
