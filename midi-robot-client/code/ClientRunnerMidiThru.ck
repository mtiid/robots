// =================================================================
//  File: ClientRunner.ck
//  console interface for setting up RobotClient.ck
//  by Bruce Lott 
//  CalArts Music Technology: Interaction, Intelligence & Design
//  February 2014
// =================================================================

ConsoleInput cI;

chout <= IO.nl() <= "welcome to the robot client! let's get set up...";

chout <= IO.nl() <= IO.nl() <= "Midi Ins:" <= IO.nl();

MidiIn min; 
min.printerr(0); // prevents no device error
int devicesIn;
while(true){    // print device list
    if(min.open(devicesIn)){
        chout<=devicesIn<= ": "<= min.name()<= IO.nl();
        devicesIn++;
    }
    else break;
}
chout <= IO.nl();

chout <= IO.nl() <= IO.nl() <= "Midi Ins:" <= IO.nl();

MidiOut mout; 
mout.printerr(0); // prevents no device error
int devicesOut;
while(true){    // print device list
    if(mout.open(devicesOut)){
        chout<=devicesOut<= ": "<= mout.name()<= IO.nl();
        devicesOut++;
    }
    else break;
}
chout <= IO.nl();

int iacIn;
numericConsoleChoice(0, devicesIn, "Type your IAC Bus's number: ") => iacIn;
int midiOut;
numericConsoleChoice(0, devicesOut, "Type your Network Session number: ") => midiOut;
Machine.add("RobotClientMidiThru.ck:" + iacIn + ":" + midiOut);

// function

fun int numericConsoleChoice(int minChoice,int maxChoice,string prompt){
    -1 => int val;
    string s;
    while(val < minChoice | val > maxChoice){
        cI.prompt(prompt);
        while(cI.more()){ 
            cI.getLine() => s;    // RegEx filters out non-digits (thanks Ness!)
            if(RegEx.match("[[:digit:]]+",s)) Std.atoi(s) => val;
        }
    }
    return val;
}
