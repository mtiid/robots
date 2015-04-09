import serial, time, random, array
#imports for the serial stuff
import argparse
import math
from pythonosc import dispatcher
from pythonosc import osc_server

snapperBot = serial.Serial('/dev/cu.usbmodem1a1241', 9600, timeout = 0.1)
time.sleep(4)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ip",
        default="127.0.0.1", help="The ip to listen on")
    parser.add_argument("--port",
        type=int, default=40000, help="The port to listen on")
    args = parser.parse_args()

    dispatcher = dispatcher.Dispatcher()
    dispatcher.map("/switch")
    #dispatcher.map("/volume", print_volume_handler, "Volume")

    server = osc_server.ThreadingOSCUDPServer(
        (args.ip, args.port), dispatcher)
    print("Serving on {}".format(server.server_address))
    server.serve_forever()

#randomMsg).tostring()



# Functions for testing Serial connection to the snapperbots
def randomTest(sleepTime):
    flag = 255
    #get random numbers to send
    randomBot = random.randint(0,6)
    randomMsg = random.randint(0, 255)
    #convert them to chars
    botChar = chr(randomBot)
    msgChar = chr(randomMsg)
    #add the chars together to form a string
    msgString = (flag, botChar, msgChar)
    print(msgString)
    #write string to serial port
    #snapperBot.write(msgString)
    snapperBot.write(msgString);
    #wait 200ms before repeating
    time.sleep(sleepTime)

# Function to write to the SnapperBots
def writeSerial(botNum, messageByte):
    flag = chr(255)
    botChar = chr(botNum)
    msgChar = chr(messageByte)
    msgString = (flag, botChar, msgChar)
    snapperBot.write(msgString)
    #snapperBot.write(botChar)
    #snapperBot.write(msgChar)
    print(msgString)

