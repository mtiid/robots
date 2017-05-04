OscOut out;
("chuckServer.local", 50000) => out.dest;

[0, 1, 2, 3, 6, 7, 9, 10] @=> int workingNotes[];
[0, 3, 6, 7, 10] @=> int someNotes[];

1 => int numNotes;
1 => int interval;

fun void windSend(int note, int vel){
    out.start("/windbot");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void splatter() {
    for(0 => int i; i < numNotes; i++){
        someNotes[i] => int note;
        //10 => int note;
        255 => int velocity;
        <<< "blowbot: ", note, " : ", velocity >>>;
        windSend(note, velocity);    
        interval::ms => now;
        
        interval++;
        
        if (Math.randomf() < 0.1){
            1 => interval;
        }
    }
}

while (true) {
    // plays through all notes
    splatter();
    
    numNotes++;
    if (numNotes > someNotes.size() - 1){
        1 => numNotes;
    }
}
