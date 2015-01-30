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
    oout.start("/marimba");
    oout.add(Math.random2(0,20) + 60);
    oout.add(127);
    oout.send();
    0.1::second => now;
    <<< "!" >>>;
}

