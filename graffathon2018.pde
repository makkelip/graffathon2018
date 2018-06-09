import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import moonlander.library.*;

import peasy.*;

import peasy.*;

Moonlander moonlander;

int CANVAS_W = 480;
int CANVAS_H = 360;
PVector flowfield[];
PVector vector;

void settings() {
  size(CANVAS_W, CANVAS_H, P2D);
  moonlander = Moonlander.initWithSoundtrack(this, "", , )
}

void setup() {
  frameRate(60);
  colorMode(HSB, 360, 100, 100);
}

Spikey s = new Spikey(0,0,50, 0.01);

void draw(){
  background(140);
  translate(mouseX, mouseY);
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
    PVector v;
    float section = TWO_PI/points;
    fill(255);
    beginShape();
    for (int i = 0; i < points; i++) {
      v = PVector.fromAngle(section*i);
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
