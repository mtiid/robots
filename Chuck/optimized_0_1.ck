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
    cereal <= Math.random2(0,255);  
}

fun void flipSwitch(int bank, int swit){
    cereal <= Math.random2(0,255);  
}

fun void poundBank(int bank, int switchNum){
    cereal <= Math.random2(0,255);  
}

fun void swipeBank(int bank, float length){
    for(0 => int i; i < 8; i++){
        Math.random2(0,255);  
        length::ms => now;
    }
}




fun void serialTest(){
    cereal <= Math.random2(0,255);
}

fun void oscListener() {
    OscIn in;
    OscMsg msg;
    
    in.port(40000);
    in.listenAll();
    
    while (true) {
        in => now;
        while (in.recv(msg)) {
            <<< msg.address >>>;
            <<< msg.getInt(0) >>>;
            <<< msg.getInt(1) >>>;
        }
    }
}

fun void swipeAll(float length){
    for( 0 => int b; b < 4; b++){
        for(0 => int i; i < 8; i++){
            cereal <= "F" <= " " <= b <= "=" <= i <= "{" <= "\n";          
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
    serialTest();
    Math.random2(10,300)::ms => now;
}
