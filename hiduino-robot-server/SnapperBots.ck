// ===================================================================
//  File: Clappers.ck
//  Defines Clappers' OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================
public class SnapperBots extends Bot{
    
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/snapperbot1","ii",toClient);
        midiInit("Nathans_Snappers");
        data.size(2);
        20=>numAct;
    }
}
