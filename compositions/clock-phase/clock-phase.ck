// clock-phase.ck

// Eric Heep
// April, 2015
// requires the SystemTime chugin

// Generates a phasing pattern through all the notes of the marimbot
// that runs indefinitely, and is tied to the system clock.

OscOut out;
("chuckServer.local", 50000) => out.dest;

// note function out
fun void note(int num, string addr) {
    out.start(addr);
    out.add(num);
    out.add(100);
    out.send();
}

SystemTime sys;

// marimba midi notes
[45,47,48,50,52,53,54,55,
57,59,60,62,64,65,66,67,
69,71,72,74,76,77,78,79,
81,83,84,86,88,89,90,91,
93,95] @=> int notes[];

// finds the durations for each actuator, adjusts if given improper values
fun dur[] incrementCalculation(dur total, dur cycle, int num) {
    (total/cycle) $ int => int iterations;

    if (total/cycle != iterations) {
        iterations * cycle => total;
        <<< " Recalculating total time:", total/minute, "minutes" >>>;
    }
    if (num > iterations) {
        <<< "Your total time is too short or your length is too long", "" >>>;
        me.exit();
    }

    dur increments[num];

    for (int i; i < num; i++) {
        total/(iterations - i) => increments[i];
    }

    return increments;
}

// main program, resyncs chuck to the system clock every so often
fun void phaseClock(dur total, dur cycle, dur sync, int num) {

    incrementCalculation(total, cycle, num) @=> dur increments[];
   
    dur offsets[num];
    for (int i; i < num; i++) {
        increments[i] - cycle => offsets[i];
    }

    (sync/cycle) $ int => int repeats;

    sync - (sys.ftime() % (sync/second))::second => now;
    0::samp => dur nudge; 

    while (true) {

        Math.round(sys.ftime() % (total/second)) $ int => int iterations;
        for (int i; i < num; i++) {
            spork ~ phaseNote(increments[i], offsets[i], iterations, repeats, i);
        }

        sync + nudge => now;
        (Math.round(sys.ftime()) - sys.ftime())::second => nudge;
    }
}

// phases each note for the set sync time, then resyncs and continues
fun void phaseNote(dur increment, dur offset, int iterations, int repeats, int idx) {
    offset * iterations => now;

    for (int i; i < repeats; i++) {
        note(notes[(notes.size() - 1) - idx], "/marimba");
        increment => now; 
    }
}

// allow time for compiling
1::samp => now;

// total period time, time of base cycle, period to sync with the system clock
phaseClock(60::minute, 1::second, 30::second, notes.size());
