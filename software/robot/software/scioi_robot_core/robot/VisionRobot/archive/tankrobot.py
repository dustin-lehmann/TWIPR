import threading

from core.interfaces.interface import WifiInterface
from core.interfaces.data_link import DataLink
from board.rc_board import RobotControl_Device


class TankRobot:
    interface: WifiInterface
    board: RobotControl_Device
    _thread: threading.Thread

    # === INIT =========================================================================================================
    def __init__(self):
        ...

        # TODO: This should done different and is only for KISS for David's defence
        self.motors = {
            'left': 0,
            'right': 0
        }

        self.interface.data['motors'] = {

            'left': DataLink(identifier='left',
                             description='Percentage of left motor speed',
                             limits=[-1, 1],
                             datatype=float,
                             obj=self.motors,
                             name='left'),

            'right': DataLink(identifier='right',
                              description='Percentage of right motor speed',
                              limits=[-1, 1],
                              datatype=float,
                              obj=self.motors,
                              name='right'),
        }

    # === METHODS ======================================================================================================
    def setSpeed(self, left, right):
        ...

    # === PRIVATE METHODS ==============================================================================================
    def _robot_thread(self):
        ...