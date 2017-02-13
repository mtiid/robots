MidiOut mout;
MidiMsg msg;

mout.open("IAC Driver IAC Bus 2");
0x93=>msg.data1;
62 => msg.data2;
100 => msg.data3;
mout.send(msg);

while(1.6*Math.random2f(0.9,1.1)::hour => now){
    Math.random2(0,19) => msg.data2;
    mout.send(msg);
}