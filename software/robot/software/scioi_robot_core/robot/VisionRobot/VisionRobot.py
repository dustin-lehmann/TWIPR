import ctypes
import threading
import time
import robot.VisionRobot.navigation.agent as agent

from board.board import RobotControl_Board
from robot.TWIPR.communication.twipr_communication import TWIPR_Communication


class motor_input_struct(ctypes.Structure):
    _fields_ = [("input_left", ctypes.c_float), ("input_right", ctypes.c_float)]


class motor_speed_struct(ctypes.Structure):
    _fields_ = [("input_left", ctypes.c_float), ("input_right", ctypes.c_float)]



class VisionRobot:
    board: RobotControl_Board
    communication: TWIPR_Communication
    _thread: threading.Thread
    agent: agent.Agent

    def __init__(self):
        self.board = RobotControl_Board(device_class='robot', device_type='visionrobot', device_revision='v2',
                                        device_id='visionrobot1', device_name='Vision Robot 1')

        self.communication = TWIPR_Communication(board=self.board)
        self.agent = agent.Agent(self)
        self.communication.serial.registerCallback('rx', self._rx_callback)

        self.communication.wifi.addCommand(identifier='setSpeed',
                                           callback=self.setSpeed,
                                           arguments=['speed'],
                                           description='Set the speed of the motors')
        self.communication.wifi.addCommand(identifier='turn',
                                           callback=self.turn,
                                           arguments=['phi'],
                                           description='Turn robot by phi [rad]')

        self.communication.wifi.addCommand(identifier='goTo',
                                           callback=self.goTo,
                                           arguments=['x', 'y'],
                                           description='Go to specified x,y position in local coordinate system')
        self._thread = threading.Thread(target=self._threadFunction)

    # === METHODS ======================================================================================================
    def init(self):
        self.board.init()
        self.communication.init()

    # ------------------------------------------------------------------------------------------------------------------
    def start(self):
        self.board.start()
        self.communication.start()
        self._thread.start()
        self.agent.start()
        print("START VISION ROBOT ...")

    # ------------------------------------------------------------------------------------------------------------------

    def debug(self, state):
        self.communication.serial.executeFunction(module=0x01, address=0x01, data=state, input_type=ctypes.c_uint8,
                                                  output_type=None)

    def setSpeed(self, speed):
        print(f"Set Speed to {speed}")
        assert (isinstance(speed, list))
        input_struct = motor_input_struct(input_left=speed[0], input_right=speed[1])
        self.communication.serial.executeFunction(module=0x01,address=0x02, data=input_struct,input_type=motor_input_struct)

    def turn(self, phi):
        print(f"Turn by {phi}")
        cphi = ctypes.c_float(phi)
        self.communication.serial.executeFunction(module=0x01, address=0x03, data=cphi, input_type=ctypes.c_float)

    def goTo(self, x, y):
        self.agent.addGoal(x, y)

    # === PRIVATE METHODS ==============================================================================================
    def _threadFunction(self):

        while True:
            data = {'test': 1}
            self.communication.wifi.sendStream(data)
            time.sleep(0.1)

    def _rx_callback(self, data, *args, **kwargs):
        print(f"Received something {data}")
