OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void ganaSend(int note, int vel){
    out.start("/ganapati");
    out.add(note);
    out.add(vel);
    out.send();
}

// does not need note offs but it is a good idea to
// get in the habit
fun void ganaPlay(int note, int vel, int delayMS){
    ganaSend(note, vel);
    delayMS::ms => now;
    ganaSend(note, 0);
}

// ganapai test
// accepts 0-9 (10 notes)
// currently (10/10/2016) the following are broke:
// 0, 4, 5, 9
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

