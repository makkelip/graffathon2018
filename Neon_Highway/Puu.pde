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
