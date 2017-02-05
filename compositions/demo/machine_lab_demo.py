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
figure out way to incluede
    - date composed
    - composer and year level when written
    - any composer notes
"""
import time
import sys

compositions = [
    {
        "name": "Beatles",
        "path": "Beatles/main.ck",
        "composers": ["Nathan Villicana-Shaw"],
        "length": "8 Minutes",
        "notes": "Exploraiton in sub-velocities",
        "date": "fall 2014"
    }
    ,{
        "name": "5 Minute Phase",
        "path": "5-Minute_Phase/main.ck",
        "composers": ["Eric Heep"],
        "length": "5 Minutes",
        "notes": "",
        "date": ""
    }
]


def playComposition():

    print("What composition would you like to play?")
    print("- - - - - - - - - - - - - - - - - - - - -")

    for index, composition in enumerate(compositions):
        print(index, " : ", composition['name'])
    print("- - - - - - - - - - - - - - - - - - - - -")
    print('Please type the number of the composition you would like to play or "exit" to close the program')
    print()
    playedComposition = False;

# read in what number is entered
    user_input = input()

# if they entered in exit then close the program
    if 'e' in user_input or 'E' in user_input:
        print("- - - - - - - - - - - - - - - - - - - - - - - - -")
        print("Thank you for using the demo script, goodbye!")
        print('- - - - - - - - - - - - - - - - - - - - - - - - -')
        sys.exit()

    for index, composition in enumerate(compositions):
        if index == int(user_input):
            print("- - - - - - - - - - - - - - - - - - - - - - - - -")
            print("title       : ", composition['name'])
            print("composer(s) : ", composition['composers'])
            print("date        : ", composition['date'])
            print("notes       : ", composition['notes'])
            print("- - - - - - - - - - - - - - - - - - - - - - - - -")
            print("Starting composition...")
            # PLAY THE ACTUAL COMPOSITION
            # TODO
            time.sleep(3);
            print("- - - - - - - - - - - - - - - - - - - - - - - - -")
            print("Composition finished...")
            playedComposition = True

    if playedComposition is False:
        print('- - - - - - - - - - - - - - - - - - - - - - - - -')
        print("Sorry, ", user_input, " is not a command I understand ...")

    return playedComposition

#####################
print("_________________________________")
print("Welcome to the MTIID demo script!")
print("- - - - - - - - - - - - - - - - -")
time.sleep(0.25)
while True:
    playComposition()
