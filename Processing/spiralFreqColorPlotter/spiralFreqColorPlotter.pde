import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;
FFT fft;

float r;
float arc;
float theta;

float tileSize;
float tileColor;
float x;
float y;

void setup(){
  fullScreen();
  colorMode(HSB);
  background(0);
  smooth();
  noStroke();
  
  float max = min(width, height);
  print(max);
  
  r = max - 6;
  arc = PI/64;
  theta = -HALF_PI;

  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);

  tileSize = 10;
  tileColor = 100;
  x = 0;
  y = 0;

}

void draw(){

  translate(width/2, height/2);
  
  tileColor = map(in.left.get(50), 0, 1, 0, 255);
  tileColor = map(in.right.level(), 0, .3, 235, 5);
  
  noFill();
  stroke(tileColor, 235, 250);
  strokeWeight(6);
  smooth();
  arc(0, 0, r, r, theta, theta + arc);
  theta += arc;
  r -= .25;
  
  if(theta > TWO_PI){
    theta = 0;
  }
  
  //x += tileSize;

  //if(x > width){
  //  x = 0;
  //  y += tileSize;
  //}

}

void keyPressed(){
    background(0);
    //x = 0;
    //y = 0;
    r = 0;
    theta = 0;
}

void stop(){
  in.close();
  minim.stop();
  super.stop();
}