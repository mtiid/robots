// Firmware for the SnapperBot
// by Nathan Villicana-Shaw
// Spring 2015 
// CalArts MTIID

//arrays for each snapper array
static int snapper1[8] = {
  22,24,26,28,30,32,34,36
};
static int snapper2 [8] = {
  38,40,42,44,46,48,50,52 
};
static int snapper3 [8] = {
  23,25,27,29,31,33,35,37 
};
static int snapper4 [8] = {
  39,41,43,45,47,49,51,53 
};
//need to turn into bytes
//to keep track of button states
boolean snapper1State[8] = {
  1, 1, 1, 1, 1, 1, 1, 1
};

//byte snapper1State = 255;
//byte snapper2State;
//byte snapper3State;
//byte snapper4State;

boolean snapper2State[8] = {
  1, 1, 1, 1, 1, 1, 1, 1
};
boolean snapper3State[8] = {
  1, 1, 1, 1, 1, 1, 1, 1
};
boolean snapper4State[8] = {
  1, 1, 1, 1, 1, 1, 1, 1
};

void setup(){
  Serial.begin(9600);
  for(int i = 0; i < 8; i++){
    pinMode(snapper1[i], OUTPUT);
    digitalWrite(snapper1[i], HIGH);
    pinMode(snapper2[i], OUTPUT);
    digitalWrite(snapper2[i], HIGH);
    pinMode(snapper3[i], OUTPUT);
    digitalWrite(snapper3[i], HIGH);
    pinMode(snapper4[i], OUTPUT);
    digitalWrite(snapper4[i], HIGH);  
  } 
}
//flip one specific switch, pass in the snapper number and the nummber of a switch on the snapper
void flip(int snapArray, int switchNum){
  if(switchNum > 7){
    //Serial.print("Error : switchNum out of bounds, setting to 7 for you");
    switchNum = 7; 
  }
  if (snapArray == 0){
    snapper1State[switchNum] = !snapper1State[switchNum];
    digitalWrite(snapper1[switchNum], snapper1State[switchNum]); 
  }
  else if (snapArray == 1){
    snapper2State[switchNum] = !snapper2State[switchNum];
    digitalWrite(snapper2[switchNum], snapper2State[switchNum]); 
  }
  else if (snapArray == 2){
    snapper3State[switchNum] = !snapper3State[switchNum];
    digitalWrite(snapper3[switchNum], snapper3State[switchNum]); 
  }
  else if (snapArray == 3){
    snapper4State[switchNum] = !snapper4State[switchNum];
    digitalWrite(snapper4[switchNum], snapper4State[switchNum]); 
  }
}
/*
// Depreciated code in chuck now
//use swipe for really fast attacks
void swipe(int snapArray, int time){

  if (snapArray == 0){
    for(int i = 0; i < 8; i++){
      snapper1State[i] = !snapper1State[i];
      digitalWrite(snapper1[i], snapper1State[i]);
      delay(time);
    }
  } 
  else if (snapArray == 1){
    for(int i = 0; i < 8; i++){
      snapper2State[i] = !snapper2State[i];
      digitalWrite(snapper2[i], snapper2State[i]);
      delay(time);
    }
  } 
  else if (snapArray == 2){
    for(int i = 0; i < 8; i++){
      snapper3State[i] = !snapper3State[i];
      digitalWrite(snapper3[i], snapper3State[i]);
      delay(time);
    }
  } 
  else if (snapArray == 3){
    for(int i = 0; i < 8; i++){
      snapper4State[i] = !snapper4State[i];
      digitalWrite(snapper4[i], snapper4State[i]);
      delay(time);
    }
  }
}
*/
void veryLoud(int level){
  if(level > 8){
    level = 8;
    //Serial.print("Max Level is 8, but thats cool, i'll set it to 8 for you"); 
  }
  for(int i = 0; i < level; i++){
    snapper1State[i] = !snapper1State[i];
    snapper2State[i] = !snapper2State[i];
    snapper3State[i] = !snapper3State[i];
    snapper4State[i] = !snapper4State[i];
    digitalWrite(snapper1[i], snapper1State[i]);
    digitalWrite(snapper2[i], snapper2State[i]);
    digitalWrite(snapper3[i], snapper3State[i]);
    digitalWrite(snapper4[i], snapper4State[i]);
  }
}

void loud(int snapArray, int level){
  
  if(level > 8){
    level = 8; 
    //Serial.print("Max Level is 8 but thats cool, i'll set it to 8 for you"); 
  }
  if (snapArray == 0){
    for(int i = 0; i < level; i++){
      snapper1State[i] = !snapper1State[i];
      digitalWrite(snapper1[i], snapper1State[i]);
    }
  }
  else if (snapArray == 1){
    for(int i = 0; i < level; i++){
      snapper2State[i] = !snapper2State[i];
      digitalWrite(snapper2[i], snapper2State[i]);
    }
  }
  else if (snapArray == 2){
    for(int i = 0; i < level; i++){
      snapper3State[i] = !snapper3State[i];
      digitalWrite(snapper3[i], snapper3State[i]);
    }
  }
  else if (snapArray == 3){
    for(int i = 0; i < level; i++){
      snapper4State[i] = !snapper4State[i];
      digitalWrite(snapper4[i], snapper4State[i]);
    }
  }
}
//byte command;
int data[3];
char bytes[4];

String command;//contains string data we are pulling from serial buffer

void betterTest(){

  if(Serial.available()){//Serial.available returns the number of bytes stored in the serial buffer

    while(Serial.available()){

      char c = Serial.read();//pulls in the first byte in the serial buffer and pushes other data up

      if(c == '\n'){//single quotes for char's double quotes for strings
        parseCommand(command);//parse out our string
        command = ""; 
      }
      else{
        command += c;
      }
    } 
  }
}

void parseCommand(String com){

  String mode;
  String val1;
  String val2;
  int iVal1;
  int iVal2;

  mode = com.substring(0, com.indexOf(" "));//0 is begenning com.index is end
  val1 = com.substring(com.indexOf(" ") + 1, com.indexOf("="));//0 is begenning com.index is end
  val2 = com.substring(com.indexOf("=") + 1, com.indexOf("{"));//0 is begenning com.index is end

  if(mode.equalsIgnoreCase("F")){
    iVal1 = val1.toInt();
    iVal2 = val2.toInt();
    flip(iVal1, iVal2); 
  }
  else if(mode.equalsIgnoreCase("L")){
    iVal1 = val1.toInt();
    iVal2 = val2.toInt();
    loud(iVal1, iVal2); 
  }
  else if(mode.equalsIgnoreCase("V")){
    iVal1 = val1.toInt();
    iVal2 = val2.toInt();
    veryLoud(iVal1); 
  }
}

//composition loop
void loop(){
  betterTest();
}








