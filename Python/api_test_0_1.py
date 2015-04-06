
from urllib2 import Request, urlopen, URLError

request = Request('http://wwlln.net/new/map/')

try:
    response = urlopen(request)
    kittens = response.read()
    print kittens[559:1000]
except URLError, e:
    print 'No kittez. Got an error code:', e
