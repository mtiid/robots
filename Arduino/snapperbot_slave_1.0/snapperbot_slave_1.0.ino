//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// Firmware for the SnapperBot
// by Nathan Villicana-Shaw
// Spring 2015
// CalArts MTIID
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
// supports uint8_t and uint16_t
#include <stdint.h>
// Definition of interrupt names
#include <avr/interrupt.h>
// ISR interrupt service routine
#include <avr/io.h>
//
#define unit8_t FLIP 0
#define unit8_t LOUD 1
#define unit8_t VERY 2

//for communicatoin
#include <Wire.h>

// PORTA, PORTB, PORTC, PORTL
static int snapper1[8] = {22, 23, 24, 25, 26, 27, 28, 29};
static int snapper2[8] = {10, 11, 12, 13, 50, 51, 52, 53};
static int snapper3[8] = {30, 31, 32, 33, 34, 35, 36, 37};
static int snapper4[8] = {42, 43, 44, 45, 46, 47, 48, 49};
//
uint8_t snapperStates[4];//the states of the snappers
//the incomming messages
uint8_t incommingByte;
//for parsing serial
uint8_t mode;

//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                              i2c functions
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//

//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Setup Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void setup() {
  Wire.begin(1);//this means the address for the arduino is now 2?
  Wire.onReceive(triggerEvent);//when the arduino receives a message on its Serial port it will forward the data to the receiveEvent event function
  //set all pins as output pins
  for (int i = 0; i < 8; i++) {
    pinMode(snapper1[i], OUTPUT);
    pinMode(snapper2[i], OUTPUT);
    pinMode(snapper3[i], OUTPUT);
    pinMode(snapper4[i], OUTPUT);
  }
  //set them all to high (which is low on the snapper arrays)
  for (int i = 0; i < 4; i++) {
    snapperStates[i] = 0xFF;
  }
  //write to all the ports at the same time
  setPorts(4);
}
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                        Intrument Commands
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void setPorts(uint8_t which) {
  if (which == 0) {
    PORTA = snapperStates[0];
  }
  else if (which == 1) {
    PORTB = snapperStates[1];
  }
  else if (which == 2) {
    PORTC = snapperStates[2];
  }
  else if (which == 3) {
    PORTL = snapperStates[3];
  }
  else if (which == 4) {
    PORTA = snapperStates[0];
    PORTB = snapperStates[1];
    PORTC = snapperStates[2];
    PORTL = snapperStates[3];
  }
}

void flipSwitch(uint8_t array, uint8_t swit) {
  //create a byte that we use as a bitmask
  uint8_t mask;
  //create a mask of all 0's except for the location of the bit we want to change
  mask = 1 << (swit - 1);
  //we xor the current array of values to change just the byte in question
  snapperStates[array] = snapperStates[array] ^ mask;
  //lastly we write to our given port
  setPorts(array);
}
//
void veryLoud(uint8_t level) {
  //for each array of snapperbots
  uint8_t mask;
  mask = 255 >> (8 - level);
  for (int i = 0; i < 4; i++) {
    //change the snapper states to the proper level
    snapperStates[i] ^= mask;
  }
  //write to all the ports at once
  setPorts(4);
}
//
void loud(uint8_t snapArray, uint8_t level) {
  //change the states of the appropiate snappers
  snapperStates[snapArray] ^= (255 >> (8 - level));
  //write to all the ports
  setPorts(4);
}
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                              Serial Stuff
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void triggerEvent(int port) {
  //if we have serial data in the buffer
  if (Wire.available()) {
    //and as long as we have bytes to be read
    while (Wire.available()) {
      //parse out the data one byte at a time
      parseI2C(Wire.read());
    }
  }
}
//
void parseI2C(uint8_t data) {
  //the mode is the 2 most significant bits
  mode = (data >> 6);
  if (mode == 0) {
    flipSwitch((data & 0x30) >> 4, (1 >> (data & 0x0C)));
  }
  else if (mode == 1) {
    loud((data & 0x30) >> 4, (data & 0x0E) >> 1);
  }
  else if (mode == 2) {
    veryLoud(data & 0x38 >> 3);
  }
}

//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Test Loops
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//

void startupTest() {
  for (int t = 1; t < 9; t++) {
    for (int i = 0; i < 4; i++) {
      loud(i, t);
      delay(125);
    }
  }
  for (int i = 1; i < 9; i++) {
    veryLoud(i);
    delay(250);
  }
}

void randomFlipTest(){
  flipSwitch(random(0,4),random(0,8));
}

//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                               Main Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
//for(int i = 0; i < 25; i++){
// randomFlipTest();
//} 
//everything is evert driven so no need for anything in the loop
void loop() {
}
