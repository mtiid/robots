// master.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

// communication classes
Machine.add(me.dir() + "/Handshake.ck");
Machine.add(me.dir() + "/HandshakeID.ck");
Machine.add(me.dir() + "/SerialBot.ck");

// add robots here
Machine.add(me.dir() + "/MDarimBot.ck");
Machine.add(me.dir() + "/Trimpbeat.ck");
Machine.add(me.dir() + "/Trimpspin.ck");
Machine.add(me.dir() + "/SnapperBots.ck");
Machine.add(me.dir() + "/StringThing.ck");
Machine.add(me.dir() + "/RattleTron.ck");
Machine.add(me.dir() + "/Tammy.ck");

// main program
Machine.add(me.dir() + "/main.ck");
7.0::second => now;
<<< "-", "" >>>;

// osc test
// Machine.add(me.dir() + "/local_tester.ck");
