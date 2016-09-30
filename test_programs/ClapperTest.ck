OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void clapperPlay(int note, int vel){
    out.start("/clappers");
    out.add(note);
    out.add(vel);
    out.send();
}

// Clapper test
for(5 => int vel; vel < 65; 1 +=> vel){
    for(0 => int i; i < 65; i++){
        <<< "clappers:", i, " - ", vel >>>;
        clapperPlay(i, vel);
        0.1::second => now;
        clapperPlay(i, 0);
        // 0.2::second => now;
    }
}
