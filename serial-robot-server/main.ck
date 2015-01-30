// main.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

// give it some time to breathe
HandshakeID talk;
0.5::second => now;

// initial handshake between ChucK and Arduinos
talk.talk.init();
1::second => now;

// bring on the bots
MDarimBot m;
Trimpbeat b;
Trimpspin s;

while (true) {
    1::second => now;
}
