// ===================================================================
//  File: BreakBot.ck
//  Defines BreakBots's OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================
public class BreakBot extends Bot{
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/drumBot","ii",toClient);
        midiInit("KarmetiK_BreakBot");
        data.size(2);
        25=>numAct;
    }
}

// trigger legend:
// 0: kick a
// 1: kick b
// 2: snare mallet
// 3: snare mallet (missing)
// 4:
// 5: brush rotate
// 6: right cymbal (wire beater)
// 7: right cymbal ???
// 8: right cymbal (drum stick)
// 9: right cymbal (mute)
//10: left cymbal (broken mallet)
//11: left cymbal (left mallet)
//12: left cymbal (right mallet)
//13 left cymbal (right mallet again!?!?)