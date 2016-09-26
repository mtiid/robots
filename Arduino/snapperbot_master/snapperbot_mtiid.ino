//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// Firmware for the SnapperBot
// by Nathan Villicana-Shaw
// Spring 2015
// CalArts MTIID
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

// snapperbot ID's are between 3 and 9
#define arduinoID 3

// supports uint8_t and uint16_t
#include <stdint.h>
// Definition of interrupt names
#include <avr/interrupt.h>
// ISR interrupt service routine
#include <avr/io.h>
//for better readability
#define unit8_t FLIP 0
#define unit8_t LOUD 1
#define unit8_t VERY 2

// PORTA, PORTB, PORTC, PORTL
static int snapper1[8] = {22, 23, 24, 25, 26, 27, 28, 29};
static int snapper2[8] = {10, 11, 12, 13, 50, 51, 52, 53};
static int snapper3[8] = {30, 31, 32, 33, 34, 35, 36, 37};
static int snapper4[8] = {42, 43, 44, 45, 46, 47, 48, 49};

//the states of the snappers
uint8_t snapperStates[4];
//the incomming messages
byte dataBytes[3];
//for parsing serial
uint8_t mode;
uint8_t botNum;

// For working with the robots server
char bytes[2];
int handshake 0

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
//
void flipSwitch(uint8_t array, uint8_t swit) {
  // TODO make it search for on bits to turn off first
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

void serialListener() {
    if (Serial.available()) {
        if (Serial.read() == 0xff) {
            Serial.readBytes(bytes, 2);
            if (bytes[0] == 0xff && bytes[1] == 0xff && handshake == 0) {
                    Serial.write(arduinoID)
                    handshake = 1;
                }
            }
            else {
                loud(bytes[0], bytes[1])
            }
        }
    }
}
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Test Loops
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
//flip a random switch on a random array
void randomFlipTest() {
  flipSwitch(random(0, 4), random(0, 8));
}
//send random messages to salvebots to test iic
void startupTest() {
  for (int t = 1; t < 9; t++) {
    for (int i = 0; i < 4; i++) {
      loud(i, t);
      delay(13);
    }
  }
  for (int i = 1; i < 9; i++) {
    veryLoud(i);
    delay(27);
  }
}

//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Setup Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void setup() {

  Serial.begin(57600);
  //set all pins as output pins
  for (int i = 0; i < 8; i++) {
    pinMode(snapper1[i], OUTPUT);
    pinMode(snapper2[i], OUTPUT);
    pinMode(snapper3[i], OUTPUT);
    pinMode(snapper4[i], OUTPUT);
  }

  //set them all to high (which is off for the switches)
  for (int i = 0; i < 4; i++) {
    snapperStates[i] = 0xFF;
  }

  //write to all the ports at the same time
  setPorts(4);
  startupTest();
}
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                               Main Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//

//keep it clean baby!
void loop() {
  serialListener();
}
