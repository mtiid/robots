OscOut out;
("chuckServer.local", 50000) => out.dest;

[0, 1, 2, 3, 6, 7, 9, 10] @=> int workingNotes[];

fun void windSend(int note, int vel){
    out.start("/windbot");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void splatter() {
    for (127 => int vel; vel > 0; 25 -=> vel){
        for(0 => int i; i < workingNotes.size(); i++){
            workingNotes[i] => int note;
            200 => int velocity;
            Math.random2(250, 500) => int msDelay;
            <<< "blowbot: ", note, " : ", velocity >>>;
            windSend(note, velocity);    
            msDelay::ms => now;
        }
    }      
}

while (true) {
    // plays through all notes
    splatter();
}

