MidiIn min[16];

SerialIO.list() @=> string list[];

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

SerialIO cereal;
cereal.open(2, SerialIO.B57600, SerialIO.BINARY);

//dev two is usually it
int channel;
float value;
int devices;

int mbuttons[8];
int rbuttons[8];
int sbuttons[8];

int mask;
int mode;
int switNum;
int array;
int byte[2];
int arduinoNum;


[2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0] @=> float sliders[];
[50.0,50.0,50.0,50.0,50.0,50.0,50.0,50.0] @=> float knobs[];

[.45,.26, .24, .55, .12, .55, .13, .45] @=> float rhythmA[];
[.25, .24, .12, .13] @=> float rhythmB[];
[.125,.55, .55, .45] @=> float rhythmC[];

//open midi receiver, exit on fail
for( int i; i < min.cap(); i++ )
{
    // no print err
    min[i].printerr( 0 );
    
    // open the device
    if( min[i].open( i ) )
    {
        <<< "device", i, "->", min[i].name(), "->", "open: SUCCESS" >>>;
        spork ~poller( min[i], i );
        devices++;
    }
    else break;
}
// check
if( devices == 0 )
{
    <<< "um, couldn't open a single MIDI device, bailing out..." >>>;
    me.exit();
}

fun void allBanks(int arduino, int level){
    
    <<<"All Banks : level ", level>>>;
    
    arduino => byte[0];
    128 => byte[1];
    //shift in the level into the 3-5 MSB
    (level << 3) | byte[1] => byte[1];
    //write our byte
    cereal.writeBytes(byte);
    //clear our byte
    <<<byte[0], byte[1]>>>;
    0 => byte[1] => byte[0];
}

fun void flipSwitch(int arduino, int bank, int swit){
    
    <<<"Flip Switch : ", bank, " : ",swit>>>;
    
    arduino => byte[0];
    0 => mode;
    mode => byte[1];
    bank => array;
    swit => switNum;
    array << 4 => byte[1];
    swit << 1 | byte[1] => byte[1];
    cereal.writeBytes(byte);
    <<<byte[0], byte[1]>>>;
    0 => byte[1] => byte[0];
}

fun void poundBank(int arduino, int bank, int switchNum){
    
    <<<"Pound Bank ", bank, " ", switchNum, " switches activated">>>;
    
    arduino => byte[0];
    //put mode into the 2 most significant bits (64 because mode is 1 always)
    64 => byte[1];
    //pack the bank number into the message
    //bank << 4 is what we want to pack into byte
    (bank << 4) | byte[1] => byte[1];
    //now we pack in the switch number into the 2-4 LSB
    switchNum << 1 | byte[1] => byte[1];
    cereal.writeBytes(byte);
    <<<byte[0], byte[1]>>>;
    0 => byte[1] => byte[0];
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

fun void poller(MidiIn min, int id){
    
    MidiMsg msg;
    while( true )
    {
        min => now;
        while(min.recv(msg)){
            
            //pull midi channel and value
            msg.data2 => channel;
            msg.data3 => value;
            //<<<channel>>>;
            if( channel < 8){
                Std.ftoi(((value/127) * 6) + 1) => sliders[channel];
            }
            else if (channel > 15 && channel < 24){
                value*0.25 => knobs[channel - 16];   
            }
            else if(channel > 31 && channel < 40 && value == 127){
                spork ~flipSwitch(arduinoNum, (channel - 32)%4, Std.ftoi(sliders[(channel -32)])); 
            }
            else if(channel  > 47 && channel < 56 && value == 127){
                spork ~poundBank(arduinoNum, (channel - 48)%4, Std.ftoi(sliders[(channel - 48)]));
            }
            else if (channel > 63 && channel < 72 && value == 127){
                spork ~allBanks(arduinoNum, channel-63);   
            }           
            else if(channel > 40 && channel < 45 && value == 127){
                spork ~swipeBank(arduinoNum, channel - 41, knobs[channel - 41]);   
            }
            else if (channel > 59 && channel < 63 && value == 127){
                spork ~swipeAll(arduinoNum, knobs[0]*(channel - 59));
            }
            
            else if (channel == 46){
                //spork ~playRhythm(rhythmA,knobs[7]);
                0 => arduinoNum;
                <<<"Arduino output number changed to ", arduinoNum>>>;
            }
            else if (channel == 58){
                1 => arduinoNum;
                <<<"Arduino output number changed to ", arduinoNum>>>;
                
                //spork ~playRhythm(rhythmB,knobs[7]);
            }
            else if (channel == 59){
                //spork ~playRhythm(rhythmC,knobs[7]);
            }
            
        }
    }
}

while(true)
{
    Math.random2(10,300)::ms => now;
}
