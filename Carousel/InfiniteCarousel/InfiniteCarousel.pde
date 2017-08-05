//-------------------------------------------------------------
// App
//-------------------------------------------------------------
// Globals
Carousel carousel;

// Init
void setup(){
  size(800, 800);
  background(20); 
  carousel = new Carousel(width, height);
}

// Run
void draw(){
  background(20);
  stroke(255);
  strokeWeight(4);  
  textSize(32);
  carousel.run();  
}

// Mouse Event Handlers
void mousePressed() {
  carousel.isDragging = true;  
  carousel.setMouseEndVector(mouseX, mouseY);
  carousel.setMouseStartVector(mouseX, mouseY);
}
  
void mouseDragged() {
  carousel.setMouseEndVector(mouseX, mouseY);
}
  
void mouseReleased() {
  carousel.isDragging = false;
  carousel.decayCounter = 0;
}

//-------------------------------------------------------------
// Carousel
//-------------------------------------------------------------
class Carousel {
  boolean isDragging = false;
  PVector mouseVector, mouseStartVector, mouseEndVector;
  int centerX, centerY;
  float decayCounter;
  float friction = 10.5;
  float easing = 50;
  float deadZone = 5; // Note: Removes Center Point jitter
  
  int amountOfCards = 12;
  ArrayList<Card> cards;
  
  Carousel(int w, int h){
    centerX = (int)(w*0.5);
    centerY = (int)(h*0.5);
    mouseVector = new PVector(centerX,centerY);
    mouseStartVector = new PVector(centerX,centerY);
    mouseEndVector = new PVector(centerX,centerY);
    cards = getCardStack(amountOfCards);
  }
  
  void run(){    
    if(isDragging){
      mouseVector = getMouseVector();
    }
    draw();
    applyMovement(friction);
  }
  
  void draw(){
    drawDebug();
    drawCards();
  }
  
  void drawDebug(){
    int offsetY = -300;
    ellipse(centerX,centerY+offsetY,20,20);
    fill(255);
    ellipse(mouseVector.x, centerY+offsetY,20,20);
    line(centerX,centerY+offsetY,mouseVector.x, centerY+offsetY);
  }
  
  void drawCards(){
    PVector globalMouseVector = getGlobalMouseVector();  
    for(Card card : cards){
      card.draw(card.x + globalMouseVector.x, card.y, card.width, card.height); // NOTE: Temp values for testing
    }
  }
  
  void applyMovement(float friction){
    PVector globalMouseVector = getGlobalMouseVector();       
    
    // If in X-Axis deadzone then set to centerX position
    if(globalMouseVector.x < deadZone && globalMouseVector.x > -deadZone){
      mouseVector.x = centerX;
    }
    else{
      // Add deceleration with exponential easing curve
      mouseVector.x += (globalMouseVector.x > 0 ? -friction : friction) * exp(-easing/decayCounter);
    }
    
    // If in Y-Axis deadzone then set to centerY position
    if(globalMouseVector.y < deadZone && globalMouseVector.y > -deadZone){
      mouseVector.y = centerY;
    }
    else{
      // Add deceleration with exponential easing curve
      mouseVector.y += (globalMouseVector.y > 0 ? -friction : friction) * exp(-easing/decayCounter);
    }
    
    decayCounter++;
    
  }

  PVector getMouseVector(){
    float x = centerX + (mouseEndVector.x - mouseStartVector.x);    
    float y  = centerY + (mouseEndVector.y - mouseStartVector.y);  
    return new PVector(x, y);
  }
  
  PVector getGlobalMouseVector(){
    float x = mouseVector.x - centerX;
    float y = mouseVector.y - centerY;
    return new PVector(x,y);
  }
  
  void setMouseStartVector(float x, float y){
    mouseStartVector.x = x;
    mouseStartVector.y = y;
  }
  
  void setMouseEndVector(float x, float y){
    mouseEndVector.x = x;
    mouseEndVector.y = y;
  }
  
  ArrayList<Card> getCardStack(int amount){
    ArrayList<Card> output = new ArrayList<Card>();
    
    // Note: Values here just for testing
    int cardSize = 80;
    float yOffset = 0;
    float xMargin = 30;
    float yPosition = ((width*0.5)-(cardSize*0.5)) + yOffset;
    
    for(int i = 0; i < amount; i++){
      float xPosition = (i * (cardSize + xMargin + (cardSize*0.5)));      
      
      output.add(new Card(Integer.toString(i),xPosition,yPosition,cardSize,cardSize));      
    }
        
    return output;
  }
}

class Card {
  String name;
  float x, y, width, height;
  
  Card(String n, float xPos, float yPos, float w, float h) {
    name = n;
    x = xPos;
    y = yPos;
    width = w;
    height = h;
  }
  
  void draw(float xPos, float yPos, float w, float h) {
    x = xPos;
    y = yPos;
    width = w;
    height = h;
    
    fill(255);
    rect(x,y,w,h);
    
    fill(12);
    //text(name, width*0.5, height*0.5); 
  }
  
  
}