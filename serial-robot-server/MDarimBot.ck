// MDarimbot.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

public class MDarimBot extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2
    
    // MIDI notes
    // 76 currently missing
    [45,47,48,50,52,53,54,55,
     57,59,60,62,64,65,66,67,
     69,71,72,74,76,77,78,79,
     81,83,84,86,88,89,90,91,
     93,95,96] @=> int scl[];

    rescale(scl);

    0 => int ID;
    "/marimba" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
