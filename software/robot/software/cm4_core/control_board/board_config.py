import cm4_core.utils.json_utils as json_utils
import json
import uuid
from pathlib import Path
import os

config_file_path = os.path.expanduser('~/board_config.json')


# ======================================================================================================================
def getBoardConfig():
    # First check if the files exist

    config = {}
    with open(config_file_path) as config_file:
        config = {**config, **json.load(config_file)}

    return config


# ======================================================================================================================
def generate_board_config(rev):
    if rev == 'rev3':
        board_config = {
            'rev': 'rev3',
            'pins': {
                'SX1508_PIN_LED': 3,
                'GPIO_INTERRUPT_NEW_SAMPLES': 16,
                'RC_GPIO_UART_RESET': 5,
            }
        }
    elif rev == 'rev4':
        board_config = {
            'rev': 'rev4',
            'pins': {
                'SX1508_PIN_LED': 3,
                'GPIO_INTERRUPT_NEW_SAMPLES': 6,
                'RC_GPIO_UART_RESET': 16,
            }
        }
    else:
        return
    if os.path.isfile(config_file_path):
        os.remove(config_file_path)
    json_utils.writeJSON(config_file_path, board_config)


if __name__ == '__main__':
    generate_board_config('rev3')
