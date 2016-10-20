// StringThing.ck
// Nathan Villicana-Shaw
// CalArts Music Tech // MTIID4LIFE

public class StringThing extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2
    // Snapperbots are 3, 4, 5, 6, 7, 8
    // StringThing is 9

    // MIDI notes
    [0, 1, 2, 3, 4] @=> int scl[];

    rescale(scl);

    9 => int ID;
    
    "/stringthing" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
