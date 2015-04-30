// clock-phase-rpi.ck

// Eric Heep
// April, 2015
// requires the SystemTime chugin

// Generates a phasing pattern through all the notes of the marimbot
// that runs indefinitely, and is tied to the system clock.

// This version is specific to run on a Raspberry Pi.

SerialIO serial;
SerialIO.list() @=> string list[];
-1 => int serial_port;

// chugin for getting system time
SystemTime sys;

for (int i; i < list.size(); i++) {
    if (list[i].find("tty") > 0) {
        i => serial_port;
    }
}

if (serial_port == -1) {
    <<< "No usbmodem device detected", "" >>>;
    me.exit();
}

if (!serial.open(serial_port, SerialIO.B9600, SerialIO.BINARY)) {
    <<< "Unable to open serial device:", "\t", list[serial_port] >>>;
}
else {
    <<< list[serial_port], "assigned to port", serial_port, "" >>>;
}

// global for memory
int bytes[2];

// note function out
fun void note(int num, int vel) {
    (num << 2) | (vel >> 8) => bytes[0];
    vel & 0xff => bytes[1];
    serial.writeBytes(bytes);
}

fun void initialize() {
    2::second => now;
    [255, 255] @=> int ping[];
    serial.writeBytes(ping);
}

[ 6, 7, 8, 9,10,11,18,19,
 21,22,23,30,31,32,33,34,
  0, 1, 2, 3, 4, 5,12,13,
 14,15,16,17,24,25,26,27,
 28,29,35,36] @=> int notes[];
  
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
        note(notes[(notes.size() - 1) - idx], 100);
        increment => now; 
    }
}

// serial setup
initialize();

// total period time, time of base cycle, period to sync with the system clock
phaseClock(60::minute, 1::second, 30::second, notes.size());
