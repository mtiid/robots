// ===================================================================
//  File: JackPerc.ck
//  Defines JackBox's percussion OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================
public class JackPerc extends Bot{
    [32, 33, 34, 35, 36, 37, 38, 39, 40, 
     41, 42, 43, 44, 45, 46, 47, 48, 49, 
     50, 51, 52, 53, 54, 55, 56, 57, 58, 59] @=> int PercNotes[];
    
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/jackperc","ii",toClient);
        midiInit("KarmetiK_JackBox Port A");
        data.size(2);
        PercNotes.cap()=>numAct;
    }
    
    fun void triggerLoop(){ // overriding Bot base definition
        while(trigger=>now){
            while(trigger.nextMsg()){
                trigger.getInt()=>data[0];
                trigger.getInt()=>data[1];
                if(data[1]>127)127=>data[1];
                if(data[1]<0)0=>data[1];
                if(data[0]>=0&data[0]<numAct){
                    midiSend(152,PercNotes[data[0]],data[1]);
                    echoOsc(data[0],data[1]);
                }
            }
        }
    }  
}