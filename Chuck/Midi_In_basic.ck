MidiIn korg;
MidiMsg msg;
//open midi receiver, exit on fail
if( !korg.open(0) ){
 <<<"Problem connecting to MIDI device">>>;   
}
//function for shred

while(1){
    korg => now;
    
    while(korg.recv(msg)){
        <<<msg.data1, msg.data2, msg.data3>>>;
    }
    
}   
