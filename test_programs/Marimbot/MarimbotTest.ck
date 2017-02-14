OscOut out;
("chuckServer.local", 50000) => out.dest;

// Marimba MIDI notes
[45, 47, 48, 50, 52, 53, 54, 55, 57, 59, 
60, 62, 64, 65, 66, 67, 69, 71, 72, 74, 
76, 77, 78, 79, 81, 83, 84, 86, 88, 89, 
90, 91, 93, 95, 96] @=> int mScl[];

fun void marimbotSend(int note, int vel){
    out.start("/marimba");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void marimbotPlay(int note, int vel, int msDelay){
   marimbotSend(note, vel);
   msDelay::ms => now;
   marimbotSend(note, 0);
}

fun void shakeShake(int numTimes, int delayTime) {
    <<<"Shake baby">>>;
    for(0 => int i; i < numTimes; i++){
        marimbotPlay(mScl[Math.random2(0, mScl.size()-1)], 60, delayTime);    
    } 
}

fun void playAllNotes(int delayTime) {
    <<<"Playing all Marimbot notes">>>;
    for(0 => int i; i < mScl.size(); i++){
        i => int s;
        marimbotPlay(mScl[s], 100, delayTime);    
    }
    for(mScl.size() -1 => int i; i > -1; i--){
        i => int s;
        marimbotPlay(mScl[s], 100, delayTime);    
    }
}

while(1) {
    playAllNotes(160);
    shakeShake(1000, 20);
    3::second => now;
}