import serial, time, random, array

snapperBot = serial.Serial('/dev/tty.usbmodem1d1141', 9600, timeout = 0.1)
time.sleep(1)

#array.array(randomBot, randomMsg).tostring()

def randomTest():
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
    time.sleep(0.05)

def writeSerial(botNum, messageByte):
    flag = chr(255)
    botChar = chr(botNum)
    msgChar = chr(messageByte)
    msgString = (flag, botChar, msgChar)
    snapperBot.write(msgString)
    #snapperBot.write(botChar)
    #snapperBot.write(msgChar)
    print(msgString)

while True:
    for i in range(0,300):
        randomTest()
    for i in range(0,6):
        for ii in range(0,255):
            line = snapperBot.readline()
            print("incomming line : ",line)
            writeSerial(i, ii)
            time.sleep(0.02)
            #print(i, ii)
