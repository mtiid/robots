over-actuate
============

A short piece that illustrates the shortfalls of mechatronic actuators. For at least two particpants.

setup
-----

Copy the following code into a blank ChucK script.

    // over-actuate

    // replace this number with the number of people participating
    3 => int participants;

    OscOut out;
    ("chuckServer.local", 50000) => out.dest;

    while(true) {
        out.start("/drumbot");
        out.add(0));
        out.add(127);
        out.send();
        participants => now;
    }

Count the number of people participating, then ChucK that into the `participants` variable.

directions
----------

Every few seconds or so, add a new shred to the virtual machine. Do this until the actuator fails to hit the drum head.

After such, slowly start to remove all of the currently running shreds, until the piece is silent.

Eric Heep
October, 2015
