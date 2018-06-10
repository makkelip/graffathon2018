import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import moonlander.library.*;

Minim minim;
Moonlander moonlander;
int CANVAS_WIDTH = 480;
int CANVAS_HEIGHT = 360;

float plasmaColor = 0;
float i = 0;
float plasma;
void settings() {
 size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D); 
}

void setup() {
  frameRate(60);
  moonlander = Moonlander.initWithSoundtrack(this, "../common/tekno_127bpm.mp3", 127, 8);
  moonlander.start("localhost", 1338, "syncdata.rocket");
  background(0);
  noStroke();
  noiseSeed(0);
  colorMode(HSB);
}

void draw() {
  drawPlasma();
}

void drawPlasma() {
  moonlander.update();
  float tiem = (float) moonlander.getValue("tiem");
  for(int x = 0; x < 100; x++) {
   for(int y = 0; y < 100; y++) {
     //plasma = sin(i+sin(x/10.5+i*3.5) + sin(y/11.5+i*3) - cos((y-x)/8.5+i*2.5) - sin(x/10.5+i*3));
     plasma = sin(i+sin(x/10.5+i) - sin(x/11.5+i) + cos((x-y)/8.5+i) - sin(y/11.5+i*2));
     plasmaColor = map(sin(plasma-tiem),-1,1,0,255);
     fill(plasmaColor,255,255);
     rect(x*4.8,y*3.6,8,8);
   }
   i = i + 0.00015;
  } 
}
