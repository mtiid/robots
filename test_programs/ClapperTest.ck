OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void clapperPlay(int note, int vel){
    out.start("/clappers");
    out.add(note);
    out.add(vel);
    out.send();
}

// Clapper test
for(3 => int vel; vel < 15; 1 +=> vel){
    for(0 => int i; i < 20; i++){
        <<< "clappers:", i, " - ", vel >>>;
        clapperPlay(i, vel);
        0.01::second => now;
        clapperPlay(i, 0);
        // 0.2::second => now;
    }
}