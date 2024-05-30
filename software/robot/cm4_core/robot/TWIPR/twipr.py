from control_board.robot_control_board import RobotControl_Board
from robot.TWIPR.communication.twipr_communication import TWIPR_Communication
from robot.TWIPR.control.twipr_control import TWIPR_Control
from robot.TWIPR.drive.twipr_drive import TWIPR_Drive
from robot.TWIPR.estimation.twipr_estimation import TWIPR_Estimation
from robot.TWIPR.logging.twipr_sample import TWIPR_Sample
from robot.TWIPR.sensors.twipr_sensors import TWIPR_Sensors


# Things to implement:
# - Stream to Server. Where should I put this?

class TWIPR:
    board: RobotControl_Board

    communication: TWIPR_Communication
    control: TWIPR_Control
    estimation: TWIPR_Estimation
    drive: TWIPR_Drive
    sensors: TWIPR_Sensors

    def __init__(self):
        self.board = RobotControl_Board(device_class='robot', device_type='TWIPR', device_revision='v3',
                                        device_id='twipr1', device_name='twipr_1')

        self.communication = TWIPR_Communication(board=self.board)

        self.control = TWIPR_Control(comm=self.communication)
        self.estimation = TWIPR_Estimation(comm=self.communication)
        self.drive = TWIPR_Drive(comm=self.communication)
        self.sensors = TWIPR_Sensors(comm=self.communication)

    # ==================================================================================================================
    def init(self):
        self.board.init()
        self.communication.init()

    def start(self):
        self.board.start()
        self.communication.start()
        print("START TWIPR ...")

    # ==================================================================================================================
    def _update(self):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    # TODO: Should probably be somewhere else
    def _buildSample(self):
        sample = TWIPR_Sample()
        sample.control = self.control.getSample()

        return sample
