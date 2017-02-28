OscOut out;
("chuckServer.local", 50000) => out.dest;


fun void tSend(int note, int vel){
    out.start("/tammy");
    out.add(note);
    out.add(vel);
    out.send();
}


// Tammy takes notes 0-13
while(true) {
    for (int i; i < 14; i++){
    tSend(i, 120);
    100::ms => now;
}
}

