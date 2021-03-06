class Puu {
  
  float points = 52;
  float x, y, z;
  float size;
  float change = 0;
  float changeD = 0.01;
  float palmMod;
  float palmAddition;
  float varsiSize;
  
  Puu(float x, float y, float z, float size) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.size = size;
    varsiSize = size*6;
  }
  
  void setMod(float mod) {
    this.palmMod = mod;
  }
  
  void setPos(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void draw() {
    //stroke(#ff0081);
    noStroke();
    fill(#ff0081);
    strokeWeight(2);
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
      vertex(x+v.x,y-varsiSize+v.y, z+v.z);
    }
    endShape();
    //varsi
    beginShape();
    vertex(x+varsiSize*0.083,y+varsiSize/2-varsiSize, z);
    vertex(x+varsiSize*0.083,y+varsiSize-varsiSize, z);
    vertex(x-varsiSize*0.045,y+varsiSize-varsiSize, z);
    vertex(x,y+varsiSize/2-varsiSize, z);
    vertex(x,y-varsiSize,z);
    endShape();
  }
  
  void moveCloser(float step) {
    this.z += step;
  }
  
  boolean isOutsideView(float limit) {
    if(this.z < limit) {
      return false;
    } else {
    return true;
    }
  }
}
