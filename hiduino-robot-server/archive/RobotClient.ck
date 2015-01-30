//     ^^^^^^ insert IAC Bus name above if in midiaudicle, then hit add shred ^^^^^^^
MidiIn min;
MidiMsg msg;
OscSend xmit;

if(me.args()) min.open(me.arg(0)); 
else min.open("IAC Bus 1"); //default name of a new IAC Bus 

int status, chan, noteNum, vel;

while(min=>now){ //midi loop
    while(min.recv(msg)){
        
        (msg.data1 & 0x90)>>4 => status;
        (msg.data1 & 0x0F) => chan;
        
        if(status==9){ // note on
            
            msg.data2 => noteNum;
            msg.data3 * midiNorm => vel;
            
            if(chan==0){ //maha devi
                if(noteNum > 60 & noteNum < 74){
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
                if(noteNum > 59 & noteNum < 81){
                    xmit.startMsg("/clappers,ii");
                    oscOut(noteNum, vel);
                }
            }
        }
    }
}

// Functions
fun void oscOut(int newNoteNum, int newVel){
    xmit.addInt(newNoteNum-60);
    xmit.addint(newVel);
}

fun void init(string hostName,int port){
    hostName=>myHostName;
    port=>myPort;
    xmit.setHost("chuckServer.local",11235);
    connect();
}

fun void connect(){
    xmit.startMsg("/addClient,si");
    xmit.addString(myHostName);
    xmit.addInt(myPort);
}