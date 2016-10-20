serial-robot-server
===================
Written by Eric Heep in the summer of 2014, jointly maintained by CalArts Music Tech.

Allows for serial communication to the mechatronic instruments (robots) in the Machine Lab.

robot information
-----------------

Each robot needs to have an **identical ID number** that is written into both the Arduino code and its child class code.

    public class OldBot extends SerialBot {
        // OldBot is 0

        0 => int ID;
        "/OldBot" => string address;
        IDCheck(ID, address) => int check;
        if (check >= 0) {
            spork ~ oscrecv(check, address);
        }
    }

Currenly supported serial robots with their ID number and MIDI channel:

    ID 0 Ch 7 MDarimbot
    ID 1 Ch 8 Trimpbeat
    ID 2 Ch 9 Trimpspin
    ID 9 Ch 10 StringThing 

adding robots
-------------

To add a new robot to the server, make a new ChucK class, be sure to include the ID of **every** robot inside the class so no confusion arises:

    public class NewBot extends SerialBot {
        // OldBot is 0
        // NewBot is 1

        1 => int ID;
        "/NewBot" => string address;
        IDCheck(ID, address) => int check;
        if (check >= 0) {
            spork ~ oscrecv(check, address);
        }
    }

rescale
-------

To set the scale of a robot, make an integer array of the desired scale in the class and then call the function "rescale" using that array. This allows for MIDI/OSC notes to be interpreted correctly no matter the scale of a robot, and also restricts allowed messages to those in the array (making it good to include on every robot). 

    public class WholeToneBot extends SerialBot {
        // OldBot is 0
        // NewBot is 1
        // WholeToneBot is 2 

        // create MIDI scale here, whole notes starting at C
        [60, 62, 64, 66, 68, 70, 72] @=> int scl[];

        // call rescale here
        rescale(scl);

        2 => int ID;
        "/WholeToneBot" => string address;
        IDCheck(ID, address) => int check;
        if (check >= 0) {
            spork ~ oscrecv(check, address);
        }
    }

If there are any issues connecting or adding a robot to the server, email ericheep@alum.calarts.edu
