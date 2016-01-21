# SnapperBot code
A rotary switch music robot system

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By Nathan Villicana-Shaw
CalArts MTIID : Spring 2015
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ChucK serial is buggy in this current version use python SB_serialosc.py instead, this suports OSC now under the flag /switch

    it expects three ints,
        1. botNum (0-5)
        2. arrayNumber (0-2)
        3. velocity (1-8)

If it does not run, double check your port names in the code for the arduino :

you can test the OSC using the osc_sender_test.ck files in the chuck folder, this will randomly spit out all the possible OSC values the python main code will be expecting (note by default the code uses port 40000 as this is the same port as the robot network in the Machine Lab)

Note : 

To Do :
    rewrite protocol to use only two bytes, with MSB as flag bit make .txt document explaining protocol like owens
    add functions in python code to do cool shit
    
