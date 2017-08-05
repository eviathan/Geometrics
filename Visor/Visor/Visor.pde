// Constants
color a = color(0);
color b = color(255);

int rings = 32;
float ringWidth = 2.0;

void setup(){ 
  size(1000, 1000);
  background(0);
  noLoop(); 
  smooth();
  noFill();

  stroke(lerpColor(a, b, .5));
  strokeWeight(10);
  
  Arc test = new Arc();
}

void draw () {
  
}

class Arc {
  Arc (){
    
  }
}