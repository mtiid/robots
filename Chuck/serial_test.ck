
SerialIO.list() @=> string list[];

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

SerialIO cereal;
cereal.open(2, SerialIO.B57600, SerialIO.ASCII);

[2, 10, 10, 3] @=> int bytes[];

while(true)
{
    swipeBank(Math.random2(0,3), Math.random2(10, 200));
    2::second => now;
}

fun void allBanks(int level){
    cereal <= "V" <= level;
}

fun void swipeBank(int bank, int length){
     cereal <= "S" <= bank <= " " <= length;// <= "1" <= "9";
}
