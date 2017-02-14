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

fun void left_to_right(float delayMS, int vel){
    for(0 => int i; i < 20; i++){
        i => int note;
        vel => int velocity;
        spork ~ clapperPlay(note, velocity, 25);
        delayMS::ms => now;
    }
}

fun void right_to_left(float delayMS, int vel){
    for(20 => int i; i > 0; i--){
        i => int note;
        vel => int velocity;
        spork ~ clapperPlay(note, velocity, 25);
        delayMS::ms => now;
    }
}

fun void allAtOnce(int vel, int delayMS) {
    for (int i; i < 20; i++){
      clapperSend(i, vel);   
    }
    delayMS::ms => now;
}


while(true) {
    for ( 70 => float t; t > 2; t * 0.9 => t){
        <<<"Clappers with delay of ", t, "ms">>>;
        left_to_right(t, 100);
        right_to_left(t, 100);
    }
    for (127 => int i; i > 0; i - 2 => i){
        allAtOnce(i, 100);   
    }
    for ( 2 => float t; t < 200; t * 1.1 => t){
        <<<"Clappers with delay of ", t, "ms">>>;
        left_to_right(t, 100);
        right_to_left(t, 100);
    }
    2::second => now;
}