import copy
import ctypes
import math
import os
import time
from os import path
import sys

sys.path.append("/home/pi/software/")

from cm4_core.utils.json import readJSON, writeJSON
from robot.TWIPR.simple.simple_twipr import SimpleTWIPR
from robot.TWIPR.utils.trajectory import transform_input_2d_3d, getSignal
import cm4_core.utils.joystick.rpi_joystick as rpi_joystick





Ts = 0.01

K = [0.025, 0.04, 0.007, 0.012,
     0.025, 0.04, 0.007, -0.012]

# offset = +0.0033
offset = +0.0


def joystick_control_with_offset():
    twipr = SimpleTWIPR(K)

    joystick = rpi_joystick.RpiJoystick()
    joystick.set_callback(event=rpi_joystick.A, callback=twipr.startBalancing)
    joystick.set_callback(event=rpi_joystick.B, callback=twipr.stopBalancing)

    while True:
        val1 = joystick.axes[1] * (-0.03) + offset
        val2 = joystick.axes[2] * 0.06
        twipr.setInput([val1 + val2, val1 - val2])
        time.sleep(0.1)


def balance():
    twipr = SimpleTWIPR()
    twipr.startBalancing()
    time.sleep(10)
    twipr.stopBalancing()
    time.sleep(1)


if __name__ == '__main__':
    joystick_control_with_offset()
