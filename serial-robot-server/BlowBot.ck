// BlowBot.ck
// Nathan Villicana-Shaw
// CalArts Music Tech // MTIID4LIFE

public class BlowBot extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2
    // Snapperbots are 3, 4, 5, 6, 7, 8
    // StringThing is 9
    // RattleTron is 10
    // Tammy is 11
    // BlowBot is 12

    // MIDI notes
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] @=> int scl[];

    rescale(scl);

    12 => int ID;
    
    "/blowbot" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
