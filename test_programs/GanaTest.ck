OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void ganaPlay(int note, int vel){
    out.start("/ganapati");
    out.add(note);
    out.add(vel);
    out.send();
}

// ganapai test
// accepts 0-8
for (0 => int vel; vel < 128; 25 +=> vel){
    for(0 => int i; i < 12; i++){
        <<< "ganapati :", i >>>;
        ganaPlay(i, vel);    
        0.03::second => now;
        ganaPlay(i, 0);  
        //0.1::second => now;
    }
}   


