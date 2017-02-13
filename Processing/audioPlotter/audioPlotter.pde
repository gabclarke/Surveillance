import ddf.minim.*;
import ddf.minim.ugens.*;
 
Minim minim;
AudioInput in;


// Set the width and height of the window to make
int windowWidth = 800;
int windowHeight = 300;
float maxTemp = 1; //Maximum temperature expect to read
float[] readings = new float[windowWidth]; // initialized to zeroes
 
void setup()
{
  //fullScreen();
  size(800, 300);  // Set up the window
  
  minim = new Minim(this);
 
  // get linein
  in = minim.getLineIn();
}
 
void draw()
{
  background(0, 0, 0, TIME SINCE START);  // Sets the background to white and clears screen each time through loop
  
  
  float ambiantLevel = in.mix.level()*15;
  
  readings[windowWidth - 1] = ambiantLevel;
   
  // Map the element so it fits in our graph
  readings[windowWidth - 1] = map(readings[windowWidth - 1], 0, maxTemp, 0, height);
   
  // Plot all the points
  for (int i = 0; i < windowWidth - 1; i++)
  {
    ellipse(i, height*3/4 - readings[i], 2, 2);
    noStroke();
    fill(255);
    readings[i] = readings[i + 1]; // Shift the readings to the left so can put the newest reading in
  }  
  
}