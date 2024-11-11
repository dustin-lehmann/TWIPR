from RPi import GPIO
import control_board.settings as board_settings


def reset_uart(pin):
    print("RESET UART")
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(pin, GPIO.OUT)
    GPIO.output(pin, 1)
    GPIO.output(pin, 0)
    GPIO.cleanup()
