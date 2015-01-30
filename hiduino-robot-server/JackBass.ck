// ===================================================================
//  File: JackBass.ck
//  Defines JackBox's bass OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================
public class JackBass extends Bot{
    int BassNotes[0];
    Shred closerShreds[]; // protects against duplicate stringCloser shreds
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/jackbass","ii",toClient);
        midiInit("KarmetiK_JackBox Port A");
        data.size(2);
        for(28=>int i; i<52; i++) BassNotes << i;
        BassNotes.cap()=>numAct;
        new Shred[numAct] @=> closerShreds;
    }
    
    fun void triggerLoop(){  // overriding Bot base definition
        while(trigger=>now){
            while(trigger.nextMsg()){
                trigger.getInt()=>data[0];
                trigger.getInt()=>data[1];
                if(data[1]>127)127=>data[1];
                if(data[1]<0)0=>data[1];
                if(data[0]>=0&data[0]<numAct){
                    closerShreds[BassNotes[data[0]]-28].exit(); // close possible old shred
                    if(data[1]>0){
                        midiSend(0x91,BassNotes[data[0]],data[1]);
                        spork ~ stringCloser(BassNotes[data[0]]) @=> Shred newCloserShred;
                        newCloserShred @=> closerShreds[BassNotes[data[0]]-28];
                    }
                    else{
                        midiSend(0x81,BassNotes[data[0]],127);
                    }
                    echoOsc(data[0],data[1]);
                }
            }
        }
    }
    
    // makes sure a string damper isn't left down (keeps solenoids from over-heating)
    fun void stringCloser(int CC){ 
        now+2::minute=>time waitTime;
        while(now<waitTime) samp=>now; // divide wait into samps so shred can be exited 
        midiSend(0x81,CC,127);
    }
    
}