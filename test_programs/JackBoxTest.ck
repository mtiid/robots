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

fun void testXylo(int msDur) {
    for(8 => int i; i < 16; i++){
        // 8-15 is the xylophone (8 is highest pitch)
        <<< "xylo :", i >>>;
        percPlay(i, 100); 
        msDur::ms => now;
        percPlay(i, 0);
    }     
}

fun void testDrums(int msDur) {
    <<< "drums:", 1 >>>;
    for (0 => int t; t < 4; t++){
        percPlay(1, 15+t*5); 
        msDur::ms => now;
        percPlay(1, 0);
    }
    for(5 => int i; i < 8; i++){
        for (0 => int t; t < 2; t++){ 
            <<< "drums:", i >>>;
            percPlay(i, 100+t*5); 
            msDur::ms => now;
            percPlay(i, 0);
        }     
    }
}

fun void testCymbals(int msDur) {
    for(2 => int i; i < 5; i++){
        <<< "Cymbals :", i >>>;
        percPlay(i, 100); 
        msDur::ms => now;
        percPlay(i, 0);
    }     
}

fun void testCymbals(int msDur) {
    for(2 => int i; i < 5; i++){
        <<< "Cymbals :", i >>>;
        percPlay(i, 100); 
        msDur::ms => now;
        percPlay(i, 0);
    }     
}

fun void testGlasses(int msDur) {
    // for some reason this does not work atm
    for(17 => int i; i < 29; i++){
        <<< "glass:", i >>>;
        bassPlay(i, 100); 
        msDur::ms => now;
        bassPlay(i, 0);
    } 
}


fun void testGuitar(int msDur) {
    // Jackbox Guitar test
    // 0-33 is active range
    if (msDur == 0) {
        for(0 => int i; i < 34; i++){
            for (0 => int t; t < 4; t++) {
                <<< "guitar:", i >>>;
                Math.random2(0, 33) => int note;
                guitarPlay(note, 127); 
                Math.random2f(0, 0.25) => float random_time;
                random_time::second => now;
                guitarPlay(note, 0);
            }
        }
    }
    else {
        for(0 => int i; i < 34; i++){
            for (0 => int t; t < 2; t++) {
                <<< "guitar:", i >>>;
                guitarPlay(i, 127); 
                msDur::ms => now;
                guitarPlay(i, 0);
            }
        }    
    }
}


// Jackbox Bass test
// 0-23 is the active range
fun void testBass(int msDur) {
    for(0 => int i; i < 24; i++){
        <<< "bass:", i >>>;
        bassPlay(i, 127); 
        msDur::ms => now;
        bassPlay(i, 0);
    } 
}

/* ----------------------- Main ------------------- */

// testBass(200);
// testPercussion(75);
// testGuitar(100);
// testXylo(200);
// testCymbals(700);
// testDrums(300);

// can't find channel?
// testGlasses(100);