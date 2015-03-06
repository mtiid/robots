MidiIn korg;
MidiMsg msg;

//dev two is usually it
int channel;
int value;
2 => int device;

//open midi receiver, exit on fail
if( !korg.open(0)){
 <<<"Problem connecting to MIDI device">>>;   
}
//function for shred

SerialIO.list() @=> string list[];

SerialIO serial;
serial.open(device, SerialIO.B57600, SerialIO.ASCII);

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

if(me.args()) me.arg(0) => Std.atoi => device;//what do you do?

fun void sendSerial(int number){
    serial.onInts(number) => now;
    serial.getInts() @=> int ints[];
    chout <= "ints: ";
    for(int i; i < ints.cap(); i++)
    {
        chout <= ints[i] <= " ";
    }
    
    chout <= IO.newline();   
}

while(1){
    korg => now;   
    while(korg.recv(msg)){
        //<<<msg.data1, msg.data2, msg.data3>>>;
        msg.data2 => channel;
        msg.data3 => value;
        /*
        if(channel > 32 && channel < 36 && value == 127){
            //send swipe message to arduino
            //send(swipe, channel - 32); 
            sendSerial(channel - 32);
            <<<"Serial Message Sent To Arduino">>>;
        }
        */
    }
    
}   
