import mido
from mido import MidiFile

output = mido.open_output()
fileName = "~/Desktop/mbot.midi"

for msg in MidiFile(fileName).play():
    output.send(msg)
    print(msg)
