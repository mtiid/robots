robots
======

There are currently two servers, one for the hiduino bots (ceiling bots), and one for the serial bots (piano, marimba).

The two servers should always be running, but if they aren't, go to terminal and run the masters for both servers.

    $ cd ~/git/robots
    $ chuck --loop $ /hiduino-robot-server/master.ck
    $ chuck --port:8889 /serial-robot-server/master.ck

You could also just

communication
-------------

To connect using ChucK via OSC:

    OscOut out;

    ("chuckServer.local", 50000) => out.dest;

Or to connect wirelessly:

    OscOut out;
    
    // this ip will change every once in a while
    ("10.2.35.254", 50000) => out.dest;

Then to send to a robot using its OSC address, usually similar to it's name.

    out.start("/clappers");
    out.add(note);
    out.add(velocity);
    out.send();

A full list of robots by their OSC addresses

    // hiduino robots
    /drumbot
    /clappers
    /ganapati
    /jackbass
    /jackgtr
    /jackperc
    /devibot

    // serial robots
    /marimba
    /trimpspin
    /trimpbeat

To connect using MIDI, see the [midi-robot-client](https://github.com/MTIID/midi-robot-client) repo.

quick-test-code
---------------

    OscOut out;
    ("10.2.35.245", 50000) => out.dest;

    while(true) {
        out.start("/clappers");
        out.add(Math.random2(0, 20));
        out.add(127);
        out.send();
    }

programmers
-----------

hiduino-robot-server and midi-robot-client written by Ness Morris and Bruce Lott in the winter of 2013-2014, based on code by Ajay Kapur, Owen Vallis, and Dimitri Diakopoulos.

serial-robot-server written by Eric Heep in the summer of 2014, currently maintained by Eric Heep.

If there are any issues connecting or adding a robot to the server, email ericheep@alum.calarts.edu robots
