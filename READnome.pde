/*  
 *  READnome 
 *  By: TVHeadedRobots, 2012
 *  CC Creative Commons License
 * 
 *  This Processing Sketch uses the JKLabs monomic & oscP5 libraries to generate the monome's display
 *  
 *  To use this Sketch start MonomeSerial (or other monome serial interface app) & make suer the I/O 
 *  protocol is set to OpenSoundControl. Then set the address pattern prefix to "/box" (no quotes.)
 *  Now run this sketch and u should see lots-o-blinkinlights!! 
 * 
*/

import oscP5.*;
import netP5.*;
import jklabs.monomic.*;

Monome m;

// modify this value to any URL or file located in the sketch's data directory
String data = "http://www.google.com"; 

int mWidth = 8;  // the number of leds across
int mHeight = 8; // the number of leds down
int cntr = 0; // global counter
int delayTm = 0; // This is used to control the speed of the animation
int j = 0; // init the reset counter
int rsetCntJ = 1023; // init a reset value to compare against j
int rowCntr = 0;

byte rowVals = byte(0); // monome row as byte
byte columnVals = byte(0); // monome column as byte
byte b[] = loadBytes(data); 

float ledVal = 0;

void setup() {
  m = new MonomeOSC( this ); // init the monome object
  frameRate( 15 ); // set the sketches framerate
}

void draw() {

  // iterate through each row of the monome and set that row's value to a random byte
  for (int i = 0; i <  b.length; i++) {
    // get the value of the current row/column as a byte
    
    // do stuff
    ledVal = map(int(b[i]), 0, 255, 0, 1); // set the led brightness to the current byte
    
    // make sure that we stay with in the bounds of the monome's display    
    if (rowCntr < 7) {
      m.setRow(rowCntr, b[i]); // set monome row value
      m.setLedIntensity(ledVal); // set the LEDs
      rowVals = m.getRowValues(rowCntr);
      columnVals = m.getColValues(rowCntr);
      rowCntr++;
      delay(delayTm);
    }
    else {
      m.setRow(rowCntr, b[i]); // set monome row value
      m.setLedIntensity(ledVal); // set the LEDs
      rowVals = m.getRowValues(rowCntr);
      columnVals = m.getColValues(rowCntr);
      rowCntr = 0;
      delay(delayTm);
    }
       
    // reset the screen after j cycles
    if (j == rsetCntJ) {
      //m.setRow(7, byte(0));
      m.lightsOff();
      j = 0;
      println("reset the display " + rsetCntJ + " j = " + j);
    }
    else {
    //  m.setRow(i-1, byte(0));
    println("rsetCntJ = " + rsetCntJ + " j = " + j);
    j++;
    }
    
    cntr++; // increment global counter to keep things changing
  }
}

void monomePressed( int x, int y ) {
 if (x == 0 && y == 0) delayTm = 0;
 if (x == 1 && y == 0) delayTm = 25;
 if (x == 2 && y == 0) delayTm = 50;
 if (x == 3 && y == 0) delayTm = 100;
 if (x == 4 && y == 0) delayTm = 200;
 if (x == 5 && y == 0) delayTm = 300;
 if (x == 6 && y == 0) delayTm = 500;
 if (x == 7 && y == 0) delayTm = 1000;
 
 if (x == 0 && y == 1) rsetCntJ = 1023;
 if (x == 1 && y == 1) rsetCntJ = 255;
 if (x == 2 && y == 1) rsetCntJ = 15;
 if (x == 3 && y == 1) rsetCntJ = 7;
 if (x == 4 && y == 1) rsetCntJ = 4;
 if (x == 5 && y == 1) rsetCntJ = 2;
 if (x == 6 && y == 1) rsetCntJ = 1;
 if (x == 7 && y == 1) rsetCntJ = 0;
 
 j = 0;
 println("pressed! dealyTm = " + delayTm + "and reset count = " + rsetCntJ); 
}
