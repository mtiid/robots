over-actuate
============

A short piece that illustrates the shortfalls of mechatronic actuators. For at least two particpants.

setup
-----

Copy the following code into a blank ChucK script, or open the over-actuate.ck script found in this directory.

    // over-actuate, Eric Heep

    // replace this number with the number of people participating
    3 => int participants;
    // 1 for wireless, 0 for LAN
    1 => int wireless;

    OscOut out;

    if (wireless) {
        ("10.40.16.193", 50000) => out.dest;
    }
    else {
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

Count the number of people participating, then chuck that into the `participants` variable.

The IP of the network may change, this is only an issue if you are connecting wirelessy. If so, open up the network preferences on the server.

directions
----------

Every few seconds or so, add a new shred to the virtual machine. Do this until the actuator fails to hit the drum head.

After such, slowly start to remove all of the currently running shreds until the piece is silent.

Eric Heep
October, 2015
