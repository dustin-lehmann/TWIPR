import ctypes
import time
from ctypes import sizeof

import robot.TWIPR.communication.spi.ll_sample as ll_sample
import serial

from cm4_core.communication.serial.serial_interface import Serial_Interface
from cm4_core.utils.stm32.stm32 import stm32_reset
from control_board.board_utils import reset_uart
from robot.TWIPR.communication.serial.twipr_comm_serial import TWIPR_Serial_Interface


def simplest_uart():
    serial_device = serial.Serial('/dev/ttyAMA1', baudrate=1000000, timeout=10)

    data = b"HELLO"

    serial_device.write(data)
    time.sleep(1)


def uart_interface():
    time.sleep(1)
    reset_uart()
    interface = Serial_Interface(port='/dev/ttyAMA1', baudrate=1000000)
    interface.init()
    interface.start()

    data = 1

    for i in range(0, 10):
        interface.function(module=0x01, address=0x01, data=data, input_type=ctypes.c_uint8)
        data = not data
        time.sleep(0.25)

    time.sleep(1)

def twipr_serial_interface():
    interface=TWIPR_Serial_Interface()



if __name__ == '__main__':
    uart_interface()
