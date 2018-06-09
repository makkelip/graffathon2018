class Roadmark {
  
  float x = 0;
  float y = height/2;
  
  float z1;
  float z2;
  
  Roadmark(float z1) {
    this.z1 = z1;
    this. z2 = z1 - 70;
  }
  
  void drawMarking() {
    noFill();
    stroke(#42C6FF);
    strokeWeight(2);
    this.z2 = z1 - 130;
    line(
      x,
      y,
      z1,
      x,
      y,
      z2
    );
  }
  
  void moveCloser(float step) {
    this.z1 += step;
    this.z2 = z1 - 30;
  }
  
  boolean isOutsideView(float limit) {
    if(this.z1 < limit) {
      return false;
    } else {
    return true;
    }
  }
}
