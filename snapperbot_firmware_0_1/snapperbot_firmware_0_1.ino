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
  0, 0, 0, 0, 0, 0, 0, 0
};
boolean snapper2State[8] = {
  0, 0, 0, 0, 0, 0, 0, 0
};
boolean snapper3State[8] = {
  0, 0, 0, 0, 0, 0, 0, 0
};
boolean snapper4State[8] = {
  0, 0, 0, 0, 0, 0, 0, 0
};

void setup(){
  Serial.begin(9600);
  for(int i = 0; i < 8; i++){
    pinMode(snapper1[i], OUTPUT);
    digitalWrite(snapper1[i], LOW);
    pinMode(snapper2[i], OUTPUT);
    digitalWrite(snapper2[i], LOW);
    pinMode(snapper3[i], OUTPUT);
    digitalWrite(snapper3[i], LOW);
    pinMode(snapper4[i], OUTPUT);
    digitalWrite(snapper4[i], LOW);  
  } 
}


//functions for controling the bot

void flip(int snapArray, int switchNum){
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

void loud(int snapArray, int level){
  if(level > 8){
    level = 8; 
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


void loop(){
  flip(random(0,2),random(0,7));
  delay(500);
  swipe(random(0,2), random(10,150));
  delay(500);
  for(int t = 100; t > 2; t = t - random(-2,3)){
  for(int i = 0; i < 10; i++){
    loud(random(0,2), i);
    delay(t);
  }
  }
}









