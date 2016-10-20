// SnapperBots.ck
// Nathan Shaw
// CalArts Music Tech

public class SnapperBots extends SerialBot {
    // Marimbot is 0
    // Trimpbeat is 1
    // Trimpspin is 2
    // Snapperbots are 3-8
    // StringThing is 9
    
    [3, 4, 5, 6, 7, 8] @=> int IDs[];
    
    [0,1,2,3] @=> int scl[];

    rescale(scl);

    IDCheck(3, "/snapperbot") => int check;
    if (check >= 0) {
         spork ~ oscrecv(check, "snapperbot1");
    }
    IDCheck(4, "/snapperbot") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "snapperbot2");
    }
    IDCheck(5, "/snapperbot") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbot3");
    }
    IDCheck(6, "/snapperbot") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbot4");
    }
    IDCheck(7, "/snapperbot") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbot5");
    }
    IDCheck(8, "/snapperbot") => check;
    if (check >= 0) {
         spork ~ oscrecv(check, "/snapperbot6");
    }
}
