// "Record" audio visualizer
// Gaby Clarke, Spring 2017
// Parsons Paris, Spatial Lab

// This sketch takes audio input and visualizes it as if we were pressing a 
// vinyl record.  The exported PDF files are intended to be lasercut into 
// physical "prints" of the characteristic sounds of a physical space.


import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.svg.*;
import processing.pdf.*;

Minim minim;
AudioInput in;
FFT fft;

float max; // maximum possible spiral diameter
float weight; // spiral stroke weight
float d; // diameter of the spiral
float min; // minimum allowed spiral diameter
float arc; // angle of arc drawn with each audio input
float theta; // angular position of arc being drawn

int recording = 1;  // trilean for exporting the visual
String fileName;  // filename for export

void setup(){
  fullScreen();
  colorMode(HSB);
  background(0);
  noStroke();
  
  max = min(width, height); // maximum spiral diameter is smaller dimension
  weight = 6;
  d = max - weight;
  min = 241;
  arc = PI/64;
  theta = -HALF_PI;

  // start audio recording
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);
}

void draw(){
  
  translate(width/2, height/2); // moves origin to center of screen
  
  // start recording visualization
  if (recording == 1) {
    fileName = fileNamer();
    beginRecord(PDF, "exports/" + fileName + ".pdf");
    recording = 0;
  }
   
  // stop drawing and recording when diameter smaller than min
  if (d > min) {
     drawSpiral();
  }
  else{
    drawCutCircles();
    recording = 2;
  }
  
  if (recording == 2) {
    endRecord();
  }
}

void keyPressed(){
  // restarts visualization, initializes new recording on SPACE press
  if (key == ' '){
    background(0);
    d = max - weight;
    theta = -HALF_PI;
    recording = 1;
  }
}

void stop(){
  in.close();
  minim.stop();
  super.stop();
}

void drawSpiral(){
  // draws spiral audio visualization
  
  // set weight according to audio input pitch and volume
  weight = map(in.left.get(50), 0, 1, 2, 10);
  weight = map(in.right.level(), 0, .3, 2, 10);
  
  // draw arc
  noFill();
  stroke(0, 0, 100);
  strokeWeight(weight);
  smooth();
  arc(0, 0, d, d, theta, theta + arc);
  
  // step the position forward and the diameter in
  theta += arc % TWO_PI;
  d -= .12;  
}

void drawCutCircles(){
  // draws circles for lasercutting the exported visualization
  
  stroke(0, 0, 0); // set to black so invisible on screen
  ellipse(0, 0, max, max);
  ellipse(0, 0, min - weight, min - weight);
}

String fileNamer(){
  // names file according to date and time
  
  int y = year();
  int m = month();
  int d = day();
  String date = String.valueOf(y) + "-" + String.valueOf(m) + "-" + String.valueOf(d);
  
  int h = hour();
  int min = minute();
  int s = second();
  String time = String.valueOf(h) + "." + String.valueOf(min) + "." + String.valueOf(s);
  
  fileName = date + " at " + time;
  return fileName;
}