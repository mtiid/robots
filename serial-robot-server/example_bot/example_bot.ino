// ID number of the arduino, each robot must have a different one
#define arduinoID 0

// stores our incoming values
char bytes[2];
int handshake;

void setup() {
  // start serial port at 57600 bps and wait for port to open
  Serial.begin(57600);
}

void loop() {
  if (Serial.available()) {
    // parity byte
    if (Serial.read() == 0xff) {
      // reads in a two index array from ChucK
      Serial.readBytes(bytes, 2);

      // bit wise operations
      // ~~~~~~~~~~~~~~~~~~~
      // reads the first six bits for the note number
      // then reads the last ten bits for the note velocity
      int num = byte(bytes[0]) >> 2;
      int vel = (byte(bytes[0]) << 8 | byte(bytes[1])) & 1023;

      // message required for "handshake" to occur
      // happens once per Arduino at the start of the ChucK serial code
      if (num == 63 && vel == 1023 && handshake == 0) {
        Serial.write(arduinoID);
        handshake = 1;
      }
      else {
        digitalWrite(num, vel);
      }
    }
  }
}
