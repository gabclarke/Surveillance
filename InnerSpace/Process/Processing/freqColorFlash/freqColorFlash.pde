import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;
FFT fft;

float tileColor;
String location;

void setup(){
  fullScreen();
  colorMode(HSB);
  background(0);
  smooth();
  noStroke();

  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);

  tileColor = 100;
  location = "48°52\'00.2\"N 2°19\'58.4\"E";
}

void draw(){

  
  text(location, 50, 50);
  fill(0,0,0);
  tileColor = map(in.left.get(50), 0, 1, 0, 255);
  tileColor = map(in.right.level(), 0, .3, 235, 5);
  //background(tileColor, 235, 250);
}

void stop(){
  in.close();
  minim.stop();
  super.stop();
}