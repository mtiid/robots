"""
machine_lab_demo.py

Script written to aid with demonstrating the awesome power that
is the MTIID Machine Lab.

Written by,
Nathan Villicana-Shaw in the spring of 2017

In order to add a new composition to the demo:
    1. Add the program into the compositions/chuck folder, put it into its
    own folder that had the same name as the composition (please use "_" instead of " ".)
    2. add the folder name and file name to the list below

TODO
figure out way to include
    - date composed
    - composer and year level when written
    - any composer notes
"""
import time
import sys
import os


comp_path = "~/git/robots/compositions/"
"""
    {
        "name": "Beetles",
        "path": "Beetles/beetles.ck",
        "composers": ["Nathan Villicana-Shaw"],
        "length": "4 Minutes",
        "format": "ChucK",
        "notes": "Exploration in sub-velocities with the Marimbot and Lydia.",
        "date": "November, 2014"
    },
"""

compositions = [
    {
        "name": "2 Minute Phase",
        "path": "2-minute-phase/2-minute-phase.ck --port:8890",
        "composers": ["Eric Heep"],
        "length": "2 Minutes",
        "format": "ChucK",
        "notes": "",
        "date": "April, 2015"
    },
    {
        "name": "5 Minute Phase",
        "path": "5-minute-phase/5-minute-phase.ck --port:8890",
        "composers": ["Eric Heep"],
        "length": "5 Minutes",
        "format": "ChucK",
        "notes": "",
        "date": "April, 2015"
    },
    {
        "name": "Groove",
        "path": "groove/groove-server.ck --port:8890 & sleep 1 & open ~/git/robots/compositions/groove/groove-bot",
        "composers": ["Daniel Reyes", "Eric Heep"],
        "length": "Step sequencer, no determined length",
        "format": "ChucK",
        "notes": "A sequencing program coded for interfacing with the robots",
        "date": ""
    },
    {
        "name": "The Pantheon",
        "path": "The-Pantheon/the_pantheon_machine_lab_mac.als",
        "composers": ["Nathan Villicana-Shaw"],
        "length": "4 Minutes",
        "format": "Ableton",
        "notes": "Once Ableton opens just hit play and you are good to go.",
        "date": "November, 2016"
    },
]


def playComposition():

    print("What composition would you like to play?")
    print("- - - - - - - - - - - - - - - - - - - - -")

    for index, composition in enumerate(compositions):
        print(index, " : ", composition['name'],
              composition['format'], composition['notes'])
    print("- - - - - - - - - - - - - - - - - - - - -")
    print('Please type the number of the composition ' +
          'you would like to play or "exit()" to close the program')
    print("")
    playedComposition = False

    # read in what number is entered
    user_input = int(input())
    print(type(user_input))

    if type(user_input) == int and user_input < len(compositions):
        print("- - - - - - - - - - - - - - - - - - - - - - - - -")
        print("Fantastic! Here is ", compositions[user_input]['name'])
        for index, composition in enumerate(compositions):
            if index == int(user_input):
                print("- - - - - - - - - - - - - - - - - - - - - - - - -")
                print("title       : ", composition['name'])
                print("composer(s) : ", composition['composers'])
                print("date        : ", composition['date'])
                print("notes       : ", composition['notes'])
                print("format      : ", composition['format'])
                print("- - - - - - - - - - - - - - - - - - - - - - - - -")
                print("Starting composition...")

                # PLAY THE ACTUAL COMPOSITION
                command = ''
                if "chuck" in composition['format'].lower():
                    command = "chuck " + comp_path + composition['path']
                elif "ableton" in composition['format'].lower():
                    command = "open " + comp_path + "ableton_sets/" + composition['path']

                print(command)
                os.system(command)
                playedComposition = True
        print('- - - - - - - - - - - - - - - - - - - - - - - - -')

    elif type(user_input) == int:
        print("- - - - - - - - - - - - - - - - - - - - - - - - -")
        print("Sorry there is no composition number ", user_input)
        print('- - - - - - - - - - - - - - - - - - - - - - - - -')

    elif type(user_input) == "Quitter":
        print("- - - - - - - - - - - - - - - - - - - - - - - - -")
        print("Thank you for using the demo script, goodbye!")
        print('- - - - - - - - - - - - - - - - - - - - - - - - -')
        sys.exit()

    if playedComposition is False:
        print('- - - - - - - - - - - - - - - - - - - - - - - - -')
        print("Sorry, ", user_input,
              " is not a command I understand ...")
        return playedComposition

    # if we played a composition exit out of script
    print("- - - - - - - - - - - - - - - - - - - - - - - - -")
    print("Thank you for using the demo script, goodbye!")
    print('- - - - - - - - - - - - - - - - - - - - - - - - -')
    sys.exit()

#####################
print("_________________________________")
print("Welcome to the MTIID demo script!")
print("- - - - - - - - - - - - - - - - -")
time.sleep(0.25)
while True:
    playComposition()
