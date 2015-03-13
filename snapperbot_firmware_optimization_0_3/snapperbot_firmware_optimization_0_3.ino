//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// Firmware for the SnapperBot
// by Nathan Villicana-Shaw
// Spring 2015
// CalArts MTIID
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

#define unit8 FLIP 0
#define unit LOUD 1
#define unit8 VERY 2

//arrays for each snapper array
static int snapper1[8] = {22, 23, 24, 25, 26, 27, 28, 29};
static int snapper2 [8] = {30, 31, 32, 33, 34, 35, 36, 37};
static int snapper3 [8] = {38, 39, 40, 41, 42, 43, 44, 45};
static int snapper4 [8] = {46, 47, 48, 49, 50, 51, 52, 53};

uint8 snappers[4];//use the registers for the chip
uint8 snapperStates[4];//the states of the snappers
uint8 incommingByte;
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Setup Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void setup() {
  Serial.begin(57600);
  for (int i = 0; i < 4; i++) {
    snappers[i] = 0xFF;
  }
}
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                        Intrument Commands
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void flipSwitch(unit8 array, unit8 swit) {
  if (array == 0) {
    PORTA = (snapperStates[array] ^ ((1 << (swit - 1)));
  }
  else if (array == 1) {
    PORTB = (snapperStates[array] ^ ((1 << (swit - 1)));
  }
  else if (array == 2) {
    PORTC = (snapperStates[array] ^ ((1 << (swit - 1)));
  }
  else if (array == 3) {
    PORTD = (snapperStates[array] ^ ((1 << (swit - 1)));
  }
}
//
void veryLoud(unit8 level) {
  for (int i = 0; i < 4; i++) {
    snapperStates[i] ^= (255 >> (8 - level));
  }
  PORTA = snapperStates[0];
  PORTB = snapperStates[1];
  PORTC = snapperStates[2];
  PORTD = snapperStates[3];
}
//
void loud(unit8 snapArray, unit8 level) {
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
    while (Serial.available() {
    incommingByte = Serial.read();
      parseSerial(incommingByte);
    }
  }
}
//
void parseSerial(uint8 data) {
  //mode is the two most significan bi
  unit8 mode = (data >> 6);
  //
  if (mode == FLIP) {
    flipSwitch((data & 0x30) >> 4, (1 >> (data & 0x0C));
  }
  else if (mode == LOUD) {
    loud((data & 0x30) >> 4, (data & 0x0E) >> 1);
  }
  else if (mode == VERY) {
    veryLoud(data & 0x70 >> 3);
  }
}
//
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                               Main Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
void loop() {
  byteListener();
}


