// SerialBot.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

public class SerialBot {

    HandshakeID talk;

    OscIn oin;
    OscMsg msg;

    // new port number
    50001 => oin.port;
    oin.listenAll();

    // for optional rescaling
    int scale[64];
    scale.cap() => int scaleCap;
    for (int i; i < scale.cap(); i++) {
        i => scale[i];
    }

    // reassigns incoming MIDI notes to their proper robot note
    fun void rescale(int newScale[]) {
        newScale.cap() => scaleCap;
        for (int i; i < newScale.cap(); i++) {
            newScale[i] => scale[i];
        }
    }

    // note reassignment, also checks if message is a valid note
    fun int renote(int oldNote) {
        int pass, newNote;
        for (int i; i < scaleCap; i++) {
            if (oldNote == scale[i]) {
                i => newNote;
                1 => pass;
            }
        }
        if (pass != 1) {
            -1 => newNote;
        }
        return newNote;
    }

    // tells child class to only send serial messages
    // if it has successfully connected to a matching robot
    fun int IDCheck(int arduinoID, string address) {
       -1 => int check;
        for (int i; i < talk.talk.robotID.cap(); i++) {
            if (arduinoID == talk.talk.robotID[i]) {
                <<< address, "connected!", i >>>;
                i => check;
            }
        }
        if (check == -1) {
            <<< address, "was unable to connect">>>;
        }
        return check;
    }

    // receives OSC and sends out serial
    fun void oscrecv(int port, string address) {
        while (true) {
            oin => now;
            while (oin.recv(msg)) {
                if (msg.address == address) {
                    renote(msg.getInt(0)) => int note;
                    if (note >= 0) {
                        talk.talk.note(port, note, msg.getInt(1));
                    }
                    else {
                        <<< msg.getInt(0), "is not an accepted note number for", address, "" >>>;
                    }
                }
            }
        }
    }
}
