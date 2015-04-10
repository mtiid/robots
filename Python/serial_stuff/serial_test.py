import serial, time

#create new serial object called snapperBot on port /dev(taken from arduino ide), with baud rate of 115200 and timeout of .1 seconds
snapperBot = serial.Serial('/dev/tty.usbmodem1d1141', 9600, timeout=.1)
time.sleep(1)#give connection one second to establish

snapperBot.write("Hello SnapperBot")

while True:
    snapperBot.write(
    data = snapperBot.readline()
    if data:
        print data.rstrip('\n')#strip out the new lines

