// Handshake.ck
// Eric Heep
// communicates with the Arduinos, pairs them up with the ports
// CalArts Music Tech // MTIID4LIFE

public class Handshake { 

    SerialIO.list() @=> string list[];
    int serial_port[list.cap()];
    
    // calls num_ports() to find how many USB ports are available
    SerialIO serial[num_ports()];
    int robotID[serial.cap()];

    fun void init() { 
        for (int i; i < robotID.cap(); i++) {
            i => robotID[i];
        }
        open_ports();
        handshake();
    } 

    // returns the proper robot ID to the child class
    fun int port(int ID) {
        return serial_port[robotID[ID]];
    }

    // returns how many usb serial connections are available
    fun int num_ports() {
        int num;
        <<< "-", "" >>>;
        for (int i; i < serial_port.cap(); i++) {
            if (list[i].find("usb") > 0) {
                i => serial_port[num];
                num++;
            }
        }
        <<< "Found", num, "available USB ports:", "" >>>;
        return num;
    }
   
    // opens only how many serial ports there are usb ports connected
    fun void open_ports() {
        for (int i; i < serial.cap(); i++) {
            if (!serial[i].open(serial_port[i], SerialIO.B57600, SerialIO.BINARY)) {
                <<< "Unable to open serial device:", "\t", list[serial_port[i]] >>>;
            }
            else {
                <<< list[serial_port[i]], "assigned to port", serial_port[i], "" >>>;
            }
        }
        <<< "-", "" >>>;
        2.5::second => now;
    }

    // pings the Arduinos and returns their 'arduinoID'
    fun void handshake() {
        [255, 255, 255] @=> int ping[];
        for (int i ; i < serial.cap(); i++) {
            // <<< "Testing port : ", i>>>;
            serial[i].writeBytes(ping);
            serial[i].onByte() => now;
            serial[i].getByte() => int arduinoID;
            <<< "arduin id : ", arduinoID>>>;
            arduinoID => robotID[i];
        }
    }

    // bitwise operations, allows note numbers 0-63 and note velocities 0-1023
    fun void note(int ID, int num, int vel) {
        int bytes[3];
        0xff => bytes[0];
        (num << 2) | (vel >> 8) => bytes[1]; 
        vel & 255 => bytes[2];
        serial[ID].writeBytes(bytes);
    }
}
