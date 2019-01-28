#!/usr/bin/env python3
import RPi.GPIO as GPIO
import time
import os
import signal

print "Power Button Monitor."

GPIO.setmode(GPIO.BCM)

GPIO.setup(21, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)

def button_pressed(channel):
    print "Button pushed"
    os.system("sudo shutdown now")
    
GPIO.add_event_detect(21, GPIO.RISING, callback=button_pressed, bouncetime=300)

signal.pause()
