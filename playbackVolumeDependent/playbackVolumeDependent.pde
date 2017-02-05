// script to change playback volume depending on ambiant noise levels
// adapted from code from http://code.compartmental.net/minim/gain_class_gain.html by Damien Di Fede
// author: Gaby Clarke

import ddf.minim.*;
import ddf.minim.ugens.*;
 
Minim minim;
FilePlayer player;
Gain gain;
AudioInput in;
AudioOutput out;

// file to be played
String fileName = "RhapsodyInBlue.mp3";
 
void setup()
{
  size(500, 200);
 
  minim = new Minim(this);
 
  // loads file from current directory
  //player = minim.loadFileStream(fileName);
  player = new FilePlayer( minim.loadFileStream(fileName) );
  player.loop();
  
  // initialize Gain at 0 dB (no amplitude change)
  gain = new Gain(0.f);
  
  // get linein
  in = minim.getLineIn();
  
  // get lineout
  out = minim.getLineOut();
  
  // patch player to output
  player.patch(gain).patch(out);
  
}
 
void draw()
{
  
  // get ambiant noise level
  // mapped to a value on [0,1]
  float ambiantLevel = in.mix.level();
  
  // set background color dependent on noise level
  background(255 * ambiantLevel * 10);
  
  // update the gain value
  float dB = map(ambiantLevel, 0, 1, 0, -10);
  gain.setValue(dB);
  
  text("Current Gain is " + dB + " dB.", 10, 20);
}