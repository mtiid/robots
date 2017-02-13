OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void ganaSend(int note, int vel){
    out.start("/mahadevi");
    out.add(note);
    out.add(vel);
    out.send();
}

// does not need note offs but it is a good idea to
// get in the habit
fun void mahaPlay(int note, int vel, int delayMS){
    ganaSend(note, vel);
    delayMS::ms => now;
    ganaSend(note, 0);
}

while (true) {
    // plays through all notes
    for (127 => int vel; vel > 0; 25 -=> vel){
        for(0 => int i; i < 12; i++){
            i => int note;
            vel => int velocity;
            Math.random2(10, 60) => int msDelay;
            <<< "ganapati : ", note, " : ", velocity >>>;
            ganaPlay(note, velocity, msDelay);
        }
    }
}

