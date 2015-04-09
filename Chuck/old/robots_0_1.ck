SerialIO.list() @=> string list[];

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

SerialIO cereal;
cereal.open(2, SerialIO.B9600, SerialIO.ASCII);

//dev two is usually it
int channel;
float value;
int devices;

int mbuttons[8];
int rbuttons[8];
int sbuttons[8];

[2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0] @=> float sliders[];
[50.0,50.0,50.0,50.0,50.0,50.0,50.0,50.0] @=> float knobs[];

// check
fun void allBanks(int level){
    cereal <= "V" <= " " <= level <= "=" <= "`" <= "{" <= "\n";
}

fun void flipSwitch(int bank, int swit){
    cereal <= "F" <= " " <= bank <= "=" <= swit <= "{" <= "\n";
}

fun void poundBank(int bank, int switchNum){
    cereal <= "L" <= " " <= bank <= "=" <= switchNum <= "{" <= "\n";
}

fun void swipeBank(int bank, float length){
    for(0 => int i; i < 8; i++){
        cereal <= "F" <= " " <= bank <= "=" <= i <= "{" <= "\n";
        length::ms => now;
    }
}

fun void oscListener() {
    OscIn in;
    OscMsg msg;
    
    in.port(40000);
    in.listenAll();
    
    while (true) {
        in => now;
        while (in.recv(msg)) {
            if (msg.address == "/switch") {
                poundBank(msg.getInt(0), msg.getInt(1));
            }
        }
    }
}

fun void swipeAll(float length){
    for( 0 => int b; b < 4; b++){
        for(0 => int i; i < 8; i++){
            cereal <= "F" <= " " <= b <= "=" <= i <= "{" <= "\n";          
        }
        length::ms => now;
    }
}

spork ~ oscListener();

while(true)
{
    93::ms => now;
}
