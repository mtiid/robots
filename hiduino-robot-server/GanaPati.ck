// ===================================================================
//  File: GanaPati.ck
//  Defines GanaPati's OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================
public class GanaPati extends Bot{
    
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/ganapati","ii",toClient);
        midiInit("KarmetiK_GanaPatiBot");
        data.size(2);
        10=>numAct;
    }
}

// non-functioning triggers: 0 4 5 9
