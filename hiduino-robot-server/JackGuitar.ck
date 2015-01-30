// ====================================================================
//  File: JackGuitar.ck
//  Defines JackBox's guitar OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ====================================================================
public class JackGuitar extends Bot{
    int GuitarNotes[0];
    
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/jackgtr","ii",toClient);
        midiInit("KarmetiK_JackBox Port A");
        data.size(2);
        for(52=>int i; i<86; i++) GuitarNotes<<i;
        GuitarNotes.cap()=>numAct;
    }
    
    fun void triggerLoop(){ // overriding Bot base definition
        while(trigger=>now){
            while(trigger.nextMsg()){
                trigger.getInt()=>data[0];
                trigger.getInt()=>data[1];
                if(data[1]>127)127=>data[1];
                if(data[1]<0)0=>data[1];
                if(data[0]>=0&data[0]<numAct){
                    if(data[1]>0){
                        midiSend(144,GuitarNotes[data[0]],data[1]);
                        <<<data[0]>>>;
                    }
                    else{
                        midiSend(128,GuitarNotes[data[0]],127);
                    }
                    echoOsc(data[0],data[1]);
                }
            }
        }
    }   
}