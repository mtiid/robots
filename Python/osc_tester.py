import OSC, random
c = OSC.OSCClient()
c.connect(('127.0.0.1', 40000))
oscmsg = OSC.OSCMessage()
oscmsg.setAddress("/switch")
oscmsg.append(255)
oscmsg.append(random.randint(0,2))
oscmsg.append(random.randint(0,254))
c.send(oscmsg)
