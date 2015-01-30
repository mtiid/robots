hiduino-robot-server
=====
Written by Ness Morris and Bruce Lott, based on code by Ajay Kapur, Owen Vallis, and Dimitri Diakopoulos.
Jointly maintained by CalArts Music Tech.

Allows for Hiduino communication to the Karmetik Machine Orchestra Robots.

Currently support robots with their MIDI channel: 

    Ch 0 MahaDevi
    Ch 1 GanaPati
    Ch 2 BreakBot
    Ch 3 Clappers
    Ch 4 JackPerc
    Ch 5 JackBass
    Ch 6 JackGuitar

To connect using ChucK via OSC:

    OscOut oout:

    // fibonacci port number
    ("chuckServer.local",11235) => oout.dest;

Then to send to a robot: 

    oout.start("/Address")
    oout.add(note)
    oout.add(velocity)
    oout.send();

To connect using MIDI, check out the [midi-robot-client](https://github.com/MTIID/midi-robot-client) repo.

If there are issues connecting, email ericheep@alum.calarts.edu
