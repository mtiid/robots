OscOut out;
("chuckServer.local", 50000) => out.dest;


fun void tSend(int note, int vel){
    out.start("/tammy");
    out.add(note);
    out.add(vel);
    out.send();
}


// Tammy Hernandez takes notes 0-13
// 0 is
// 1 is
// 2 is
// 3 is
// 4 is
// 5 is
// 6 is
// 7 is
// 8 is
// 9 is
// 10 is
// 11 is
// 12 is
// 13 is
while(true) {
    for (int i; i < 14; i++){
        tSend(1, 120);
        1000::ms => now;
    }
}

