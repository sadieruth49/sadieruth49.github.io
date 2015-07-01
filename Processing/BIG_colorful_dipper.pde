/**
  * This sketch demonstrates how to play a file with Minim using an AudioPlayer. <br />
  * It's also a good example of how to draw the waveform of the audio.
  * <p>
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */

import ddf.minim.*;

Minim minim;
AudioPlayer player;

int barWidth = 1;
int lastBar = 3;

float beginX = 20.0;  // Initial x-coordinate
float beginY = 10.0;  // Initial y-coordinate
float endX = 570.0;   // Final x-coordinate
float endY = 320.0;   // Final y-coordinate
float distX;          // X-axis distance to move
float distY;          // Y-axis distance to move
float exponent = 10;   // Determines the curve
float x = 0.0;        // Current x-coordinate
float y = 0.0;        // Current y-coordinate
float step = 0.1;    // Size of each step along the path
float pct = 0.0;      // Percentage traveled (0.0 to 1.0)


void setup()
{
  
  size(700,500); 
  colorMode(HSB, width, height, width);  
  //noStroke();
  background(0);
  
  noStroke();
  distX = endX - beginX;
  distY = endY - beginY;
  
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  //rewind();
  
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile("08 Big Dipper.mp3");
  
  // play the file from start to finish.
  // if you want to play the file again, 
  // you need to call rewind() first.
  player.play();
}

void draw()
{
  
  colorMode(HSB, 360, width, height);
  noStroke(); 
  int whichBar = mouseX / barWidth;
  if (whichBar != lastBar+3) {
    int barX = whichBar * barWidth;
    fill(mouseY, width, height);
    rect(barX, 0, barWidth, height*2);
    lastBar = whichBar;
  
 
  ellipse(0, 0, width, height);
  pct += step;
  if (pct < 1.0) {
    x = beginX + (pct * distX);
    y = beginY + (pow(pct, exponent) * distY);
  }
  
  ellipse(x, y*30, 10, 13);
  
  
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
 
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, height );
    float x2 = map( i+1, 0, player.bufferSize(), 0, width );
    stroke(player.left.get(i)*180+180, player.right.get(i)*180+180, 400);
    line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
    line( x1, 50 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
  }
  
  pct = 0.0;
  beginX = x;
  beginY = y;
  endX = mouseX;
  endY = mouseY;
  distX = endX - beginX;
  distY = endY - beginY;
}
}


void mousePressed() {
  noStroke();
  rectMode(CENTER);
  rect(mouseX/3+20,mouseY*2.5,16,16);
  rectMode(CENTER);
  rect(mouseX+5,mouseY*2.3,22,20);
  rectMode(CENTER);
  ellipse(mouseX-2,mouseY/1.5,10,16);
  
  
  pct = 0.0;
  beginX = x;
  beginY = y;
  endX = mouseX;
  endY = mouseY;
  distX = endX - beginX;
  distY = endY - beginY;
 
}


// Whenever a user presses a key the code written inside keyPressed() is executed.
void keyPressed() {
  background(0);
}

