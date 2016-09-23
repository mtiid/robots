OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void drumbotPlay(int note, int vel){
    out.start("/drumBot");
    out.add(note);
    out.add(vel);
    out.send();
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