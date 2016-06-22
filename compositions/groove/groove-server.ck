// value of 8th
0.10::second => dur T;
// number of targets
1 => int targets;
// port
6449 => int port;

// send objects
OscSend xmit[targets];

// aim the transmitter at port
xmit[0].setHost ( "localhost", port );

int x;
int y;
int z;

0 => int W_OFFSET;
0 => int H_OFFSET;
8 => int WIDTH;
4 => int HEIGHT;

// infinite time loop
while( true )
{
    for( H_OFFSET => y; y < H_OFFSET+HEIGHT; y++ )
        for( W_OFFSET => x; x < W_OFFSET+WIDTH; x++ )
        {
            for( 0 => z; z < targets; z++ )
            {
                // start the message...
                xmit[z].startMsg( "/plork/synch/clock", "i i" );

                // a message is kicked as soon as it is complete
                x => xmit[z].addInt; y => xmit[z].addInt;

                xmit[z].startMsg( "/plork/synch/filter", "f f" );
                Math.random2f(100, 500) => xmit[z].addFloat;
                Math.random2f(0.5, 2) => xmit[z].addFloat;
            }

            // advance time
            T => now;
        }
}
