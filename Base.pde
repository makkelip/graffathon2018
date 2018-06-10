float plasmaColor = 0;
float i = 0;
float plasma;

void drawPlasma() {
  background(0);
  float tiem = (float) moonlander.getValue("tiem");
  for(int x = 0; x < 100; x++) {
   for(int y = 0; y < 100; y++) {
     //plasma = sin(i+sin(x/10.5+i*3.5) + sin(y/11.5+i*3) - cos((y-x)/8.5+i*2.5) - sin(x/10.5+i*3));
     plasma = sin(i+sin(x/10.5+i) - sin(x/11.5+i) + cos((x-y)/8.5+i) - sin(y/11.5+i*2));
     plasmaColor = map(sin(plasma-tiem/TWO_PI),-1,1,0,255);
     fill(plasmaColor,255,255);
     rect(x*19.2,y*10.8,20,20);
   }
   i = i + 0.00015;
  } 
}
