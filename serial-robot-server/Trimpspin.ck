// Trimpspin.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

public class Trimpspin extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2

    // MIDI notes
    [60,61,62,63,64,65,66,67,68,69,
     70,71,72,73,74,75,76,77,78,79] @=> int scl[];

    rescale(scl);

    2 => int ID;
    "/trimpspin" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
