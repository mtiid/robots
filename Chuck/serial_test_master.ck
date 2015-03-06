
SerialIO.list() @=> string list[];

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

SerialIO cereal;
cereal.open(2, SerialIO.B57600, SerialIO.ASCII);

while(true)
{
    swipeBank(Math.random2(0,3), Math.random2(10, 200));
    //allBanks(Math.random2(0,7));
    //flipSwitch(Math.random2(0,3),Math.random2(0,7));
    //poundBank(Math.random2(0,3), Math.random2(0,7));
    .4::second => now;
}

fun void allBanks(int level){
    cereal <= "V" <= level;
}

fun void flipSwitch(int bank, int swit){
    cereal <= "F" <= bank <= " " <= swit;
}

fun void poundBank(int bank, int switchNum){
    cereal <= "S" <= bank <= " " <= switchNum;
}

fun void swipeBank(int bank, int length){
     cereal <= "S" <= bank <= " " <= length;
}
