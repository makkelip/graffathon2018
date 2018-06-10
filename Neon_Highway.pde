float MARKINGS_DISTANCE = 600;
float TREES_DISTANCE = 800;
float TREE_SIZE = 35;
float NOISEBARS_DISTANCE = -7000;

float VERT_VANISHING_POINT = height/2 - 10;

float roadMarkX = 0;
float roadMarkY = (height/2 + 30);
float roadMarkZ1 = 100;
float roadMarkZ2 = roadMarkZ1 + 30;

ArrayList<Roadmark> marks = new ArrayList();
ArrayList<Puu> treesLeft = new ArrayList();
ArrayList<Puu> treesRight = new ArrayList();

/*
 * Processing's drawing method
 */

float beat;

void drawHightway() {
  noCursor();
  //scale(width/1000);
  translate(width/2, height/2, 0);
  moonlander.update();
  background(0);
  rectMode(CENTER);
  
  //Rocket values
  float musicNoise = (float) moonlander.getValue("noiseFactor");
  beat = (float) moonlander.getValue("speed");
  beatTrees();
  //Drawings
  scale(5,5);
  noiseLines(musicNoise);
  scale(0.2,0.2);
  
 
  moveRoadmarks(40.5);
  moveTrees(27.5);
    
  checkRoadmarksAndTrees();
  
  drawRoad();
  drawTrees();
  drawRoadmarks();
  drawHorizon();
  drawMoon();
}

void noiseLines(float musicNoise) {
  float noiseScale = 0.02;
  noFill();
  strokeWeight(1);
  color c = #42C6FF;
  for (int x=-width; x < width; x += 10) {
    float noiseVal = noise((musicNoise + x)*noiseScale, musicNoise*noiseScale);
    stroke(c);
    if(x > -140 && x < 140) {
      if(x > - 100 && x < 100) {
        if(x > -10 && x < 10) {
          line(x, VERT_VANISHING_POINT, NOISEBARS_DISTANCE,
               x, VERT_VANISHING_POINT - noiseVal * 50, NOISEBARS_DISTANCE);
        } else {
          line(x, VERT_VANISHING_POINT, NOISEBARS_DISTANCE,
               x, VERT_VANISHING_POINT - noiseVal * 100, NOISEBARS_DISTANCE);
        }
      } else {
        line(x, VERT_VANISHING_POINT, NOISEBARS_DISTANCE,
             x, VERT_VANISHING_POINT - noiseVal * 150, NOISEBARS_DISTANCE);
      }
    } else {
      line(x, VERT_VANISHING_POINT, NOISEBARS_DISTANCE, 
           x, VERT_VANISHING_POINT - noiseVal * 200, NOISEBARS_DISTANCE);
    }
  }
}

void beatTrees() {
  for (int i = 0; i < treesLeft.size(); i++) {
    treesLeft.get(i).setMod(beat);
    treesRight.get(i).setMod(beat);
  }
}

void generateRoadMarks() {
  
  float initialZ = 0;
  for(int i = 0; i < 9000; i += MARKINGS_DISTANCE) {
    marks.add(new Roadmark((initialZ - i)));
  }
}

void initTrees() {
  
  float initialZ = 0;
  for(int i = 0; i < 6000; i += TREES_DISTANCE) {
    treesLeft.add(new Puu(-500, 250, initialZ - i, TREE_SIZE));
  }
  for(int i = 0; i < 6000; i += TREES_DISTANCE) {
    treesRight.add(new Puu(500, 250, initialZ - i, TREE_SIZE));
  }
}

void drawTrees() {
  for(Puu tree : treesLeft) {
    tree.draw();
  }
  for(Puu tree : treesRight) {
    tree.draw();
  }
}

void moveRoadmarks(float step) {

  for(Roadmark mark : marks) {
    mark.moveCloser(step);
  }
}

void moveTrees(float step) {
  for(Puu tree : treesLeft) {
    tree.moveCloser(step);
  }
  for(Puu tree : treesRight) {
    tree.moveCloser(step);
  }
}

void drawRoadmarks() {
  for(Roadmark mark : marks) {
    mark.drawMarking();
  } 
}

void checkRoadmarksAndTrees() {
  if(marks.get(0).isOutsideView(200)) {
    marks.remove(0);
    marks.add(new Roadmark(marks.get(marks.size() - 1).z1 - MARKINGS_DISTANCE));
  }
  if(treesLeft.get(0).isOutsideView(500)) {
    treesLeft.remove(0);
    treesLeft.add(new Puu(-500, 250, treesLeft.get(treesLeft.size() - 1).z - MARKINGS_DISTANCE, TREE_SIZE));
  }
  if(treesRight.get(0).isOutsideView(500)) {
    treesRight.remove(0);
    treesRight.add(new Puu(500, 250, treesRight.get(treesRight.size() - 1).z - MARKINGS_DISTANCE, TREE_SIZE));
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
    VERT_VANISHING_POINT - 15, //Y2
    100 //Z2
    );
  line(
   (width - 10), //X1
   height, //Y1
   -70, //Z1
   2, //X2
   VERT_VANISHING_POINT - 15, //Y2
   100 //Z2
   );
}

void drawMoon() {
  imageMode(CENTER);
  image(moon, 0, VERT_VANISHING_POINT - height/4);
}

void drawHorizon() {
  noFill();
  stroke(#42C6FF);
  scale(5,5);
  line((-width/2)*3, VERT_VANISHING_POINT, -6001, width, VERT_VANISHING_POINT,-6001);
  scale(0.2,0.2);
}
