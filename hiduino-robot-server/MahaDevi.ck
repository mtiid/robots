// ===================================================================
//  File: MahaDevi.ck
//  Defines MahaDevi's OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================
public class MahaDevi extends Bot{
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/devibot","ii",toClient);
        midiInit("KarmetiK_MahaDeviBot");
        data.size(2);
        13=>numAct;
    }
}

// trigger legend:
// 0: drum 0
// 1: drum 2
// 2: drum 3
// 3: drum 1 (broken)
// 4: cymbal
// 5: really quiet
// 6: slat stack
// 7: tamborine paddle
// 8: finger cymbals
// 9: head
// 10: top drum 1
// 11: top drum2 (worrisome rattle?)
// 12: ??? (no longer present)
