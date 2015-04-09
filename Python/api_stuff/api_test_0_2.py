import time
import requests
from bs4 import BeautifulSoup

def lightSpider():
    url = 'http://www.lightningmaps.org/realtime'
    sourceCode = requests.get(url)#connect to webpage and store results
    print(sourceCode)
    print("--------------------")
    time.sleep(1)
    plainText = sourceCode.text
    print(plainText)
    print("----------\\\\\\\\\\\]]]]]]]]]]]]]]]]---------------------------")
    time.sleep(3)
    soup = BeautifulSoup(plainText)
    print(soup)
    #extract center child number 2 (1 if indexed 0)

lightSpider()
