robots
======

There are currently two servers, one for the hiduino bots (ceiling bots), and one for the serial bots (piano, marimba).

The two servers should always be left running. In the case that they aren't, simply type the following into terminal.

    $ robots

This will run a bash function that kills any running ChucK programs, and then starts the server.

    robots() {
        SERVICE='chuck'

        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
            echo "$SERVICE killing running chuck programs"
            killall chuck
        fi

        chuck ~/git/robots/serial-robot-server/master.ck --port:8888 &
        chuck ~/git/robots/hiduino-robot-server/master.ck --port:8889
    }


communication
-------------

**IT IS NOT RECOMMENEDED TO CONNECT WIRELESSLY**

While it is entirely possible to connect using the wireless network, you will definitely experience lag and dropped OSC messages.

To connect using ChucK using OSC with a LAN connection:

    OscOut out;

    ("chuckServer.local", 50000) => out.dest;

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
Copy/paste this to quickly see if you can successfully connect using a wired connection.

    OscOut out;
    ("chuckServer.local", 50000) => out.dest;

    while(true) {
        out.start("/clappers");
        out.add(Math.random2(0, 20));
        out.add(127);
        out.send();
        10::ms => now;
    }

programmers
-----------

hiduino-robot-server and midi-robot-client written by Ness Morris and Bruce Lott in the winter of 2013-2014, based on code by Ajay Kapur, Owen Vallis, and Dimitri Diakopoulos

serial-robot-server written by Eric Heep in the summer of 2014, currently maintained by Eric Heep

If there are any issues connecting or adding a robot to the server, email ericheep@alum.calarts.edu
