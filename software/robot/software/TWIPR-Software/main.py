from robot.twipr import TWIPR
import time
import logging

logging.basicConfig(level=logging.DEBUG)

def main():
    twipr = TWIPR()
    twipr.init()
    twipr.start()

    while True:
        time.sleep(1)


if __name__ == '__main__':
    main()
