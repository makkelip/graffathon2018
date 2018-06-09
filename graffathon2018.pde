import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import moonlander.library.*;

Moonlander moonlander;

int CANVAS_W = 480;
int CANVAS_H = 360;
PVector flowfield[];
PVector vector;

void settings() {
  size(CANVAS_W, CANVAS_H, P3D);
}

void setup() {
  moonlander = Moonlander.initWithSoundtrack(this, "../data/tekno_127bpm.mp3", 127*2, 8);
  moonlander.start();
  frameRate(60);
  colorMode(HSB, 360, 100, 100);
}

Spikey s = new Spikey(0,0,50, 0.01);

void draw(){
  moonlander.update();
  background(140);
  translate(CANVAS_W/2, CANVAS_H/2);
  s.setRadius((float)moonlander.getValue("beat"));
  s.draw();
}

class Spikey {
  
  int points, x, y;
  float radius = 80;
  float change = 0;
  float changeD;
  Spikey(int x, int y, int points, float changeD) {
    this.points = points;
    this.x = x;
    this.y = y;
    this.changeD = changeD;
  }
  
  void setRadius(float radius) {
    this.radius = radius;
  }
  
  void draw() {
    change += changeD;
    if(change > 10) change = 0; 
    PVector v;
    float section = PI/points;
    fill(255);
    beginShape();
    for (int i = 0; i < points; i++) {
      v = PVector.fromAngle(-section*i);
      //if (i%2 == 0) {
        v.setMag(noise(i/2+change)*100 + radius);
      //} else {
      //  v.setMag(100);
      //}
      vertex(x+v.x,y+v.y);
    }
    endShape(CLOSE);
  }
}
