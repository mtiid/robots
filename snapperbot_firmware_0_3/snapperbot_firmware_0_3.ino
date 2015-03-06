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
//to keep track of button states
boolean snapper1State[8] = {
  1, 1, 1, 1, 1, 1, 1, 1
};
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
  pinMode(13, OUTPUT);
  Serial.begin(57600);
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
  else{
    //Serial.print("Sorry we do not have that many snappers, give me 0-3"); 
  }
}
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
  else{
    //Serial.print("Sorry we do not have that many snappers, give me 0-3"); 
  } 
}

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
  else{
    //Serial.print("Sorry we do not have that many snappers, give me 0-3"); 
  }
}
//byte command;
int data[3];
char bytes[4];

void receiveBytes(){
  //reads four element array from chuck
  Serial.readBytes(bytes, 4);
  //command = byte(bytes[0]);
  //flip
  //command = Serial.parseInt();
  //data[0] = Serial.parseInt();
  //data[1] = Serial.parseInt();
  //data[2] = Serial.parseInt();
  checkCommand((int)bytes[0]);
}

void checkCommand(int command){
  if (command == 0){
    digitalWrite(13, HIGH); 
    flip(1,5);
  }
  //swipe
  else if(command == 1){
    digitalWrite(13, HIGH);
    swipe(2, 50);  
  }
  //loud
  else if(command == 2){
    digitalWrite(13, HIGH); 
    loud(3,6);
  }
  //very loud
  else if(command == 3){
    digitalWrite(13, HIGH);
    veryLoud(6); 
  }
  //any message at all
  else if (command > 0){
    //digitalWrite(13, HIGH); 
  }
}
byte readByte;

void test(){
  int arrayNum;
  int switchNum;
  int time;
  int level;
  int command;
  
  if(Serial.available()){
    command = Serial.read();
    readByte= (char)command;
    //single switch
    if (readByte == 'F'){
     arrayNum = Serial.parseInt();
      switchNum = Serial.parseInt();
      flip(arrayNum,switchNum);
    }
    //swipe
    else if(readByte == 'S'){
      arrayNum = Serial.parseInt();
      time = Serial.parseInt();
      swipe(arrayNum, time);  
  }
    //loud
    else if(readByte == 'L'){
      arrayNum = Serial.parseInt();
      level = Serial.parseInt();
      loud(arrayNum,level);
    }
    //very loud
    else if(readByte == 'V'){
      level = Serial.parseInt();
      veryLoud(level); 
    }
    
  }
}
//composition loop
void loop(){
  test();
}





