// hub.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

// wired in
OscIn in;
OscMsg msg;

50000 => in.port;
in.listenAll();

// localhost out for hiduino-bots
OscOut h_out;
("localhost", 11235) => h_out.dest;

// localhost out for serial-bots 
OscOut s_out;
("localhost", 50001) => s_out.dest;

// addresses for hiduino-bots
["/drumBot", "/clappers", "/ganapati", "/jackbass", "/jackgtr", "/jackperc", "/devibot"] @=> string hiduinos[];   

// addresses for serial-bots
["/marimba", "/trimpspin", "/trimpbeat", "/snapperbot", "/stringthing"] @=> string serials[];   

// checks for hiduino-bot message
fun int hCheck(string m) {
    for (int i; i < hiduinos.cap(); i++) {
        if (m == hiduinos[i]) {
            return 1;
        }
    }
    return 0;
}

// checks for serial-bot message
fun int sCheck(string m) {
    for (int i; i < serials.cap(); i++) {
        if (m == serials[i]) {
            return 1;
        }
    }
    return 0;
}

// recieves wireless osc messages and 
// sends them through the local host
while (true) {
    in => now;
    while (in.recv(msg)) { 
        if (hCheck(msg.address)) {
            h_out.start(msg.address);
            h_out.add(msg.getInt(0));
            h_out.add(msg.getInt(1));
            h_out.send();
        }
        if (sCheck(msg.address)) {
            s_out.start(msg.address);
            s_out.add(msg.getInt(0));
            s_out.add(msg.getInt(1));
            s_out.send();
        }
    }
}
