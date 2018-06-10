import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import moonlander.library.*;

Moonlander moonlander;

int CANVAS_W = 1600;
int CANVAS_H = 900;

void settings() {
  size(CANVAS_W, CANVAS_H, P3D);
}

void setup() {
  moonlander = Moonlander.initWithSoundtrack(this, "../data/tekno_127bpm.mp3", 127*2, 8);
  moonlander.start();
  frameRate(60);
  colorMode(HSB, 360, 100, 100);
}

Puu s = new Puu(0,0, 30);

void draw(){
  moonlander.update();
  background(140);
  translate(CANVAS_W/2, CANVAS_H/2);
  s.setMod((float)moonlander.getValue("beat"));
  s.draw();
}

class Puu {
  
  int points = 52;
  int x, y;
  int size;
  float change = 0;
  float changeD = 0.01;
  float palmMod;
  float palmAddition;
  int varsiSize;
  
  Puu(int x, int y,int size) {
    this.x = x;
    this.y = y;
    this.size = size;
    varsiSize = size*6;
  }
  
  void setMod(float mod) {
    this.palmMod = mod;
  }
  
  void draw() {
    change += changeD;
    if(change > 10) change = 0;
    PVector v;
    float section = PI/points;
    beginShape();
    for (int i = 0; i < points; i++) {
      v = PVector.fromAngle(-section*i);
      if(i == points-1) v = PVector.fromAngle(PI);
      if(section*i < HALF_PI) {
        float m = (PI-section*i)/PI;
        palmAddition = (m*m*m*size)*3;
      } else {
        float m = (PI-(PI-section*i))/PI;
        palmAddition = (m*m*m*size)*3;
      }
      if(i%3 == 0) {
        v.setMag(size + palmAddition);
      } else {
        v.setMag(noise(i/2+change)*palmMod*50 + size + palmAddition);
      }
      vertex(x+v.x,y+v.y);
    }
    endShape();
    //varsi
    beginShape();
    vertex(x+varsiSize*0.083,y+varsiSize/2);
    vertex(x+varsiSize*0.083,y+varsiSize);
    vertex(x-varsiSize*0.045,y+varsiSize);
    vertex(x,y+varsiSize/2);
    vertex(x,y);
    endShape();
  }
}
