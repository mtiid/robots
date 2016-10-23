// SnapperBots.ck
// Nathan Shaw
// CalArts Music Tech

// Marimbot is 0
// Trimpbeat is 1
// Trimpspin is 2
// Snapperbots are 3-8
// StringThing is 9

public class SnapperBot1 extends SerialBot {
    [0,1,2,3] @=> int scl[];

    rescale(scl);
    
    3 => int ID;

    IDCheck(3, "/snapperbot1") => int check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbot1");
    }
}
/*
    IDCheck(4, "/snapperbots") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbots");
    }
    IDCheck(5, "/snapperbots") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbots");
    }
    IDCheck(6, "/snapperbots") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbots");
    }
    IDCheck(7, "/snapperbots") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbots");
    }
    IDCheck(8, "/snapperbots") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbots");
    }
*/
