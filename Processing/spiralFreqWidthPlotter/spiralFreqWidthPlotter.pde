import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.svg.*;
import processing.pdf.*;

Minim minim;
AudioInput in;
FFT fft;

float d;
float arc;
float theta;
float max;
float weight;

int recording = 1;

String fileName;

void setup(){
  size(600,600);
  //fullScreen();
  colorMode(HSB);
  background(0);
  noStroke();
  
  max = min(width, height);
  weight = 6;
  d = max - weight;
  arc = PI/64;
  theta = -HALF_PI;

  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);
  
}

void draw(){
  
  translate(width/2, height/2);

  
  if (recording == 1) {
    //String fileName = "hello.PDF";
    fileName = fileNamer();
    beginRecord(PDF, "exports/" + fileName + ".pdf");
    recording = 0;
  }
  
    
  
  // break when diameter smaller than _
  if (d > 550) {
     drawSpiral();
  }
  else{
    recording = 2;
  }
  
  if (recording == 2) {
    endRecord();
  }
}

void keyPressed(){
    background(0);
    d = max - weight;
    theta = -HALF_PI;
}

void stop(){
  in.close();
  minim.stop();
  super.stop();
}

void drawEllipse(){
  ellipse(80,80,40,40);
}

void drawSpiral(){
    weight = map(in.left.get(50), 0, 1, 2, 10);
    weight = map(in.right.level(), 0, .3, 2, 10);
    
    noFill();
    stroke(0, 0, 100);
    strokeWeight(weight);
    smooth();
    arc(0, 0, d, d, theta, theta + arc);
    theta += arc % TWO_PI;
    d -= .12;  
}

String fileNamer(){

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

//void exportSVG(){
//  String fileName = "hello.svg";
//  beginRecord(SVG, "images/" + fileName);
//  drawSpiral();
//  endRecord();
//}