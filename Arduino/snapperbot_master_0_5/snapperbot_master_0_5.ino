//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// Firmware for the SnapperBot
// by Nathan Villicana-Shaw
// Spring 2015
// CalArts MTIID
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

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
//for communicatoin
#include <Wire.h>
// PORTA, PORTB, PORTC, PORTL
static int snapper1[8] = {22, 23, 24, 25, 26, 27, 28, 29};
static int snapper2[8] = {10, 11, 12, 13, 50, 51, 52, 53};
static int snapper3[8] = {30, 31, 32, 33, 34, 35, 36, 37};
static int snapper4[8] = {42, 43, 44, 45, 46, 47, 48, 49};
//the states of the snappers
uint8_t snapperStates[4];
//the incomming messages
uint8_t dataByte;
//for parsing serial
uint8_t mode;
uint8_t botNum;
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                              i2c functions
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void sendI2C(uint8_t _botNum, uint8_t _dataByte) {
  //start i2c message to slavebot _botNum
  Wire.beginTransmission(_botNum);
  //write byte to slavebot
  Wire.write(_dataByte);
  //close i2c message, if we wanted to send more info we would add another Wire.write
  Wire.endTransmission();
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
//
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
void byteListener() {
  //if we have serial data in the buffer
  if (Serial.available()) {
    //read the first byte
    uint8_t flag = Serial.read();
    //if it is equal to our flag value
    if (flag = 255) {
      //read the second byte, which is the bot number
      botNum = Serial.read();
      //read the second byte, which is the actual message byte
      dataByte = Serial.read();
      //get rid of any remaining data in buffer, dirty way to keep things clean
      Serial.flush();
      //un comment following lines for troubleshooting
      //Serial.print("Bot Num : ");
      //Serial.print(botNum);
      //Serial.print("Data Byte : ");
      //Serial.println(dataByte);
      parseSerial(botNum, dataByte);
    }
    else {
      //if the first byte is not equal to our flag value flush data in buffer
      Serial.flush();
    }
  }
}
//
void parseSerial(uint8_t botNum, uint8_t data) {
  //the masterbot is bot 0
  if (botNum == 0) {
    //the mode is the 2 most significant bits
    //shift those bits over 6 spaces and we have the mode
    mode = (data >> 6);
    //flip one switch is mode is = 0
    if (mode == 0) {
      //apply bitmasks and shift over the bits we are interested in and pass them into flipSwitch
      flipSwitch((data & 0x30) >> 4, (1 >> (data & 0x0C)));
    }
    else if (mode == 1) {
      //apply bitmasks and shift over the bits we are interested in and pass them into loud
      loud((data & 0x30) >> 4, (data & 0x0E) >> 1);
    }
    else if (mode == 2) {
      //apply bitmasks and shift over the bits we are interested in and pass them into veryLoud
      veryLoud(data & 0x38 >> 3);
    }
  }
  //if message is for a slaveBot pass it on to the corrisponding slave
  else {
    sendI2C(botNum, data);
  }
}
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Test Loops
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//

//to make sure all relays are working
void startupTest() {
  for (int t = 1; t < 9; t++) {
    for (int i = 0; i < 4; i++) {
      loud(i, t);
      delay(30);
    }
  }
  for (int i = 1; i < 9; i++) {
    veryLoud(i);
    delay(62);
  }
}
//flip a random switch on a random array
void randomFlipTest() {
  flipSwitch(random(0, 4), random(0, 8));
}
//send random messages to salvebots to test iic
void testiic() {
  for (uint8_t i = 1; i < 6; i++) {
    for (uint8_t t = 0; t < 255; t++) {
      sendI2C(i, t);
      delay(4);
    }
  }
}
//test a specific slavebot
void testBot(int botNum, int time) {
  for (int i = 0; i < 255; i++) {
    sendI2C(botNum, i);
    delay(time);
  }
}
//test a specific switch on a slavebot
void testSwitch(int botNum, int switchNum) {
  sendI2C(botNum, switchNum);
}
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Setup Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void setup() {

  Serial.begin(9600);
  //open i2c port
  Wire.begin();//no address given, which designates this bot as master device on iic bus
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
  testiic();
}
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                               Main Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//

//keep it clean baby!
void loop() {
  byteListener();
}
