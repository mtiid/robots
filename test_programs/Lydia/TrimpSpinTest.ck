OscOut out;
("chuckServer.local", 50000) => out.dest;

// Trimpspin MIDI notes
[60,61,62,63,64,65,66,67,68,69,
70,71,72,73,74,75,76,77,78,79] @=> int tsScl[];

fun void tsSend(int note, int vel){
    out.start("/trimpspin");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void tsPlay(int note, int vel, int msDelay){
    tsSend(note, vel);
    msDelay::ms => now;
    tsSend(note, 0);
}

while(true) {
    // Trimpspin test
    for(0 => int i; i<tsScl.size(); i++){
        // note 60 is the "beater"
        //tbPlay(60, 50, 10);
        100 => int vel;
        <<< "tscScl:", tsScl[i], " - ", vel >>>;
        spork ~ tsPlay(tsScl[i], vel, 1000);
        200::ms => now;
    }
   }

