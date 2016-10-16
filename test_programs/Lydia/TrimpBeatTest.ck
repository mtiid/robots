OscOut out;
("chuckServer.local", 50000) => out.dest;

// Trimpbeat MIDI notes
[60, 61, 62, 63, 64, 65, 66, 67, 68, 69,
70, 71, 72, 73, 74, 75, 76, 77, 78, 79] @=> int tbScl[];

fun void tbSend(int note, int vel){
    out.start("/trimpbeat");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void tbPlay(int note, int vel, int msDelay){
    tbSend(note, vel);
    msDelay::ms => now;
    tbSend(note, 0);
}

while(true) {
    // Trimpbeat test
    // 
    for(1 => int i; i<4; i++){
        // tbPlay(60, 120, 50);
        2 => i;
        127 => int vel;
        200 => int msDelay;
        <<< "tbScl:", tbScl[i], " - ", vel >>>;
        tbPlay(tbScl[i], vel, msDelay);
    } 
}

