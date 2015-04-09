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

int mode;
int switNum;
int array;
int byte[1];

[2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0] @=> float sliders[];
[50.0,50.0,50.0,50.0,50.0,50.0,50.0,50.0] @=> float knobs[];

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

fun void allBanks(int level){
    <<<"All Banks : level ", level>>>;
    0 => byte[0];
    2 => mode;
    level => switNum;
    mode << 6 => byte[0];
    (switNum << 3) | byte[0] => byte[0];
    cereal.writeBytes(byte);
    0 => byte[0];
}

fun void flipSwitch(int bank, int swit){
    <<<"Flip Switch : ", bank, " : ",swit>>>;
    0 => mode;
    mode => byte[0];
    bank => array;
    swit => switNum;
    array << 4 => byte[0];
    swit << 1 | byte[0] => byte[0];
    cereal.writeBytes(byte);
    <<<byte[0]>>>;
    0 => byte[0];
    }

fun void poundBank(int bank, int switchNum){
    <<<"Pound Bank ", bank, " ", switchNum, " switches activated">>>;
    1 => mode;
    mode << 6 => byte[0];
    switchNum << 1 | byte[0] => byte[0];
    cereal.writeBytes(byte);
    <<<byte[0]>>>;
    0 => byte[0];
}

fun void swipeBank(int bank, float length){
    <<<"Swipe Bank">>>;
    for(0 => int i; i < 8; i++){
       //Math.random2(0,255);  
        length::ms => now;
    }
}

fun void swipeAll(float length){
    <<<"Swipe All">>>;
    for( 0 => int b; b < 4; b++){
        for(0 => int i; i < 8; i++){
            cereal;          
        }
        length::ms => now;
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
            
            if( channel < 8){
                Std.ftoi(((value/127) * 7) + 1) => sliders[channel];
            }
            else if (channel > 15 && channel < 24){
                value*0.25 => knobs[channel - 16];   
            }
            else if(channel > 31 && channel < 40 && value == 127){
                spork ~flipSwitch((channel - 32)%4, Std.ftoi(sliders[(channel -32)])); 
            }
            else if(channel  > 47 && channel < 56 && value == 127){
                spork ~poundBank((channel - 48)%4, Std.ftoi(sliders[(channel - 48)]));
            }
            else if (channel > 63 && channel < 72 && value == 127){
                spork ~allBanks(channel-63);   
            }           
            else if(channel > 40 && channel < 45 && value == 127){
                spork ~swipeBank(channel - 41, knobs[channel - 41]);   
            }
            else if (channel > 59 && channel < 63 && value == 127){
                spork ~swipeAll(knobs[0]*(channel - 59));
            }
            
        }
    }
}

while(true)
{
Math.random2(10,300)::ms => now;
}
