// =========================================================================
//  File: RobotClient.ck
//  Takes midi input from an IAC bus and sends OSC to the robot server
//  by Bruce Lott & Ness Morris
//  CalArts Music Technology: Interaction, Intelligence & Design
//  January 2014
// =========================================================================

MidiIn min;
MidiMsg msg;
//OscSend xmit;
OscOut oout;

int status, chan, noteNum, vel;

<<<"","">>>;
// choose which IAC bus to use
if(me.args()){ 
    if(min.open(Std.atoi(me.arg(0)))){ // open argument as IAC bus
        <<<"Successfully connected to",min.name()+"!">>>;
    }
}
else if(min.open("IAC Driver IAC Bus 1")){ // default name of a new IAC bus 
    <<<"Successfully connected to", min.name() +"!">>>;
}
else <<<"Failed to open IAC Bus","">>>;
<<<"","">>>;

// connect to robot server
//xmit.setHost("chuckServer.local",11235); 
("chuckServer.local",11235) => oout.dest;


// spork main loop
spork ~ midiLoop();

// confirm setup completion
7::second => now; // good luck time
<<<"If you didn't get any errors, you should be good to go!","">>>;

while(samp=>now);

// main loop
fun void midiLoop(){
    while(min=>now){
        while(min.recv(msg)){
            (msg.data1 & 0xF0)>>4 => status; // midi status byte
            (msg.data1 & 0x0F) => chan;      // midi channel
            if(status==9){ // note on
                msg.data2 => noteNum;
                msg.data3 => vel;
                if(chan==0){ // maha devi
                    if(noteNum > 59 & noteNum < 74){
                        oout.start("/devibot");
                        oscOut(noteNum, vel);
                        // xmit.startMsg("/devibot,ii");
                    }
                }
                if(chan==1){ // gana pati
                    if(noteNum > 59 & noteNum < 71){
                        oout.start("/ganipati");
                        oscOut(noteNum, vel);
                        // xmit.startMsg("/ganapati,ii");
                    }
                }
                if(chan==2){ // breakbot
                    if(noteNum > 59 & noteNum < 86){
                        oout.start("/drumBot");
                        oscOut(noteNum, vel);
                        // xmit.startMsg("/drumBot,ii");
                    }
                }
                if(chan==3){ // clappers
                    if(noteNum>59 & noteNum<81){
                        oout.start("/clappers");
                        oscOut(noteNum, vel);
                        // xmit.startMsg("/clappers,ii");
                    }
                }
                if(chan==4){ // jackbox percussion
                    if(noteNum>59 & noteNum<89){
                        oout.start("/jackperc");
                        oscOut(noteNum, vel);
                        // xmit.startMsg("/jackperc,ii");
                    }
                }
                if(chan==5){ // jackbox bass
                    if(noteNum>59-8 & noteNum<84-8){
                        oout.start("/jackbass");
                        oscOut(noteNum + 8, vel);
                        // xmit.startMsg("/jackbass,ii");
                    }
                }
                if(chan==6){ // jackbox guitar
                    if(noteNum>59-8 & noteNum<94-8){
                        oout.start("/jackgtr");
                        oscOut(noteNum + 8, vel);
                        // xmit.startMsg("/jackgtr,ii");
                    }
                }
                if(chan==7){ // MDarimBot
                    oout.start("/MDarimBot");
                    oscOut(noteNum, vel);
                }
                if(chan==8){ // Trimpbeat
                    oout.start("/Trimpbeat");
                    oscOut(noteNum, vel);
                }
                if(chan==9){ // Trimpspin
                    oout.start("/Trimpspin");
                    oscOut(noteNum, vel);
                } 
            }
            if(status==8){ // note off
                if(chan==5){ // jackbox bass
                    if(noteNum>59-8 & noteNum<84-8){
                        oout.start("/jackbass");
                        oscOut(noteNum + 8, 0);
                        // xmit.startMsg("/jackbass,ii");
                    }
                }
                if(chan==6){ // jackbox guitar
                    if(noteNum>59-8 & noteNum<94-8){
                        oout.start("/jackgtr");
                        oscOut(noteNum + 8, 0);
                        // xmit.startMsg("/jackgtr,ii");
                    }
                }
                if(chan==9){ //Trimpspin
                    oout.start("/Trimpspin");
                    oscOut(noteNum, 0);
                }
            }
        }
    }
}

fun void oscOut(int newNoteNum, int newVel){
    oout.add(newNoteNum - 60);
    oout.add(newVel);
    oout.send()
    // xmit.addInt(newNoteNum-60);
    // xmit.addInt(newVel);
}
