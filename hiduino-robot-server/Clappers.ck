// ===================================================================
//  File: Clappers.ck
//  Defines Clappers' OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================
public class Clappers extends Bot{
    
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/clappers","ii",toClient);
        midiInit("KarmetiK_Clappers");
        data.size(2);
        20=>numAct;
    }
}

// non-functioning triggers: 0 4 5 9
