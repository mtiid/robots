// HandshakeID.ck
// Eric Heep
// creates a static instantiation of the Handshake class
// allows child bot classes to send serial through it

// CalArts Music Tech
// MTIID4LIFE

public class HandshakeID {
    static Handshake @ talk;
}

new Handshake @=> HandshakeID.talk;
