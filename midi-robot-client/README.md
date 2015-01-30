midi-robot-client
============
Written by Ness Morris and Bruce Lott, maintained by CalArts Music Tech

This ChucK program takes midi input from an IAC bus and sends OSC to the robot server over LAN, controlling the robots.

To use:
- Setup an IAC bus if you haven't already, here's a [good tutorial](http://bit.ly/M3fRKY).
- Disable your wifi.
- Check in Network if your ethernet is successfully connected.
- Double click LAUNCHER.command and answer the question in the console that pops up.
- If no errors pop up, you should be good to go!  

When you are setup, check out the Trigger_List.txt for robot channel and note #s!

All robots (besides Jackbox's guitar and bass) start at middle C (MIDI note #60).
The channel you send MIDI to chooses the robot your are controlling. 

Check out Ableton_Setup.png for additional visual guidance in setting up Ableton for robot control.

TODO: Add instructions for serial robots, their implementation will be slightly different than the Hiduino robots.

Troubleshooting
---------------
If everything seems to be in order but your still not able to control the robots, you may need to restart your computer. The IAC bus can mysteriously malfunction !!!

    Error: [chuck](via OSC): UDP_Transmitter: unknown host: chuckServer.local

Meaning: Your ethernet is not connecting to the server. 

    Error: Segmentation Fault (of any kind)

Meaning: Your ethernet is (probably) not connecting to the serverakes the robots midi addressable over a network
