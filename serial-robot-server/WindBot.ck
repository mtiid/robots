// WindBot.ck
// Nathan Villicana-Shaw
// CalArts Music Tech // MTIID4LIFE

public class WindBot extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2
    // Snapperbots are 3, 4, 5, 6, 7, 8
    // StringThing is 9
    // RattleTron is 10
    // Tammy is 11
    // WindBot is 12

    // MIDI notes
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] @=> int scl[];

    rescale(scl);

    12 => int ID;
    0 => float reservoir;
    0 => int filling;
    
    "/windbot" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }

    //spork ~ trackReservoir();    
    
    fun void trackReservoir() {
        while(true) {
            
            reservoir-2 => reservoir;
            <<< "reservoir:", reservoir >>>;
            
            if(reservoir < 600) {
                1 => filling;
            }
            else if(reservoir > 900) {
                0 => filling;
            }
            
            if(filling) {
                talk.talk.note(check, 14, 1000);
                5 +=> reservoir;
            }
            
            0.5::second => now;
        }
    }
    
    // receives OSC and sends out serial
    fun void oscrecv(int port, string address) {
        while (true) {
            oin => now;
            while (oin.recv(msg)) {
                if (msg.address == address) {
                    renote(msg.getInt(0)) => int note;
                    msg.getInt(1) => int vel;
                    if(note != 14)
                        reservoir-vel/100 => reservoir;
                    if (note >= 0) {
                        talk.talk.note(port, note, vel);
                    }
                    else {
                        <<< msg.getInt(0), "is not an accepted note number for", address, "" >>>;
                    }
                }
            }
        }
    }
}
