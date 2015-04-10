import pywapi
import string
from os import system

weather_com_result = pywapi.get_weather_from_weather_com('91355')
yahoo_result = pywapi.get_weather_from_yahoo('95959')
noaa_result = pywapi.get_weather_from_noaa('KJFK')

system('say ' +  "Weather.com says: It is " + string.lower(weather_com_result['current_conditions']['text']) + " and " + weather_com_result['current_conditions']['temperature'] + "C now in Santa Clarita.\n\n")

system( 'say ' + "Yahoo says: It is " + string.lower(yahoo_result['condition']['text']) + " and " + yahoo_result['condition']['temp'] + "C now in Nevada City.\n\n")

system('say ' +  "NOAA says: It is " + string.lower(noaa_result['weather']) + " and " + noaa_result['temp_c'] + "C now in San Francisco.\n")
#the first is zip code, returns a dictionary of weather data that exists in XML feed
#pywapi.get_weather_from_yahoo(95959, units='metric')
