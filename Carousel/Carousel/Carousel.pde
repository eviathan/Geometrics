Carousel carousel;

void setup(){
  size(800, 800);
  background(20); 
  carousel = new Carousel(width, height);
}

void draw(){
  background(20);
  stroke(255);
  strokeWeight(4);  
  
  carousel.run();  
}

class Carousel {
  boolean isDragging = false;
  PVector mouseVector, mouseStartVector, mouseEndVector;
  int centerX, centerY, decayCounter;
  float friction = 10.5;
  float easing = 50;
  
  Carousel(int w, int h){
    centerX = (int)(w*0.5);
    centerY = (int)(h*0.5);
    mouseVector = new PVector(centerX,centerY);
    mouseStartVector = new PVector(centerX,centerY);
    mouseEndVector = new PVector(centerX,centerY);
  }
  
  void run(){
    draw();
    
    applyfriction(friction);
  }
  
  void draw(){
    ellipse(centerX,centerY,20,20);  
    
    if(isDragging){
      mouseVector = getMouseVector();
    }
    
    line(centerX,centerY,mouseVector.x, centerY);
  }
  
  void applyfriction(float friction){
    PVector globalMouseVector = getGlobalMouseVector();  
    mouseVector.x += (globalMouseVector.x > 0 ? -friction : friction)* Math.exp(-easing/decayCounter);
    mouseVector.y += (globalMouseVector.y > 0 ? -friction : friction)* Math.exp(-easing/decayCounter);  
    decayCounter++;
  }

  PVector getMouseVector(){
    float x = centerX + (mouseEndVector.x - mouseStartVector.x);
    float y  = centerY + (mouseEndVector.y - mouseStartVector.y);  
    return new PVector(x, y);
  }
  
  PVector getGlobalMouseVector(){
    float x = mouseVector.x - centerX;
    float y = mouseVector.y = centerY;
    return new PVector(x,y);
  }
  

}

void mousePressed() {
    carousel.isDragging = true;  
    carousel.mouseEndVector.x = mouseX;
    carousel.mouseEndVector.y = mouseY;
    carousel.mouseStartVector.x = mouseX;
    carousel.mouseStartVector.y = mouseY;
  }
  
  void mouseDragged() {
    carousel.mouseEndVector.x = mouseX;
    carousel.mouseEndVector.y = mouseY;
  }
  
  void mouseReleased() {  
    carousel.mouseEndVector.x = mouseX;
    carousel.mouseEndVector.y = mouseY;
    carousel.isDragging = false;
    carousel.decayCounter = 0;
  }