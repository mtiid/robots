// -----------------------------
// Watchdog.ck
// Coded by Nathan Villicana-Shaw
// for MTIID
// Spring 2017
// Sends note off messages to all bots after 
// the server is not being used for a while
// keeps the solenoids safe
// -----------------------------

public class Watchdog{
    now => time lastPing;
    30::second => dur waitTime;
    1 => int isHot;
    <<<"----------------------------">>>;
    <<<"Initializing Watchdog">>>;
    <<<"----------------------------">>>;

    fun void ping(){
        now => lastPing;
        1 => isHot;
    }

    // keep checking when last ping was sent
    fun void watch() {
        while (true) {
            if (now > lastPing + waitTime && isHot) {
                // send note off to all bots
                <<<"----------------------------">>>;
                <<<"WATCHDOG ACTIVATED">>>;
                <<<"Sending note off to all bots">>>;
                <<<"----------------------------">>>;
                10::second => now;
                0 => isHot;
            }
            10::second => now;
        }
    }
}
