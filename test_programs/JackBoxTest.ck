OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void guitarPlay(int note, int vel){
    out.start("/jackgtr");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void percPlay(int note, int vel){
    out.start("/jackperc");
    out.add(note);
    out.add(vel);
    out.send();
}
fun void bassPlay(int note, int vel){
    out.start("/jackbass");
    out.add(note);
    out.add(vel);
    out.send();
}

// Jackbox percussion test
// 0-15 is active range
for(0 => int i; i < 16; i++){
    // 1 is the small drum
    // 2 is the small cymbal
    // 3 is the med cymbal
    // 4 is the large cymbal
    // 5 is the small bongo
    // 6 is the large (loose) bongo
    // 7 is the large (tight) bongo
    // 8-15 is the xylophone (8 is highest pitch)
    <<< "glass:", i >>>;
    percPlay(i, 100); 
    0.048::second => now;
    guitarPlay(i, 0);
    //0.08::second => now;
} 

// Jackbox Guitar test
// 0-33 is active range
for(0 => int i; i < 34; i++){
    <<< "guitar:", i >>>;
    guitarPlay(i, 127); 
    0.02::second => now;
    guitarPlay(i, 0);
    //0.13::second => now;
} 

// Jackbox Bass test
// 0-23 is the active range
for(0 => int i; i < 24; i++){
    <<< "bass:", i >>>;
    bassPlay(i, 127); 
    0.033::second => now;
    bassPlay(i, 0);
    //0.2::second => now;
}    