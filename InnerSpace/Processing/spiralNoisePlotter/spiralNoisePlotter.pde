import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioInput in;

// Polar plotting variables
//float r;
float theta;
float theta_vel;
float theta_acc;

float maxLevel; // Maximum sound level expected
int i; // Index for recorded data
float[] readings; // Sound level readings
float[] x;
float[] y;
float fade;

void setup() {
  size(640, 640);
  
  // Initialize all values
  //r = height * 0.2;
  theta = 0;
  theta_vel = .01;
  theta_acc = 0;
  maxLevel = 2;
  readings =  new float[width]; // Initialized to zeroes
  x =  new float[width]; // Initialized to zeroes
  y =  new float[width]; // Initialized to zeroes
  i = 0;
  fade = 0;
  
  minim = new Minim(this);
 
  // get linein
  in = minim.getLineIn();
}

void draw() {
  background(0, 0, 0);
  
  // Translate the origin point to the center of the screen
  translate(width/2, height/2);
  
  // Get and store ambiant noise level
  float ambiantLevel = in.mix.level()*150;
  readings[i] = ambiantLevel;
   
  // Map the element so it fits in our graph
  readings[i] = map(readings[i], 0, maxLevel, 0, height/2);
  x[i] = readings[i] * cos(theta);
  y[i] = readings[i] * sin(theta);
  
  // Plot all the readings
  for (int j = 0; j < width; j++) {
    // Set opacity so points fade over time
    fade = map(j, 0, width, 0, 255);
    
    //float y = height - readings[j];
  
    //// Convert polar to cartesian
    float x = readings[i] * cos(theta);
    float y = readings[i] * sin(theta);
  
    line(0,0,x[j],y[j]);
    //line(0,0,j,y);
    stroke(fade);
  
    // Apply acceleration and velocity to angle, increase radius
    theta_vel += theta_acc;
    theta += theta_vel;
    //r += .05;
  }
  i++;
}

void stop(){
  in.close();
  minim.stop();
  super.stop();
}