import ctypes
import dataclasses
import enum

from control_board.robot_control_board import RobotControl_Board
from robot.TWIPR.communication.twipr_communication import TWIPR_Communication
import robot.TWIPR.settings as settings
import robot.TWIPR.control.serial_communication_control as serial_communication_control


@dataclasses.dataclass
class TWIPR_Balancing_Control_Config:
    available: bool = False
    K: list = dataclasses.field(default_factory=list)  # State Feedback Gain
    u_lim: list = dataclasses.field(default_factory=list)  # Input Limits
    external_input_gain: list = dataclasses.field(
        default_factory=list)  # When using balancing control without speed control, this can scale the external input


@dataclasses.dataclass
class TWIPR_PID_Control_Config:
    Kp: float = 0
    Kd: float = 0
    Ki: float = 0
    anti_windup: float = 0
    integrator_saturation: float = None


@dataclasses.dataclass
class TWIPR_Speed_Control_Config:
    available: bool = False
    v: TWIPR_PID_Control_Config = dataclasses.field(default_factory=TWIPR_PID_Control_Config)
    psidot: TWIPR_PID_Control_Config = dataclasses.field(default_factory=TWIPR_PID_Control_Config)
    external_input_gain: list = dataclasses.field(default_factory=list)


@dataclasses.dataclass
class TWIPR_Control_Config:
    name: str = ''
    description: str = ''
    balancing_control: TWIPR_Balancing_Control_Config = dataclasses.field(
        default_factory=TWIPR_Balancing_Control_Config)
    speed_control: TWIPR_Speed_Control_Config = dataclasses.field(default_factory=TWIPR_Speed_Control_Config)


class TWIPR_Control_Mode(str, enum.Enum):
    TWIPR_CONTROL_MODE_OFF = 0,
    TWIPR_CONTROL_MODE_DIRECT = 1,
    TWIPR_CONTROL_MODE_BALANCING = 2,
    TWIPR_CONTROL_MODE_VELOCITY = 3,
    TWIPR_CONTROL_MODE_POS = 4


class TWIPR_Control_State(str, enum.Enum):
    TWIPR_CONTROL_STATE_ERROR = "ERROR",
    TWIPR_CONTROL_STATE_NORMAL = "NORMAL"


class TWIPR_Control_Mode_LL(enum.Enum):
    TWIPR_CONTROL_MODE_LL_OFF = 0,
    TWIPR_CONTROL_MODE_LL_DIRECT = 1,
    TWIPR_CONTROL_MODE_LL_BALANCING = 2,
    TWIPR_CONTROL_MODE_LL_VELOCITY = 3


@dataclasses.dataclass
class TWIPR_Control_Input:
    input_ext: list = dataclasses.field(default_factory=list)
    input: list = dataclasses.field(default_factory=list)
    v_cmd: float = 0
    psi_dot_cmd: float = 0


@dataclasses.dataclass
class TWIPR_Control_Sample:
    status: TWIPR_Control_State = dataclasses.field(
        default=TWIPR_Control_State(TWIPR_Control_State.TWIPR_CONTROL_STATE_ERROR))
    mode: TWIPR_Control_Mode = dataclasses.field(default=TWIPR_Control_Mode(TWIPR_Control_Mode.TWIPR_CONTROL_MODE_OFF))
    configuration: str = ''
    input: TWIPR_Control_Input = dataclasses.field(default_factory=TWIPR_Control_Input)


class TWIPR_Control:
    _comm: TWIPR_Communication

    state: TWIPR_Control_State
    mode: TWIPR_Control_Mode
    mode_ll: TWIPR_Control_Mode_LL

    input: TWIPR_Control_Input

    def __init__(self, comm: TWIPR_Communication):
        self._comm = comm

        self.state = TWIPR_Control_State(TWIPR_Control_State.TWIPR_CONTROL_STATE_ERROR)
        self.mode = TWIPR_Control_Mode(TWIPR_Control_Mode.TWIPR_CONTROL_MODE_OFF)

        self._comm.serial.registerCallback('rx_sample', self._onSample)
        ...

    # ==================================================================================================================
    def loadConfig(self, name):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def saveConfig(self, name, config=None):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def setMode(self, mode: TWIPR_Control_Mode):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def setInput(self, input):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def setSpeed(self, v, psi_dot):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def setStateFeedbackGain(self, K):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def setVelocityController(self):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def getSample(self) -> dict:
        ...

    # = PRIVATE METHODS ================================================================================================

    def _update(self):
        # Check the LL state
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def _onSample(self, sample):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def _setControlMode_LL(self, mode):
        mode_data = 0
        if mode == TWIPR_Control_Mode.TWIPR_CONTROL_MODE_OFF:
            mode_data = 0
        elif mode == TWIPR_Control_Mode.TWIPR_CONTROL_MODE_BALANCING:
            mode_data = 2

        print(f"Set LL Control Mode to {mode}")

        self._comm.serial.executeFunction(module=settings.REGISTER_TABLE_CONTROL,
                                          address=serial_communication_control.ADDRESS_CONTROL_MODE,
                                          data=mode_data,
                                          input_type=ctypes.c_uint8)

    # ------------------------------------------------------------------------------------------------------------------
    def _readControlMode_LL(self):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def _readControlState_LL(self):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def _setStateFeedbackGain_LL(self, K):
        assert (isinstance(K, list))
        assert (len(K) == 8)
        assert (all(isinstance(elem, (float, int)) for elem in K))

        self._comm.serial.executeFunction(module=settings.REGISTER_TABLE_CONTROL,
                                          address=serial_communication_control.ADDRESS_CONTROL_K,
                                          data=K,
                                          input_type=ctypes.c_float,
                                          output_type=None)

    # ------------------------------------------------------------------------------------------------------------------
    def _setVelocityControl_LL(self):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def _readControlConfig_LL(self):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def _setControlInput_LL(self, input):
        assert (isinstance(input, list))
        assert (len(input) == 2)
        assert (all(isinstance(elem, (float, int)) for elem in input))

        input_struct = serial_communication_control.twipr_control_input(u1=input[0], u2=input[1])

        self._comm.serial.executeFunction(module=settings.REGISTER_TABLE_CONTROL,
                                          address=serial_communication_control.ADDRESS_CONTROL_INPUT,
                                          data=input_struct,
                                          input_type=serial_communication_control.twipr_control_input)

    # ------------------------------------------------------------------------------------------------------------------
