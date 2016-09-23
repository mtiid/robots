OscOut out;
("chuckServer.local", 50000) => out.dest;

// Trimpspin MIDI notes
[60,61,62,63,64,65,66,67,68,69,
70,71,72,73,74,75,76,77,78,79] @=> int tsScl[];

fun void tsPlay(int note, int vel){
	out.start("/trimpspin");
    out.add(note);
    out.add(vel);
    out.send();
}

// Trimpbeat MIDI notes
[60,61,62,63,64,65,66,67,68,
69,70,71,72,73,74,75,76,77,78,79] @=> int tbScl[];

fun void tbPlay(int note, int vel){
	out.start("/trimpbeat");
    out.add(note);
    out.add(vel);
    out.send();
}

// Marimba MIDI notes
[45, 47, 48, 50, 52, 53, 54, 55, 57, 59, 
 60, 62, 64, 65, 66, 67, 69, 71, 72, 74, 
 76, 77, 78, 79, 81, 83, 84, 86, 88, 89, 
 90, 91, 93, 95, 96] @=> int mScl[];

fun void clapperPlay(int note, int vel){
    out.start("/clappers");
    out.add(note);
    out.add(vel);
    out.send();
}

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

fun void ganaPlay(int note, int vel){
    out.start("/ganapati");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void deviPlay(int note, int vel){
    out.start("/devibot");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void drumbotPlay(int note, int vel){
    out.start("/drumBot");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void marimbotPlay(int note, int vel){
    out.start("/marimba");
    out.add(note);
    out.add(vel);
    out.send();
}

while(true) {
    
	// Trimpspin test
	for(0 => int i; i<tsScl.size(); i++){
	    <<< "tscScl:", tsScl[i] >>>;
	    tsPlay(tsScl[i], 100);
        //tsPlay(tsScl[3], 100);
        .12::second => now;
        tsPlay(tsScl[i], 0);
        //tsPlay(tsScl[3], 0);
        //0.1::second => now;
     }
     
     // Clapper test
     for(0 => int i; i<20; i++){
         <<< "clappers:", tbScl[i] >>>;
         clapperPlay(i, 127);
         0.1::second => now;
         clapperPlay(i, 0);
         // 0.2::second => now;
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
         0.08::second => now;
         guitarPlay(i, 0);
         0.08::second => now;
     } 
     
     // Jackbox Guitar test
     // 0-33 is active range
     for(0 => int i; i < 34; i++){
         <<< "guitar:", i >>>;
         guitarPlay(i, 127); 
         0.1::second => now;
         guitarPlay(i, 0);
         //0.13::second => now;
    } 
    
    // Jackbox Bass test
    // 0-23 is the active range
    for(0 => int i; i < 24; i++){
        <<< "bass:", i >>>;
        bassPlay(i, 127); 
        0.13::second => now;
        bassPlay(i, 0);
        //0.2::second => now;
    }     
    
	// Trimpbeat test
	for(0 => int i; i<tbScl.size(); i++){
		<<< "tbScl:", tbScl[i] >>>;
	    tbPlay(tbScl[i], 127);     
	    0.1::second => now;
	    tbPlay(tbScl[i], 0);
	    //0.01::second => now;
	} 
    
    // ganapai test
    // accepts 0-8
    for(0 => int i; i < 9; i++){
            <<< "ganapati :", i >>>;
            ganaPlay(i, 127);    
            0.1::second => now;
            ganaPlay(i, 0);  
            //0.1::second => now;
    }   
    
    // devi test
    // accepts 0-11
    for(0 => int i; i < 12; i++){
        <<< "devi :", i >>>;
        deviPlay(i, 127);    
        0.1::second => now;
        deviPlay(i, 0);  
        //0.1::second => now;
    }   
    
    // drumbot test
    // accepts 0-12
    for(0 => int i; i < 13; i++){
        <<< "drumbot :", i >>>;
        drumbotPlay(i, 127);    
        0.1::second => now;
        drumbotPlay(i, 0);  
        //0.15::second => now;
    }
    
    // marimbot test
    // accepts 
    for(0 => int i; i < mScl.size(); i++){
        <<< "marimbot :", i >>>;
        marimbotPlay(mScl[i], 127);    
        0.1::second => now;
        marimbotPlay(mScl[i], 0);  
        //0.15::second => now;
    }
  
 }
    