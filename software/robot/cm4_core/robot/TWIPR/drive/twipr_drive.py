import dataclasses
import enum

from robot.TWIPR.communication.twipr_communication import TWIPR_Communication


class TWIPR_Drive_Status(enum.Enum):
    TWIPR_DRIVE_STATUS_OFF = 1,
    TWIPR_DRIVE_STATUS_ERROR = 0.
    TWIPR_DRIVE_STATUS_NORMAL = 2


@dataclasses.dataclass
class TWIPR_Drive_Data:
    status: TWIPR_Drive_Status = dataclasses.field(default_factory=TWIPR_Drive_Status)
    torque: float = 0
    input: float = 0


@dataclasses.dataclass
class TWIPR_Drive_Sample:
    left: TWIPR_Drive_Data = dataclasses.field(default_factory=TWIPR_Drive_Data)
    right: TWIPR_Drive_Data = dataclasses.field(default_factory=TWIPR_Drive_Data)


class TWIPR_Drive:
    _comm: TWIPR_Communication
    left: TWIPR_Drive_Data
    right: TWIPR_Drive_Data

    def __init__(self, comm):
        self._comm = comm

        self._comm.serial.registerCallback('rx_sample', self._onSample)

    # ------------------------------------------------------------------------------------------------------------------
    def getSample(self) -> dict:
        ...

    def _onSample(self, sample):
        ...

    def _readDriveStatus(self):
        ...

    def _setTorque(self, torque: list):
        ...
