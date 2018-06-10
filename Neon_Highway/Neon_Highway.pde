import moonlander.library.*;
import ddf.minim.*;

// Our public Moonlander instance
Moonlander moonlander;

int CANVAS_WIDTH = 1600;
int CANVAS_HEIGHT = 900;

// Needed for audio
Minim minim;
AudioPlayer song;

float DISTANCE_BETWEEN_MARKINGS = 600;

float VERT_VANISHING_POINT = height/2 - 10;

float roadMarkX = 0;
float roadMarkY = (height/2 + 30);
float roadMarkZ1 = 100;
float roadMarkZ2 = roadMarkZ1 + 30;

ArrayList<Roadmark> marks = new ArrayList();
Puu[] puut = new Puu[6];

//Blurred moon image
PImage moon;

void settings() {
  // The P3D parameter enables accelerated 3D rendering.
  //size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D);
  fullScreen(P3D);
}

void setup() {
  frameRate(60);
  moonlander = Moonlander.initWithSoundtrack(this, "data/tekno_127bpm.mp3", 127, 8);
  moonlander.start("localhost", 1338, "syncdata.rocket");
  
  //minim = new Minim(this);
  //song = minim.loadFile("data/Ouroboros.mp3");
  //song.play();
  moon = loadImage("data/moon.png");
  //moon = loadImage("data/moon2.png");
  generateRoadMarks();
}


/*
 * Processing's drawing method
 */
void draw() {
  noCursor();
  //scale(width/1000);
  translate(width/2, height/2, 0);
  moonlander.update();
  background(0);
  rectMode(CENTER);
  
  //Rocket values
  float musicNoise = (float) moonlander.getValue("noiseFactor");
  float beat = (float) moonlander.getValue("speed");
  
  //Drawings
  drawRoad();
  moveRoadmarks(31.75);
  checkRoadmarks();
  drawRoadmarks();
  drawHorizon();
  //drawMoon();
  imageMode(CENTER);
  image(moon, 0, VERT_VANISHING_POINT - height/4);
  noiseLines(musicNoise);
}

void noiseLines(float musicNoise) {
  float noiseScale = 0.02;
  noFill();
  strokeWeight(1);
  color c = #42C6FF;
  for (int x=-width; x < width; x += 5) {
    float noiseVal = noise((musicNoise+x)*noiseScale, musicNoise*noiseScale);
    stroke(c);
    if(x > -140 && x < 140) {
      if(x > - 100 && x < 100) {
        if(x > -10 && x < 10) {
          line(x, VERT_VANISHING_POINT, x, VERT_VANISHING_POINT - noiseVal * 0.5);
        } else {
          line(x, VERT_VANISHING_POINT, x, VERT_VANISHING_POINT - noiseVal * 100/2);
        }
      } else {
        line(x, VERT_VANISHING_POINT, x, VERT_VANISHING_POINT - noiseVal * 100/1.5);
      }
    } else {
      line(x, VERT_VANISHING_POINT, x, VERT_VANISHING_POINT - noiseVal * 100);
    }
  }
}

void generateRoadMarks() {
  
  float firstZ1 = 0;
  for(int i = 0; i < 9000; i += DISTANCE_BETWEEN_MARKINGS) {
    marks.add(new Roadmark((firstZ1 - i)));
  }
}

void moveRoadmarks(float step) {

  for(Roadmark mark : marks) {
    mark.moveCloser(step);
  }
}

void drawRoadmarks() {
  for(Roadmark mark : marks) {
    mark.drawMarking();
  } 
}

void checkRoadmarks() {
  if(marks.get(0).isOutsideView(200)) {
    marks.remove(0);
    marks.add(new Roadmark(marks.get(marks.size() - 1).z1 - DISTANCE_BETWEEN_MARKINGS));
  }
}

void drawRoad() {
  noFill();
  stroke(#42C6FF);
  strokeWeight(4);
  line(
    -(width - 10), //X1
    height, //Y1
    -70, //Z1
    -2, //X2
    VERT_VANISHING_POINT - 5, //Y2
    100 //Z2
    );
  line(
   (width - 10), //X1
   height, //Y1
   -70, //Z1
   2, //X2
   VERT_VANISHING_POINT - 5, //Y2
   100 //Z2
   );
}

void drawHorizon() {
  noFill();
  stroke(#42C6FF);
  line((-width/2), VERT_VANISHING_POINT, width, VERT_VANISHING_POINT);
}
