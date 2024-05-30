import ctypes

from control_board.robot_control_board import RobotControl_Board
from robot.TWIPR.communication.twipr_communication import TWIPR_Communication


class motor_input_struct(ctypes.Structure):
    _fields_ = [("input_left", ctypes.c_float), ("input_right", ctypes.c_float)]


class VisionRobot:
    board: RobotControl_Board
    communication: TWIPR_Communication

    def __init__(self):
        self.board = RobotControl_Board(device_class='robot', device_type='VisionRobot', device_revision='v2',
                                        device_id='visionrobot1', device_name='Vision Robot 1')

        self.communication = TWIPR_Communication(board=self.board)

    # === METHODS ======================================================================================================
    def init(self):
        self.board.init()
        self.communication.init()

    # ------------------------------------------------------------------------------------------------------------------
    def start(self):
        self.board.start()
        self.communication.start()
        print("START VISION ROBOT ...")

    # ------------------------------------------------------------------------------------------------------------------

    def debug(self, state):
        self.communication.serial.executeFunction(module=0x01, address=0x01, data=state, input_type=ctypes.c_uint8,
                                                  output_type=None)

    def setSpeed(self, speed):
        assert (isinstance(speed, list))
        input_struct = motor_input_struct(input_left=speed[0], input_right=speed[1])
        self.communication.serial.executeFunction(module=0x01,address=0x02, data=input_struct,input_type=motor_input_struct)

    # === PRIVATE METHODS ==============================================================================================
