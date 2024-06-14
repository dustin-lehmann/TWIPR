import threading
import time

from board.board import RobotControl_Board
from robot.TWIPR.communication.twipr_communication import TWIPR_Communication
from robot.TWIPR.control.twipr_control import TWIPR_Control
from robot.TWIPR.drive.twipr_drive import TWIPR_Drive
from robot.TWIPR.estimation.twipr_estimation import TWIPR_Estimation
from robot.TWIPR.logging.twipr_sample import TWIPR_Sample
from robot.TWIPR.sensors.twipr_sensors import TWIPR_Sensors
from robot.TWIPR.settings import readSettings


# Things to implement:
# - Stream to Server. Where should I put this?

class TWIPR:
    board: RobotControl_Board

    communication: TWIPR_Communication
    control: TWIPR_Control
    estimation: TWIPR_Estimation
    drive: TWIPR_Drive
    sensors: TWIPR_Sensors
    _thread: threading.Thread

    def __init__(self):

        self.robot_settings = readSettings()

        self.board = RobotControl_Board(device_class='robot', device_type='twipr', device_revision='v3',
                                        device_id=self.robot_settings['id'], device_name=self.robot_settings['name'])

        self.communication = TWIPR_Communication(board=self.board)

        self.control = TWIPR_Control(comm=self.communication)
        self.estimation = TWIPR_Estimation(comm=self.communication)
        self.drive = TWIPR_Drive(comm=self.communication)
        self.sensors = TWIPR_Sensors(comm=self.communication)

        self._thread = threading.Thread(target=self._threadFunction)

    # ==================================================================================================================
    def init(self):
        self.board.init()
        self.communication.init()
        self.control.init()

    def start(self):
        self.board.start()
        self.communication.start()
        self.control.start()
        # print(self.robot_settings['balancing_gain'])
        self.control.setStateFeedbackGain(self.robot_settings['balancing_gain'])
        print("START TWIPR ...")

        self._thread.start()

    # ==================================================================================================================
    def _threadFunction(self):

        # TODO: This is just for testing purposes. This should be divided somewhere else. Also the update time should
        #  be fixed and not by a time.sleep
        while True:
            self._update()
            time.sleep(0.1)

    def _update(self):
        sample = self._buildSample()

        if self.communication.wifi.connected:
            self.communication.wifi.sendStream(sample)

    # ------------------------------------------------------------------------------------------------------------------
    # TODO: Should probably be somewhere else
    def _buildSample(self):
        sample = TWIPR_Sample()

        sample.general.id = self.robot_settings['id']
        sample.general.status = 0
        sample.general.configuration = ''
        sample.general.time = self.communication.wifi.getTime()
        sample.general.tick = 0
        sample.general.sample_time = 0.1

        sample.control = self.control.getSample()
        sample.estimation = self.estimation.getSample()
        sample.drive = self.drive.getSample()
        sample.sensors = self.sensors.getSample()

        return sample
