import ddf.minim.*;
import ddf.minim.ugens.*;
 
Minim minim;
AudioInput in;

int maxWidth;
float baseline;

float maxLevel; // Maximum sound level expected
float[] readings; // Sound level readings
float fade;
 
void setup() {
  //fullScreen();
  size(1200, 600);
  maxWidth = width - 50;
  baseline = height * .9;
  
  maxLevel = 2;
  readings =  new float[width]; // Initialized to zeroes
  fade = 0;
  
  minim = new Minim(this);
 
  // get linein
  in = minim.getLineIn();
}
 
void draw() {
  background(0, 0, 0); 
  
  // Get and store ambiant noise level
  float ambiantLevel = in.mix.level()*15;
  readings[maxWidth] = ambiantLevel;
   
  // Map the element so it fits in our graph
  readings[maxWidth] = map(readings[maxWidth], 0, maxLevel, 0, height);
   
  // Plot all the readings
  for (int i = 0; i < maxWidth; i++) {
    // Set opacity so points fade over time
    fade = map(i, 0, width, 0, 255);
    
    // Modify element y-coordinate
    float y = baseline - readings[i];
   
    // Bar plotting
    line(i, y, i, baseline);
    stroke(fade);
    
    // Shift reading index for scrolling effect
    readings[i] = readings[i + 1]; 
  }  
}