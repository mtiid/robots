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

// marimbot test
// accepts 
while(1) {
    for(0 => int i; i < mScl.size(); i++){
        127 => int vel;
        i => int s;
        200 => int t;
        <<< "marimbot :", i, " - ", vel >>>;
        marimbotPlay(mScl[s], vel, t);    
    }
}