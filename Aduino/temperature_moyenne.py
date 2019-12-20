import si7021
from i2c_lcd8050 import I2cLcd
#import machine
from machine import I2C, Pin
from time import sleep_ms, ticks_ms, sleep
import urequests

DEFAULT_I2C_ADDR = 0x27
i2c = I2C(-1,Pin(0), Pin(2))
lcd = I2cLcd(i2c, DEFAULT_I2C_ADDR, 2, 16)

def moy_data():
    # datatype can be relative_humidity or temperature
    temp_sensor = si7021.Si7021(i2c)
    temp_raw = 0
    hum_raw = 0
    for i in range(1,11):
        #print(i)
        #print(temp_sensor.temperature)
        temp_raw += temp_sensor.temperature
        hum_raw += temp_sensor.relative_humidity
        sleep(1)
    moy_t=temp_raw/10
    moy_hum=hum_raw/10
    return moy_t,moy_hum

lcd.clear()
lcd.putstr('Please wait mesure in progress')
while True:

    data = moy_data()
    print("Temperature="+str(round(data[0],1))+"°C")
    print("Humidite="+str(round(data[1],1))+"%")
        
    lcd.clear()
    lcd.putstr('TEMP:  {value}\n'.format(value=str(round(data[0],1))+"C"))
    lcd.putstr('HUM:  {value}\n'.format(value=str(round(data[1],1))+"%"))
#print(moy_hum(temp_sensor))
        
