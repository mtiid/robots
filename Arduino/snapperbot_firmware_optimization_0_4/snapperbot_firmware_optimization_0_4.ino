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
//
static int snapper1[8] = {22, 23, 24, 25, 26, 27, 28, 29};
static int snapper2 [8] = {30, 31, 32, 33, 34, 35, 36, 37};
static int snapper3 [8] = {38, 39, 40, 41, 42, 43, 44, 45};
static int snapper4 [8] = {46, 47, 48, 49, 50, 51, 52, 53};
//
uint8_t snapperStates[4];//the states of the snappers
//the incomming messages
uint8_t incommingByte;
//for parsing serial
uint8_t mode;
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
    PORTD = snapperStates[3];
  }
  else if (which == 4) {
    PORTA = snapperStates[0];
    PORTB = snapperStates[1];
    PORTC = snapperStates[2];
    PORTD = snapperStates[3];
  }
}

void flipSwitch(uint8_t array, uint8_t swit) {
  if (array == 0) {
    PORTA = (snapperStates[array] ^ ((1 << (swit - 1))));
  }
  else if (array == 1) {
    PORTB = (snapperStates[array] ^ ((1 << (swit - 1))));
  }
  else if (array == 2) {
    PORTC = (snapperStates[array] ^ ((1 << (swit - 1))));
  }
  else if (array == 3) {
    PORTD = (snapperStates[array] ^ ((1 << (swit - 1))));
  }
}
//
void veryLoud(uint8_t level) {
  for (int i = 0; i < 4; i++) {
    snapperStates[i] ^= (255 >> (8 - level));
  }
}
//
void loud(uint8_t snapArray, uint8_t level) {
  snapperStates[snapArray] ^= (255 >> (8 - level));
  //turn level into a bitmask
  if (snapArray == 0) {
    PORTA = snapperStates[0];
  }
  else if (snapArray == 1) {
    PORTB = snapperStates[1];
  }
  else if (snapArray == 2) {
    PORTC = snapperStates[2];
  }
  else if (snapArray == 3) {
    PORTD = snapperStates[3];
  }
}
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                              Serial Stuff
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void byteListener() {
  if (Serial.available()) {
    while (Serial.available()) {
      //incommingByte = Serial.read();
        parseSerial(Serial.read());
    }
  }
}
//
void parseSerial(uint8_t data) {
  mode = (data >> 6);
  //
  Serial.println(mode);
  if (mode == 0) {
    flipSwitch((data & 0x30) >> 4, (1 >> (data & 0x0C)));
  }
  else if (mode == 1) {
    loud((data & 0x30) >> 4, (data & 0x0E) >> 1);
  }
  else if (mode == 2) {
    veryLoud(data & 0x70 >> 3);
  }
}
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Setup Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void setup() {
  Serial.begin(57600);
  for (int i = 0; i < 8; i++) {
    pinMode(snapper1[i], OUTPUT);
    pinMode(snapper2[i], OUTPUT);
    pinMode(snapper3[i], OUTPUT);
    pinMode(snapper4[i], OUTPUT);
  }
  for (int i = 0; i < 4; i++) {
    snapperStates[i] = 0xFF;
  }
  setPorts(4);
}
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                               Main Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void loop() {
  byteListener();
}
