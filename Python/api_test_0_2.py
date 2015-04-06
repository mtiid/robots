import time
import requests
from bs4 import BeautifulSoup

def lightSpider():
    url = 'http://wwlln.net/new/map/'
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
    #script src="http://wwlln.net/new/wordpress/../map/js/lightning.js" type="text/javascript"


lightSpider()
