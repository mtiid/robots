OscOut out;
("chuckServer.local", 50000) => out.dest;

fun void drumbotSend(int note, int vel){
    out.start("/drumBot");
    out.add(note);
    out.add(vel);
    out.send();
}

// it does not need note offs, but its a good habit
// to get used to sending them
fun void drumbotPlay(int note, int vel, int delayMS){
    drumbotSend(note, vel);   
    delayMS::ms => now;
    drumbotSend(note, 0);
}

// drumbot accepts 0-12
while (true) {
    for (127 => int vel; vel > 50; vel - 10 => vel){
        for(0 => int i; i < 13; i++){
            vel => int velocity;
            i => int note;
            250 => int delayMS;
            <<< "drumbot :", note, velocity >>>;
            drumbotPlay(note, velocity, delayMS);    
        }
    }
}