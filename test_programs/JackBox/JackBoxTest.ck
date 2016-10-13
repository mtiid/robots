OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void guitarSend(int note, int vel){
    out.start("/jackgtr");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void percSend(int note, int vel){
    out.start("/jackperc");
    out.add(note);
    out.add(vel);
    out.send();
}
fun void bassSend(int note, int vel){
    out.start("/jackbass");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void bassPlay(int note, int vel, int msDelay) {
    bassSend(note, vel);
    msDelay::ms => now;
    bassSend(note, 0);
}

fun void guitarPlay(int note, int vel, int msDelay) {
    guitarSend(note, vel);
    msDelay::ms => now;
    guitarSend(note, 0);
}

fun void percPlay(int note, int vel, int msDelay) {
    percSend(note, vel);
    msDelay::ms => now;
    percSend(note, 0);
}

fun void testXylo(int msDur, int vel) {
    for(8 => int i; i < 16; i++){
        // 8-15 is the xylophone (8 is highest pitch)
        <<< "xylo :", i, " - ", vel >>>;
        percPlay(i, vel, msDur); 
    }     
}

fun void testDrums(int msDur) {
    <<< "drums:", 1 >>>;
    for (0 => int t; t < 4; t++){
        percPlay(1, 15+t*5, msDur); 
    }
    for(5 => int i; i < 8; i++){
        for (0 => int t; t < 2; t++){ 
            <<< "drums:", i >>>;
            percPlay(i, 100+t*5, msDur);
        }     
    }
}

fun void testCymbals(int msDur, int vel) {
    for(2 => int i; i < 5; i++){
        <<< "Cymbals :", i, " - ", vel >>>;
        percPlay(i, vel, msDur); 
    }     
}

fun void testGlasses(int msDur, int vel) {
    // for some reason this does not work atm
    for(17 => int i; i < 29; i++){
        <<< "glass:", i, " - ", vel >>>;
        bassPlay(i, vel, msDur); 
    } 
}

fun void testGuitar(int msDur, int vel) {
    // Jackbox Guitar test
    // 0-33 is active range
    if (msDur == 0) {
        for(0 => int i; i < 34; i++){
            for (0 => int t; t < 4; t++) {
                Math.random2(10, 200) => int random_time;
                <<< "guitar:", i, " - ", vel >>>;
                Math.random2(0, 33) => int note;
                guitarPlay(note, 127, random_time);
            }
        }
    }
    else {
        for(0 => int i; i < 34; i++){
            for (0 => int t; t < 2; t++) {
                <<< "guitar:", i, " - ", vel >>>;
                guitarPlay(i, vel, msDur); 
            }
        }    
    }
}

// Jackbox Bass test
// 0-23 is the active range
fun void testBass(int msDur, int vel) {
    for(0 => int i; i < 24; i++){
        <<< "bass:", i, " - ", vel >>>;
        bassPlay(i, vel, msDur); 
    } 
}

fun void testAll(int msDur, int atOnce) {
    if (atOnce != 1){
        // bass
        testBass(msDur, 127);
        // guitar
        testGuitar(msDur, 127);
        // perc
        testXylo(msDur, 127);
        testCymbals(msDur, 127);
        testDrums(msDur);
        // can't find channel?
        testGlasses(msDur, 127);    
    }
    else {
        spork ~ testBass(msDur, 127);
        spork ~ testGuitar(msDur, 127);
        spork ~ testXylo(msDur, 127);
        spork ~ testCymbals(msDur, 127);
        spork ~ testDrums(msDur);      
        spork ~ testGlasses(msDur, 127);            
        msDur*26::ms => now;
    }
}

/* ----------------------- Main ------------------- */

while(true) {
    for (200 => int t; t > 10; t - 48 => t) {        
        testAll(t, 1);
    }
    for (200 => int t; t > 10; t - 48 => t) {        
        testAll(t, 0);
    }
}