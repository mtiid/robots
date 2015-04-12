import serial, time, random, array
#imports for OSC
import OSC, threading
#Serial initalize
snapperBot = serial.Serial('/dev/ttyACM0', 9600, timeout = 0.1)

time.sleep(6)

def switch_handler(addr, tags, stuff, source):
    multiSwitch(stuff[0], stuff[1], stuff[2])

#this is for troubleshotting the OSC
def printing_handler(addr, tags, stuff, source):
    print "---"
    print "received new osc msg from %s" % OSC.getUrlStr(source)
    print "with addr : %s" % addr
    print "typetags %s" % tags
    print "data %s" % stuff
    print "---"

def randomTest():
    flag = 255
    #get random numbers to send
    randomBot = random.randint(0,0)
    randomMsg = random.randint(0, 254)
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
    time.sleep(0.005)

def writeSerial(botNum, messageByte):
    flag = chr(255)
    botChar = chr(botNum)
    msgChar = chr(messageByte)
    msgString = (flag, botChar, msgChar)
    snapperBot.write(msgString)
    #snapperBot.write(botChar)
    #snapperBot.write(msgChar)
    print(msgString)

#-------------------------------------------------
#           SnapperBot Command Functions
#-------------------------------------------------

def singleSwitch(botNum, bankNum, switchNum):
    msgByte = (bankNum << 4)
    msgByte = (switchNum << 1) | msgByte
    writeSerial(botNum, msgByte)
    #print("singleSwitch : ", botNum, ',', bankNum,',' , switchNum)

def multiSwitch(botNum, bankNum, velocity):
    msgByte = (bankNum << 4) | 64
    msgByte = (velocity << 1) | msgByte
    writeSerial(botNum, msgByte)
    #print("multiSwitch : ", botNum, ',', bankNum,',' , velocity)

#-------------------------------------------------
#                    Test Loop
#-------------------------------------------------

def test():
    while True:
        for i in range(0,90):
            multiSwitch(0,0,random.randint(0,7))
            multiSwitch(0,1,random.randint(0,7))
            multiSwitch(0,2,random.randint(0,7))
            time.sleep(0.037)
        for i in range(0,60):
            singleSwitch(0,random.randint(0,3),random.randint(0,7))
            time.sleep(.06125)
        for i in range(0,30):
            multiSwitch(0,random.randint(0,3),random.randint(0,7))
            time.sleep(0.125)
        for i in range(0,100):
            randomTest()
        for i in range(0,1):
            for ii in range(0,254):
                line = snapperBot.readline()
                #print("incomming line : ",line)
                writeSerial(i, ii)
                time.sleep(0.002)
                #print(i, ii)

#-------------------------------------------------
#                    Mail Loop
#-------------------------------------------------

receive_address = '127.0.0.1', 40000
osc = OSC.OSCServer(receive_address)
osc.addDefaultHandlers()
osc.addMsgHandler("/switch", switch_handler) # adding our function
# just checking which handlers we have added
print "Registered Callback-functions are :"
for addr in osc.getOSCAddressSpace():
    print addr
# Start OSCServer
print "\nStarting OSCServer. Use ctrl-C to quit."
st = threading.Thread( target = osc.serve_forever )
st.start()

try :
    while 1 :
        time.sleep(5)

except KeyboardInterrupt :
    print "\nClosing OSCServer."
    osc.close()
    print "Waiting for Server-thread to finish"
    st.join() ##!!!
    print "Done"
