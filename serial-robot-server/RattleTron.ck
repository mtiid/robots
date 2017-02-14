// RattleTron.ck
// Nathan Villicana-Shaw
// CalArts Music Tech // MTIID4LIFE

public class RattleTron extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2
    // Snapperbots are 3-8
    // StringThing is 9
    // RattleTron is 10

    // MIDI notes
    [0,1,2,3,4,5] @=> int scl[];

    rescale(scl);

    10 => int ID;
    "/rattletron" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
