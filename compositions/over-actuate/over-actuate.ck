// over-actuate
// Eric Heep, 2015

// ~ setup
// Count the number of people participating, then chuck that into the
// `participants` variable.

// ~ directions
// Every few seconds or so, add a new
// shred to the virtual machine. Do this until the actuator fails to
// hit the drum head.

// After such, slowly start to remove all of the currently
// running shreds until the piece is silent.

// replace this number with the number of people participating
3 => int participants;

// 1 for wireless, 0 for LAN
1 => int wireless;

OscOut out;

if (wireless) {
    // wireless isn't recommended, but works still
    // you will definitely get some dropped messages
    ("10.40.16.193", 50000) => out.dest;
}
else {
    // a LAN (wired) connection is optimal, and will
    // ensure that you don't drop any messages
    ("chuckServer.local", 50000) => out.dest;
}

while(true) {
    // osc address of our big break bot
    out.start("/drumBot");
    // note
    out.add(0);
    // velocity
    out.add(127);
    // sends packet
    out.send();
    participants::second => now;
}
