// SnapperBots.ck
// Nathan Shaw
// CalArts Music Tech

public class SnapperBots extends SerialBot {
    // Marimbot is 0
    // Trimpbeat is 1
    // Trimpspin is 2
    // Snapperbots are 3-9
    
    [3, 4, 5, 6, 7, 8] @=> int IDs[];
    
    // [60,61,62,63,64,65,66,67,68,69,
    //  70,71,72,73,74,75,76,77,78,79] @=> int scl[];

    // rescale(scl);

    "/snapperbot1" => string address;
    IDCheck(3, address) => int check;
    if (check >= 0) {
         spork ~ oscrecv(check, address);
    }
    /*
    "/snapperbot2" => address;
    IDCheck(4, address) => check;
    if (check >= 0) {
         spork ~ oscrecv(check, address);
    }
    "/snapperbot3" => address;
    IDCheck(5, address) => check;
    if (check >= 0) {
         spork ~ oscrecv(check, address);
    }
    "/snapperbot4" => address;
    IDCheck(6, address) => check;
    if (check >= 0) {
         spork ~ oscrecv(check, address);
    }
    "/snapperbot5" => address;
    IDCheck(7, address) => check;
    if (check >= 0) {
         spork ~ oscrecv(check, address);
    }
    "/snapperbot6" => address;
    IDCheck(8, address) => check;
    if (check >= 0) {
         spork ~ oscrecv(check, address);
    }
    */
}
