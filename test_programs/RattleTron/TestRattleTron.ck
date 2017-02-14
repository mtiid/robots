// TestRattleTron.ck
// script for testing the BreakBot robot
// written by Nathan Villicana-Shaw 
// Spring 2017, MTIID

OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void rtronSend(int note, int vel){
    out.start("/rattletron");
    out.add(note);
    out.add(vel);
    out.send();
}

// it does not need note offs, but its a good habit
// to get used to sending them
fun void rtronPlay(int note, int vel, int delayMS){
    rtronSend(note, vel);   
    delayMS::ms => now;
    rtronSend(note, 0);
}

// to play each actuator once
fun void playAllNotes(int delayMS) {
    for (1023 => int vel; vel > 50; vel - 10 => vel){
        for(0 => int note; note < 5; note++){
            <<< "RattleTron :", note, vel >>>;
            rtronPlay(note, vel, delayMS);    
        }
    }
}

// rattletron accepts 0-12
// as of 02/10/2017 rattletron is in the following state ...
// 0   - Small Tube
// 1   - Right Tube (on tube side)
// 2   - Left Tube (on tube side)
// 3   - Tamb Shaker
// 4   - Steel Shaker
while (true) {
    playAllNotes(500);
}