import ddf.minim.*;
import ddf.minim.ugens.*;
 
Minim minim;
AudioInput in;

int maxWidth;
float baseline;

float maxLevel; // Maximum sound level expected
float[] levels; // Sound level readings
float[] colors; // Frequency readings
float barColor;
 
void setup() {
  fullScreen();
  //size(1200, 600);
  maxWidth = width - 1;
  baseline = height * .9;
  
  colorMode(HSB);
  
  maxLevel = 2;
  levels =  new float[width]; // Initialized to zeroes
  colors =  new float[width]; // Initialized to zeroes
  barColor = 0;
  
  minim = new Minim(this);
 
  // get linein
  in = minim.getLineIn(Minim.MONO, 512);
}
 
void draw() {
  background(0, 0, 0); 
  
  // Get and store ambiant noise level
  float ambiantLevel = in.mix.level()*15;
  levels[maxWidth] = ambiantLevel;
  
  colors[maxWidth] = map(in.left.get(50), 0, 1, 0, 255);
  colors[maxWidth] = map(in.right.level(), 0, .3, 235, 5);
   
  // Map the element so it fits in our graph
  levels[maxWidth] = map(levels[maxWidth], 0, maxLevel, 0, height);
   
  // Plot all the readings
  for (int i = 0; i < maxWidth; i++) {
    // Set opacity so points fade over time
    //fade = map(i, 0, width, 0, 255);
    
    // Modify element y-coordinate
    float y = baseline - levels[i];
   
    // Bar plotting
    line(i, y, i, baseline);
    stroke(colors[i], 235, 250);
    strokeWeight(2);
    
    // Shift reading index for scrolling effect
    levels[i] = levels[i + 1]; 
    colors[i] = colors[i + 1];
  }  
}