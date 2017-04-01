// http://i.imgur.com/CcjNO7L.gif  
PGraphics planets;
PGraphics lines;
 
Planet sun = new Planet(0, 0);
Planet venus = new Planet(224.7, 100);
Planet earth = new Planet(365.256, 250);

float earthCounter = 0.0;
float venusCounter = 0.0;
float orbitMultiplier = 5.0;

class Planet {
 
  float OrbitSpeed;
  float OrbitRadius;
  float Size = 15.0;
  PVector Position = new PVector(0, 0);
  PVector LastPosition;
  color Color = color(255);
 
  public Planet(float orbit, float radius){
    OrbitSpeed = orbit;
    OrbitRadius = radius;
  }
  
  public void DrawAtPosition(float index, PGraphics layer){
    layer.noStroke();
    //stroke(0);
    layer.fill(Color);    
    CalculatePosition(index);    
    layer.ellipse(Position.x, Position.y, Size, Size); 
  }
  
  public void CalculatePosition(float i){
    Position = new PVector(sin(radians(i*360))*OrbitRadius+(width*.5),cos(radians(i*360))*OrbitRadius+(height*.5));
  }
  
  public void SetLastPosition() {
    LastPosition = Position;
  }
  
  public void DrawLineBetweenPositions(PGraphics layer) {
    if(LastPosition != null){
      layer.stroke(255, 30);
      layer.line(Position.x, Position.y, LastPosition.x, LastPosition.y);
    }
    
  }
}
 
void setup() {
  size(600, 600);
  smooth(8);
  frameRate(60);
  
  // Init Planets
  sun.Size = 50;
  
  venus.Position = new PVector(width*.5, height*.5);
  
  earth.Position = new PVector(width*.5, height*.5);
  earth.Size = 25;
  
  // Create Graphics Layers
  planets = createGraphics(width, height, JAVA2D);
  lines = createGraphics(width, height, JAVA2D);
}
 

void draw() { 
  delay(10);
  earthCounter = earthCounter > 1.0 ? 0.0 : earthCounter;
  venusCounter = venusCounter > 1.0 ? 0.0 : venusCounter;
  
  background(0);
  
  planets.beginDraw();
  planets.background(0);
  planets.stroke(255);  
  sun.DrawAtPosition(0, planets);
  venus.DrawAtPosition(venusCounter, planets);
  earth.DrawAtPosition(earthCounter, planets); 
  planets.endDraw();
 
  lines.beginDraw(); 
  lines.stroke(255,80);  
  lines.line(earth.Position.x, earth.Position.y, venus.Position.x, venus.Position.y);
  earth.DrawLineBetweenPositions(lines);
  earth.SetLastPosition();
  venus.DrawLineBetweenPositions(lines);
  venus.SetLastPosition();
  lines.endDraw();
  blendMode(SCREEN);
  
  image(lines, 0, 0, width, height);
  image(planets, 0, 0, width, height); 
 
  earthCounter+=1.0/earth.OrbitSpeed * orbitMultiplier;
  venusCounter+=1.0/venus.OrbitSpeed * orbitMultiplier;
}