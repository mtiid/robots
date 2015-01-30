// ^^ insert IAC Bus name above if in midiaudicle, then hit add shred ^^
MidiIn min;
MidiMsg msg;
OscSend xmit;

int status, chan, noteNum, vel;

//choose which IAC Bus to use
if(me.args()) min.open(me.arg(0));
else min.open("IAC Driver IAC Bus 2"); //default name of a new IAC Bus 

xmit.setHost("chuckServer.local",11235); //connect to robot server

//main loop
while(min=>now){
    while(min.recv(msg)){
        (msg.data1 & 0x90)>>4 => status; //midi status byte
        (msg.data1 & 0x0F) => chan;      //midi channel
        if(status==9){   //note on
            msg.data2 => noteNum;
            msg.data3 => vel;
            if(chan==0){ //maha devi
                if(noteNum > 59 & noteNum < 74){
                    chout<="Sending mahaDevi note"<=IO.nl();
                    xmit.startMsg("/devibot,ii");
                    oscOut(noteNum, vel);
                }
            }
            if(chan==1){ //gana pati
                if(noteNum > 59 & noteNum < 71){
                    xmit.startMsg("/ganapati,ii");
                    oscOut(noteNum, vel);
                }
            }
            if(chan==2){ //breakbot
                if(noteNum > 59 & noteNum < 86){
                    xmit.startMsg("/drumbot,ii");
                    oscOut(noteNum, vel);
                }
            }
            if(chan==3){ //clappers
                if(noteNum>59 & noteNum<81){
                    xmit.startMsg("/clappers,ii");
                    oscOut(noteNum, vel);
                }
            }
            if(chan==4){ //jack guitar
                if(noteNum>59 & noteNum<101){
                    xmit.startMsg("/jackgtr,ii");
                    oscOut(noteNum,vel);
                }
            }
            if(chan==5){ //jack guitar
                if(noteNum>59 & noteNum<89){
                    xmit.startMsg("/jackperc,ii");
                    oscOut(noteNum,vel);
                }
            }
        }
    }
}

// functions
fun void oscOut(int newNoteNum, int newVel){
    xmit.addInt(newNoteNum-60);
    xmit.addInt(newVel);
}