import dataclasses

from robot.TWIPR.control.twipr_control import TWIPR_Control_Sample
from robot.TWIPR.estimation.twipr_estimation import TWIPR_Estimation_Sample
from robot.TWIPR.drive.twipr_drive import TWIPR_Drive_Sample
from robot.TWIPR.sensors.twipr_sensors import TWIPR_Sensors_Sample


# twipr_wifi_sample = {
#     'general': {
#         'status': "normal",  # str
#         'configuration': 'default',  # str
#         'time': 1245601,  # int [ms]
#         'tick': 1000,  # int [-]
#         'sample_time': 0.01,  # float [s]
#         'name': 'abcdef',  # str
#         'id': 'abcdef'  # str
#     },
#     'control': {
#         'status': 'normal',  # str
#         'mode': 'velocity',  # str [X]
#         'configuration': "default",  # str
#         'u_ext': [0.0, 0.0],  # list[float] [-] [X]
#         'u': {
#             'left': 0,  # float [Nm][0-1] [X]
#             'right': 0,  # float [Nm][0-1] [X]
#         },
#         'balancing_control': {
#             'status': 'error',  # str
#             'u_ext': [0.0, 0.0],  # list[float] [Nm][0-1]
#             'u': [0.0, 0.0]  # list[float] [Nm][0-1]
#         },
#         'speed_control': {
#             'status': 'off',  # str
#             'u_ext': {
#                 'v': 0.0,  # float [m/s]
#                 'psi_dot': 0.0,  # float [rad/s]
#             },
#             'u': [0.0, 0.0]  # list[float] [-]
#         }
#     },
#     'estimation': {
#         'status': 'normal',  # str
#         'mode': 'kalman_ext',  # str
#         'configuration': 'default',  # str
#         'state': {
#             'x': 0.0,  # float [m] [X]
#             'y': 0.0,  # float [m] [X]
#             'v': 0.0,  # float [m/s] [X]
#             'theta': 0.0,  # float [grad] [X]
#             'theta_dot': 0.0,  # float [grad/s] [X]
#             'psi': 0.0,  # float [grad] [X]
#             'psi_dot': 0.0,  # float [grad/s] [X]
#         },
#         'uncertainties':
#             {
#                 'x': 0,  # float [-]
#                 'y': 0,  # float [-]
#                 'v': 0,  # float [-]
#                 'theta': 0,  # float [-]
#                 'theta_dot': 0,  # float [-]
#                 'psi': 0,  # float [-]
#                 'psi_dot': 0,  # float [-]
#             }
#     },
#     'sensors': {
#         'imu': {
#             'status': 'normal',  # str
#             'gyr': [0, 0, 0],  # list[float] [grad/s] [X]
#             'acc': [0, 0, 0],  # list[float] [m/s^2] [X]
#         },
#         'wheel': {
#             'status': 'normal',  # str
#             'speed': [0, 0],  # list[float] [grad/s] [X]
#             'angle': [0, 0]  # list[float] [grad]
#         },
#         'distance': {
#             'front': 0,  # float [m] [X]
#             'back': 0,  # float [m] [X]
#         },
#         'temperature': {
#             'board': 0,  # float [C]
#             'bms': 0  # float [C]
#         }
#     },
#     'board': {
#         'status': 'normal',  # str
#         'battery': 14.2,  # float [V] [X]
#         'charging': False,  # bool
#     },
#     'drive': {
#         'left': {
#             'status': 'normal',  # str
#             'u': 1,  # float [Nm] [X]
#             'torque': 1,  # float [Nm] [X]
#             'speed': 1,  # float [grad/s] [X]
#             'angle': 1  # float [grad]
#         },
#         'right': {
#             'status': 1,  # str
#             'u': 1,  # float [Nm] [X]
#             'torque': 1,  # float [Nm] [X]
#             'speed': 1,  # float [grad/s] [X]
#             'angle': 2  # float [grad]
#         }
#     }
# }
#
#
# # 'control': {
# #         'status': 'normal',  # str
# #         'mode': 'velocity',  # str [X]
# #         'configuration': "default",  # str
# #         'u_ext': [0.0, 0.0],  # list[float] [-] [X]
# #         'u': {
# #             'left': 0,  # float [Nm][0-1] [X]
# #             'right': 0,  # float [Nm][0-1] [X]
# #         },
# #         'balancing_control': {
# #             'status': 'error',  # str
# #             'u_ext': [0.0, 0.0],  # list[float] [Nm][0-1]
# #             'u': [0.0, 0.0]  # list[float] [Nm][0-1]
# #         },
# #         'speed_control': {
# #             'status': 'off',  # str
# #             'u_ext': {
# #                 'v': 0.0,  # float [m/s]
# #                 'psi_dot': 0.0,  # float [rad/s]
# #             },
# #             'u': [0.0, 0.0]  # list[float] [-]
# #         }
# #     },

@dataclasses.dataclass
class TWIPR_Sample_General:
    id: str = ''
    status: str = ''
    configuration: str = ''
    time: int = 0
    tick: int = 0
    sample_time: float = 0


@dataclasses.dataclass
class TWIPR_Sample:
    general: TWIPR_Sample_General = dataclasses.field(default_factory=TWIPR_Sample_General)
    control: TWIPR_Control_Sample = dataclasses.field(default_factory=TWIPR_Control_Sample)
    estimation: TWIPR_Estimation_Sample = dataclasses.field(default_factory=TWIPR_Estimation_Sample)
    drive: TWIPR_Drive_Sample = dataclasses.field(default_factory=TWIPR_Drive_Sample)
    sensors: TWIPR_Sensors_Sample = dataclasses.field(default_factory=TWIPR_Sensors_Sample)
