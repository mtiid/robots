// TestBreakBot.ck
// script for testing the BreakBot robot
// written by Nathan Villicana-Shaw 
// Spring 2017, MTIID

OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void drumbotSend(int note, int vel){
    out.start("/drumBot");
    out.add(note);
    out.add(vel);
    out.send();
}

// it does not need note offs, but its a good habit
// to get used to sending them
fun void drumbotPlay(int note, int vel, int delayMS){
    drumbotSend(note, vel);   
    delayMS::ms => now;
    drumbotSend(note, 0);
}

// to play each actuator once
fun void playAllNotes(int delayMS) {
    for (127 => int vel; vel > 50; vel - 10 => vel){
        for(0 => int note; note < 13; note++){
            <<< "drumbot :", note, vel >>>;
            drumbotPlay(note, vel, delayMS);    
        }
    }
}

// both 0 and 1 are different sides of the kick drum
fun void kickDemo() {
    for (127 => int vel; vel > 50; vel - 10 => vel){
        for(0 => int note; note < 2; note++){
            <<< "drumbot :", note, vel >>>;
            drumbotPlay(note, vel, 70);    
        }
    }
    for (127 => int vel; vel > 50; vel - 20 => vel){

            <<< "drumbot :", 0, vel >>>;
            drumbotPlay(0, vel, 100);    
    }
    for (127 => int vel; vel > 50; vel - 20 => vel){

            <<< "drumbot :", 1, vel >>>;
            drumbotPlay(1, vel, 50);    
    }
}

// proper brush technique
fun void smoothBrush() {
    // use many quick pulses to move brush smoothly
    // this for loop will move the brush for 2.5 seconds
    for (0 => int i; i < 250; i++){
        drumbotPlay(5, 127, 10);
    }
}

// drumbot accepts 0-12
// as of 02/10/2017 BreakBot is in the following state ...
// 0-1 - Kick, working well
// 2   - XXXXXX - Does Nothing
// 3   - Snare - missing beater - nice actuator sound
// 4   - XXXXXX - Does nothing
// 5   - Brush on Snare - use many quick pulses to move smoothly
// 6   - Ride Beater #1- Broken - Quiet Clicking Sound 
// 7   - Ride Dampener #1, out of position, makes mechanical sound
// 8   - Ride Beater #2 - Needs high velocity to actuate
// 9   - Ride Dampener #2, out of position, makes mechanical sound
// 10  - Crash Single Beater - Broken Stick - some mechanical sound on high velocitites
// 11  - Crash Double Beater #1 - works well
// 12  - Crash Double Beater #2 - works well
while (true) {
    playAllNotes(500);
}