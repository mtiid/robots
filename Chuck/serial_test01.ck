
SerialIO.list() @=> string list[];

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

SerialIO cereal;
cereal.open(2, SerialIO.B9600, SerialIO.BINARY);


[10] @=> int whatever[];

while(true)
{
    cereal.writeBytes(whatever);
    for(int i; i < whatever.cap(); i++)
    {
        chout <= whatever[i] <= " ";
    }
    Math.random2(5, 5000) => whatever[0];
    chout <= IO.newline();
    5::second => now;
}
