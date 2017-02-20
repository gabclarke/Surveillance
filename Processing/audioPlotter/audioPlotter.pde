import ddf.minim.*;
import ddf.minim.ugens.*;
 
Minim minim;
AudioInput in;

// Window setup
int windowWidth = 1200;
int windowHeight = 600;
int maxWidth = windowWidth - 50;
float baseline = windowHeight*3/4;

float maxLevel = 2; // Maximum sound level expected
float[] readings = new float[windowWidth]; // Initialized with zeroes
float fade = 0;

 
void setup()
{
  //fullScreen();
  size(1200, 600);
  
  minim = new Minim(this);
 
  // get linein
  in = minim.getLineIn();
}
 
void draw()
{
  background(0, 0, 0); 
  
  float ambiantLevel = in.mix.level()*15;
  
  readings[maxWidth] = ambiantLevel;
   
  // Map the element so it fits in our graph
  readings[maxWidth] = map(readings[maxWidth], 0, maxLevel, 0, height);
   
  // Plot all the points
  for (int i = 0; i < maxWidth; i++)
  {
    // Set opacity so points fade over time
    fade = map(i, 0, windowWidth, 0, 255);
    
    // Modify element y-coordinate
    float y = baseline - readings[i];
   
   
    // Bar plotting
    line(i, y, i, baseline);
    stroke(fade);
    
    // Dot plotting
    //ellipse(i, y, 2, 2);
    //noStroke();
    //fill(fade);
    
    readings[i] = readings[i + 1]; // Shift the readings to the left so can put the newest reading in
  }  
  
}