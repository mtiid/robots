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



//why was i able to #define them this way? is it just for readability?
#define setLow(in_byte, pos_bit) ((in_byte) &= ~(1 << (pos_bit)))
#define setHigh(in_byte, pos_bit) ((in_byte) |= (1 << (pos_bit)))

/*

Serial for snappers :
  bit 0-1 : message type
    0 = flip
    1 = loud
    2 = veryLoud
*/
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                             Setup Loop
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

void setup() {
  Serial.begin(57600);
  for (int i = 0; i < 4; i++) {
    snappers[i] = 0xFF;
  }
}

//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                        bitmask creating functions
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


//flip one specific switch, pass in the snapper number and the nummber of a switch on the snapper
void flipSwitch(unit8 array, unit8 swit) {
  if (array == 0) {
    PORTA = (snapperStates[array] & ((swit - 1) << 1));
  }
  else if (array == 1) {
    PORTB = (snapperStates[array] & ((swit - 1) << 1));
  }
  else if (array == 2) {
    PORTC = (snapperStates[array] & ((swit - 1) << 1));
  }
  else if (array == 3) {
    PORTD = (snapperStates[array] & ((swit - 1) << 1));
  }
}
//
void veryLoud(int level) {
  for ( int i = 0; i < 4; i++) {
    snapperStates[i] ~ = snapperStates[i];
  }

  PORTA = snapperStates[0];
  PORTB = snapperStates[1];
  PORTC = snapperStates[2];
  PORTD = snapperStates[3];
}

if (snapArray == 0) {
  snappers[0] ~ = snappers[0];
  PORTA = snappers[0];

}
//is there an more efficient way to do this?

void loud(unit8 snapArray, unit8 level) {

  //turn level into a bitmask
  if (snapArray == 0) {
    PORTA = bitMask(unit level);
  }
  else if (snapArray == 1) {
    PORTB =
  }
  else if (snapArray == 2) {
    PORTC =
  }
  else if (snapArray == 3) {
    PORTD =
  }
}
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
  //bit shift over
  unit8 mode;
  unit8 level;
  unit8 swit;
  unit8 array;
  //mode is equal to the two most significant bits
  mode = (5 >> (data));

  if (mode == FLIP) {
    //because the two MFB are 0 (mode is 0) we can just shift everything over to the right by three
    array = (4 >> data);
    swit = (1 >> (data & 0xC));
    flipSwitch(array, swit);
  }
  else if (mode == LOUD) {
    //loud
    //array = next two bits
    //level = next three bits
  }
  else if (mode == VERY) {
    //veryloud
    //level = next three bits
  }
}
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//composition loop
void loop() {
  byteListener();
}








