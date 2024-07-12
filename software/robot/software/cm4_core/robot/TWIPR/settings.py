import os

from cm4_core.utils.json_utils import writeJSON, readJSON

settings_file_path = os.path.expanduser('~/robot_settings.json')

# Samples LL
SAMPLE_BUFFER_SIZE = 10

# Register Tables
REGISTER_TABLE_GENERAL = 0x01
REGISTER_TABLE_CONTROL = 0x02


def generate_settings_file():
    settings = {
        'id': 'twipr3',
        'name': 'TWIPR 3',
        'balancing_gain': [0.035, 0.06, 0.01, 0.009,
                           0.035, 0.06, 0.01, -0.009],
        # 'balancing_gain': [0.035, 0.062, 0.009, 0.009,
        #                    0.035, 0.062, 0.009, -0.009],
        #
        'torque_offsets': [0.000, 0.000]
    }

    if os.path.isfile(settings_file_path):
        os.remove(settings_file_path)

    writeJSON(settings_file_path, settings)


def readSettings():
    settings = readJSON(settings_file_path)
    return settings


if __name__ == '__main__':
    generate_settings_file()
