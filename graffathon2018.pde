import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import moonlander.library.*;

AudioPlayer player;
Minim minim;
Moonlander moonlander;
//Blurred moon image
PImage moon;

void settings() {
  fullScreen(P3D);
  //size(1280,720);
}

void setup() {
  frameRate(60);
  moonlander = Moonlander.initWithSoundtrack(this, "data/Night_Prowler.mp3", 110, 1);
  //moonlander.start("localhost", 1338, "syncdata.rocket");
  moonlander.start();
  background(0);
  noStroke();
  moon = loadImage("data/moon.png");
  generateRoadMarks();
  initTrees();
  setupNoiseWave();
  setupStars();
  colorMode(RGB);
}

void draw() {
  moonlander.update();
  int currentScene = moonlander.getIntValue("scene");
  if(currentScene == 0) {
    drawNoiseWave();
  } else if (currentScene == 1) {
    drawHightway();
  } else if (currentScene == 2) {
    colorMode(HSB);
    noStroke();
    drawPlasma();
  } else if (currentScene == 3) {
    colorMode(RGB);
    strokeWeight(3);
    drawStars();
  } else if  (currentScene == 4) {
    exit();
  }
}
