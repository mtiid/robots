import OSC, random, time
c = OSC.OSCClient()
c.connect(('127.0.0.1', 40000))
while 1 :
	oscmsg = OSC.OSCMessage()
	oscmsg.setAddress("/switch")
	oscmsg.append(255)
	oscmsg.append(random.randint(0,2))
	oscmsg.append(random.randint(0,254))
	c.send(oscmsg)
	time.sleep(0.5)
	print(oscmsg)
