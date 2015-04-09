SerialIO.list() @=> string list[];

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

SerialIO cereal;
cereal.open(5, SerialIO.B9600, SerialIO.BINARY);

int mbuttons[8];
int rbuttons[8];
int sbuttons[8];

int mask;
int mode;
int switNum;
int array;
int byte[3];
255 => byte[0];

int arduinoNum;

[2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0] @=> float sliders[];
[50.0,50.0,50.0,50.0,50.0,50.0,50.0,50.0] @=> float knobs[];

fun void allBanks(int arduino, int level){
    
    //<<<"All Banks : level ", level>>>;
    
    arduino => byte[1];
    128 => byte[2];
    //shift in the level into the 3-5 MSB
    (level << 3) | byte[2] => byte[2];
    //write our byte
    cereal.writeBytes(byte);
    //cereal.writeByte(byte[2]);
    //clear our byte
    <<<byte[0], byte[1], byte[2]>>>;
    0 => byte[2] => byte[1];
    255 => byte[0];
}

fun void flipSwitch(int arduino, int bank, int swit){
    
    <<<"Flip Switch : ", bank, " : ",swit>>>;
    arduino => byte[1];
    0 => mode;
    mode => byte[2];
    bank => array;
    swit => switNum;
    array << 4 => byte[2];
    swit << 1 | byte[2] => byte[2];
    cereal.writeBytes(byte);
    <<<byte[0], byte[1], byte[2]>>>;
    0 => byte[2] => byte[1];
    255 => byte[0];
}

fun void poundBank(int arduino, int bank, int switchNum){
    
    <<<"Pound Bank ", arduino, " ", bank, " ", switchNum, " switches activated">>>;    
    arduino => byte[1];
    //put mode into the 2 most significant bits (64 because mode is 1 always)
    64 => byte[2];
    //pack the bank number into the message
    //bank << 4 is what we want to pack into byte
    (bank << 4) | byte[2] => byte[2];
    //now we pack in the switch number into the 2-4 LSB
    switchNum << 1 | byte[2] => byte[2];
    cereal.writeBytes(byte);
    <<<byte[0], byte[1], byte[2]>>>;
    0 => byte[2] => byte[1];
    255 => byte[0];
}

fun void swipeBank(int arduino, int bank, float length){
    
    <<<"Swipe Bank">>>;
    for(0 => int i; i < 8; i++){
        spork ~ flipSwitch(arduino, bank, i);  
        length::ms => now;
    }
}

fun void swipeAll(int arduino, float length){
    <<<"Swipe All">>>;
    for( 0 => int b; b < 4; b++){
        for(0 => int i; i < 8; i++){
            spork ~ flipSwitch(arduino, b, i);
            (length*10)::ms => now;
        }
        (length*20)::ms => now;
    }
}

fun void playRhythm(int arduino, float rhythm[], float scaler){
    <<<"Play Rhythm">>>;
    for( 0 => int b; b < 4; b++){
        for(0 => int i; i < 8; i++){
            spork ~ flipSwitch(arduino, b, i);
            (rhythm[(i % rhythm.size())]*scaler)::ms => now;
        }
    }
}

fun void serialErrorChecker(){
    cereal.onLine() => now;
    while(1){       
        cereal.getLine() => string messageString;
        <<<messageString>>>;   
    }   
}


fun void oscListener() {
    OscIn in;
    OscMsg msg;
    
    in.port(40000);
    in.listenAll();
    
    while (true) {
        in => now;
        while (in.recv(msg)) {
            if (msg.address == "/switch") {
                poundBank(msg.getInt(0), msg.getInt(1), msg.getInt(2));
            }
        }
    }
}

fun void swipeAll(int snapperBot, float length){
    for( 0 => int b; b < 4; b++){
        for(0 => int s; s < 8; s++){
            //flipSwitch(snapperBot, b, s); 
         }
        length::ms => now;
    }
}

//spork ~ serialErrorChecker();
spork ~ oscListener();

while(true)
{
    93::ms => now;
}
