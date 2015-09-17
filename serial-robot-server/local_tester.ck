// local_tester.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

OscOut oout;
("localhost", 50000) => oout.dest;

[45,47,48,50,52,53,54,55,
 57,59,60,62,64,65,66,67,
 69,71,72,74,76,77,78,79,
 81,83,84,86,88,89,90,91,
 93,95,96] @=> int mscl[];

while (true) {
    for (0 => int i; i < mscl.size(); i++) {
        oout.start("/marimba");
        oout.add(mscl[i]);
        oout.add(127);
        oout.send();
        0.25::second => now;
    }
}

