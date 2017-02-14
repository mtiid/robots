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

fun void splatter() {
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

// ganapai test
// accepts 0-9 (10 notes)
// currently (02/10/2017) it is in the following state
// 0  - Does Nothing
// 1  - Bottom right - bottom beater
// 2  - Bottom left  - bottom beater  - higher
// 3  - Bottom left  - top beater     - low
// 4  - Does Nothing
// 5  - Does Nothing
// 6  - Middle Left  - left beater    - lower
// 7  - Middle Left  - top beater     - lowest
// 8  - Middle Left  - bottom beater  - high
// 9  - Does Nothing
while (true) {
    // plays through all notes
    splatter();
}

