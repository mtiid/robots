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
     93,95,96,97] @=> int scl[];


    // order of working actuators
    /*[ 0, 1, 2, 3, 4, 5, 6, 7,
      8, 9,10,11,12,13,14,15,
     16,17,18,19,20,21,22,23,
     24,25,26,27,28,29,30,31,
     32,33,34,37] @=> int actuatorOrder[];
     */

    /*
    // Erics remap
    [ 6, 7, 8, 9,10,11,18,19,
     21,22,23,30,31,32,33,34,
      0, 1, 2, 3, 4, 5,12,13,
     14,15,16,17,24,25,26,27,
     28,29,35,36] @=> int actuatorOrder[];
     */

    // Nathans re-remap
    [6, 7, 8, 5, 10, 14, 12, 13, 11, 15,
     16, 17, 18, 20, 19, 21, 22, 23, 35,
     25, 26, 27, 28, 29, 30, 31, 32, 33, 
     0, 1, 3, 2, 9, 4, 20, 34] @=> int actuatorOrder[];

    rescale(scl, actuatorOrder);

    0 => int ID;
    "/marimba" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0 & check < 34) {
        spork ~ oscrecv(check, address);
    }
}
