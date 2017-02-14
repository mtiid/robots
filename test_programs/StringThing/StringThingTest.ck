// StringThing.ck

OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void stSend(int note, int vel){
    out.start("/stringthing");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void stPlay(int note, int vel, int msDelay){
    stSend(note, vel);
    msDelay::ms => now;
    stSend(note, 0);
}

fun void spinSpin() {
    for (int i; i < 25; i++){
        spork ~ stPlay(4, 15, 150);
        spork ~ stPlay(3, 15, 150);
        spork ~ stPlay(2, 15, 150);
        150::ms => now;
    }   
}
while(true) {
    
    // StringThing test
    // 0 - 1 are solenoids
    // 2 - 4 are pick spinners
    for(0 => int i; i < 5; i++){
        100 => int vel;
        1200 => int msDur;
        <<< "StringThing:", i, " - ", vel >>>;
        stPlay(i, vel, msDur);
    }
    spinSpin();
}

