import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;

float tileSize;
float tileColor;
float x;
float y;

void setup(){
  //size(600, 600);
  fullScreen();
  colorMode(HSB);
  background(0);
  smooth();
  noStroke();

  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);

  tileSize = 10;
  tileColor = 100;
  x = 0;
  y = 0;

}

void draw(){

  tileColor = map(in.left.get(50), 0, 1, 0, 255);
  tileColor = map(in.right.level(), 0, .3, 235, 5);
  fill(tileColor, 235, 250);

  rect(x, y, tileSize, tileSize);

  x += tileSize;

  if(x > width){
    x = 0;
    y += tileSize;
  }

}

void keyPressed(){
    background(0);
    x = 0;
    y = 0;
}

void stop(){
  in.close();
  minim.stop();
  super.stop();
}