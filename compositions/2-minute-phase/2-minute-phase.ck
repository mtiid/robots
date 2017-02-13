// 2-minute-phase.ck

// Eric Heep
// April, 2015

// Generates a phasing pattern through all the notes of the /marimbot, 
// lasts for exactly 2 minutes, with the base pulse being one second.

OscOut out;
("chuckServer.local", 50000) => out.dest;

// note function out
fun void note(int num, string addr) {
    out.start(addr);
    out.add(num);
    out.add(120);
    out.send();
}

// marimba midi notes
[45,47,48,50,52,53,54,55,
57,59,60,62,64,65,66,67,
69,71,72,74,76,77,78,79,
81,83,84,86,88,89,90,91,
93,95] @=> int notes[];

fun void phase(int num_notes, dur total, dur cycle) {
    (total/cycle) $ int => int num_cycles;

    if (total/cycle != num_cycles) {
        num_cycles * cycle => total;
        <<< "Total time is not divisible by the cycle time, calculating a new total of", total/minute, "minutes" >>>;
    }

    if (num_notes > num_cycles) {
        <<< "Your total time is too short or your length is too long", "" >>>;
        me.exit();
    }

    for (int i; i < num_notes; i++) {
        spork ~ phaseLoop( i, num_cycles, total);
        0.5::ms => now;
    }

    total => now;
    1::second => now;
}

fun void phaseLoop(int idx, int num_cycles, dur total) {
    total/(num_cycles - idx) => dur cycle_time;
    for (int i; i < num_cycles - idx; i++) {
        note(notes[idx], "/marimba");
        cycle_time => now;
    }
}

phase(notes.size(), 2::minute, 1.0::second);
