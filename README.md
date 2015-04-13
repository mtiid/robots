robots
======

There are currently two servers, one for the hiduino bots (ceiling bots), and one for the serial bots (piano, marimba).

The two servers should always be left running, but in the case that they aren't, you'll need to open terminal and run the master.ck files for both servers.

You can simply copy/paste this code into terminal.

    chuck ~/git/robots/hiduino-robot-server/master.ck &
    chuck ~/git/robots/serial-robot-server/master.ck

communication
-------------

To connect using ChucK using OSC with a LAN connection:

    OscOut out;

    ("chuckServer.local", 50000) => out.dest;

**IT IS NOT RECOMMENEDED TO CONNECT WIRELESSLY**
**ONLY DO SO IF YOU WANT DROPPED OSC MESSAGES**

~~Or to connect wirelessly:~~

    ~~OscOut out;~~
    
    ~~// this ip will change every once in a while~~
    ~~("10.2.35.254", 50000) => out.dest;~~

To send to a robot using its OSC address.

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

To connect using MIDI, see the [midi-robot-client](https://github.com/MTIID/robots/tree/master/midi-robot-client) repo.

quick-test-code
---------------
Copy/paste this to quickly see if you can successfully connect.

    OscOut out;
    ("10.2.35.245", 50000) => out.dest;

    while(true) {
        out.start("/clappers");
        out.add(Math.random2(0, 20));
        out.add(127);
        out.send();
        10::ms => now;
    }

programmers
-----------

hiduino-robot-server and midi-robot-client written by Ness Morris and Bruce Lott in the winter of 2013-2014

hiduino-robot-server based on code by Ajay Kapur, Owen Vallis, and Dimitri Diakopoulos

serial-robot-server written by Eric Heep in the summer of 2014, currently maintained by Eric Heep

If there are any issues connecting or adding a robot to the server, email ericheep@alum.calarts.edu
