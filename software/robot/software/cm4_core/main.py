import random
import time

from cm4_core.utils.teleplot import sendValue


def main():
    while True:
        x = random.randint(1, 100)
        y = random.randint(1, 100)
        sendValue('x', x)
        sendValue('y', y)
        time.sleep(0.1)


if __name__ == '__main__':
    main()
