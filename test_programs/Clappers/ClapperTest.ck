OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void clapperSend(int note, int vel){
    out.start("/clappers");
    out.add(note);
    out.add(vel);
    out.send();   
}
fun void clapperPlay(int note, int vel, int delayMS){
    clapperSend(note, vel);
    delayMS::ms => now;
    clapperSend(note, 0);
}

fun void left_to_right(int delayMS, int vel){
    for(0 => int i; i < 20; i++){
        i => int note;
        vel => int velocity;
        <<< "clappers : ", note, "-", velocity >>>;
        spork ~ clapperPlay(note, velocity, 25);
        delayMS::ms => now;
    }
}

fun void right_to_left(int delayMS, int vel){
    for(20 => int i; i > 0; i--){
        i => int note;
        vel => int velocity;
        <<< "clappers : ", note, "-", velocity >>>;
        spork ~ clapperPlay(note, velocity, 25);
        delayMS::ms => now;
    }
}

while(true) {
    for ( 50 => int t; t > 10; t++){
        left_to_right(t, 100);
        right_to_left(t, 100);
    }
}