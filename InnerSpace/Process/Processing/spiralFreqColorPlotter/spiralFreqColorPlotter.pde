import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;
FFT fft;

float d;
float arc;
float theta;
float max;
float weight;
float freqColor;

void setup(){
  fullScreen();
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
  
  // break when diameter smaller than _ and theta = TWO_PI*(3/4)
  if (d > 775) {
  
    freqColor = map(in.left.get(50), 0, 1, 0, 255);
    freqColor = map(in.right.level(), 0, .3, 235, 5);
    
    noFill();
    stroke(freqColor, 235, 250);
    strokeWeight(weight);
    smooth();
    arc(0, 0, d, d, theta, theta + arc);
    theta += arc % TWO_PI;
    d -= .12;

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