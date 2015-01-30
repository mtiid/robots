// ===================================================================
//  File: Bot.ck
//  Machine Orchestra base Bot class
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================

public class Bot{
    // incoming OSC
    OscRecv orec;
    OscEvent trigger;
    string addrPat;
    // midi to robot
    MidiOut mout;
    MidiMsg msg;
    // extra OSC functionality
    OscSend toClient[0]; // for bouncing incoming OSC back to clients
    OscSend toVisuals;   // for bouncing incoming OSC somewhere to control visuals
    
    int data[0]; // for holding OSC arguments; resize in child class for expected number of arguments
    int numAct;  // number of actuators/triggers


    // private initializer to be called in child initializer
    // (due to unimplemented super functionality)
    fun void _init(OscRecv nOrec,string nAddrPat,string args,OscSend nToClient[]){
        nOrec@=>orec;
        nAddrPat=>addrPat;
        chout<=addrPat<=","<=args<=IO.nl();
        nToClient@=>toClient;
        orec.event(addrPat+","+args)@=>trigger;
        spork~triggerLoop();
    }
    
    fun void midiInit(string port){
        if(!mout.open(port))cherr<="Couldn't open "<=port<=IO.nl();
    }
        
    fun void triggerLoop(){  // override following functions in child if different arguments are needed
        while(trigger=>now){
            while(trigger.nextMsg()){
                trigger.getInt()=>data[0];
                trigger.getInt()=>data[1];
                chout<="Msg received: "<=data[0]<=IO.nl();
                if(data[1]>127)
                    127=>data[1];
                if(data[1]<0)
                    0=>data[1];
                if(data[0]>=0 & data[0]<numAct){
                    chout<=data[0]<=IO.nl();
                    midiSend(0x90,data[0],data[1]);
                    echoOsc(data[0],data[1]);
                }
            }
        }
    }
    
    fun int numberOfActuators(){ return numAct; }
    
    fun void midiSend(int d1,int d2,int d3){
        d1=>msg.data1;
        d2=>msg.data2;
        d3=>msg.data3;
        mout.send(msg);
    }
    
    fun void echoOsc(int data0,int data1){
        for(int i;i<toClient.cap();i++){
            addrPat+",ii"=>string pattern;
            toClient[i].startMsg(pattern);
            toClient[i].addInt(data0);
            toClient[i].addInt(data1);
        }
    }  
}