import sys
import time

from extensions.cli.cli import CommandSet, CLI, Command, CommandArgument
# from robots.TWIPR.utils.twipr_cli import TWIPR_CLI
from robots.twipr.twipr_manager import TWIPR_Manager
from robots.twipr.utils.twipr_cli import TWIPR_Manager_CommandSet
from robots.twipr.utils.twipr_gui import TWIPR_GUI
from robots.twipr.utils.twipr_joystick_control import TWIPR_JoystickControl, TWIPR_JoystickControl_CommandSet
from utils.logging import setLoggerLevel

setLoggerLevel(logger=['tcp', 'server', 'udp'], level='WARNING')


# ==================================================================================================================
# The `SimpleTwiprJoystickControl` class provides a simplified means of joystick control for the TWIPR robot.
# It manages instances of a TWIPR manager, a joystick controller, and a GUI.
class SimpleTwiprJoystickControl:
    """
    This class allows joystick control functionality for the TWIPR robot.
    It provides a simplified interface for the TWIPR Manager, the TWIPR JoystickControl, and the TWIPR_GUI.
    Callbacks and functionalities are registered within the class allowing a seamless and straightforward control.
    """

    # Define the member variables of the `SimpleTwiprJoystickControl` class
    # - `robot_manager`: instance of the TWIPR_Manager
    # - `joystick_control`: instance of the TWIPR_JoystickControl
    # - `gui`: instance of the TWIPR_GUI
    robot_manager: TWIPR_Manager
    joystick_control: TWIPR_JoystickControl
    gui: TWIPR_GUI

    command_set: CommandSet
    cli: CLI

    def __init__(self):
        """
        Initialize the TWIPR manager, TWIPR joystick control and GUI instances.
        Register callback methods for the manager, joystick control and GUI
        """
        self.robot_manager = TWIPR_Manager()
        self.joystick_control = TWIPR_JoystickControl(twipr_manager=self.robot_manager, thread=True)
        self.gui = TWIPR_GUI()
        self.command_set = CommandSet(name='root')
        self.cli = CLI()

        self.gui.registerCallback('rx_message', self._rxMessageGUI_callback)
        self.robot_manager.registerCallback('stream', self.gui.sendRawStream)
        self.robot_manager.registerCallback('new_robot', self._newRobot_callback)
        self.robot_manager.registerCallback('robot_disconnected', self._robotDisconnected_callback)
        self.joystick_control.registerCallback('new_joystick', self.gui.addJoystick)
        self.joystick_control.registerCallback('joystick_disconnected', self.gui.removeJoystick)

        self.command_set.addChild(TWIPR_Manager_CommandSet(self.robot_manager))
        self.command_set.addChild(TWIPR_JoystickControl_CommandSet(self.joystick_control))

    # ==================================================================================================================
    def init(self):
        """
        Initializes the robot manager, joystick control and the GUI.
        The initialization process involves setting initial states and configurations.
        """
        self.robot_manager.init()
        self.joystick_control.init()
        self.gui.init()

    # ------------------------------------------------------------------------------------------------------------------
    def start(self):
        """
        Start the robot manager, joystick controller and the GUI.
        It calls their respective start method which should initiate their operation.
        """
        self.robot_manager.start()
        self.joystick_control.start()
        self.cli.start(commandSet=self.command_set)
        self.gui.start()

    # ------------------------------------------------------------------------------------------------------------------
    def _newRobot_callback(self, robot, *args, **kwargs):
        """
        Callback method when new robot is detected.
        Prints the ID of the new robot to the GUI.
        """
        self.gui.print(f"New Robot connected: {robot.id}")

    # ------------------------------------------------------------------------------------------------------------------
    def _robotDisconnected_callback(self, robot, *args, **kwargs):
        """
        Callback method when a robot disconnects.
        Prints the ID of the disconnected robot to the GUI.
        """
        self.gui.print(f"Robot disconnected: {robot.id}")

    # ------------------------------------------------------------------------------------------------------------------
    def _rxMessageGUI_callback(self, message, *args, **kwargs):
        """
        Callback method for GUI related messages.
        It handles messages related to 'command' and 'joysticksChanged' type events.
        """
        message_type = message.get('type')

        if message_type == 'command':

            if message['data']['command'] == 'emergency':
                self.robot_manager.emergencyStop()

        elif message_type == 'joysticksChanged':

            joysticks = message['data']['joysticks']

            for joystick in joysticks:
                joystick_id = joystick['id']
                robot_id = joystick['assignedBot']

                # No Robot assigned to Joystick
                if robot_id == '':
                    # Check if it is currently assigned to a robot
                    if joystick_id in self.joystick_control.assignments.keys():
                        self.joystick_control.unassignJoystick(joystick_id)
                else:

                    # Check if it is assigned to another robot in the list of robots
                    if joystick_id in self.joystick_control.assignments.keys():
                        connected_robot_id = self.joystick_control.assignments[joystick_id].robot.id

                        if connected_robot_id == robot_id:
                            # Do nothing, we have already assigned this robot
                            pass
                        else:
                            self.joystick_control.assignJoystick(joystick=joystick_id, twipr=robot_id)

                    # it is not connected to a robot yet:
                    else:
                        self.joystick_control.assignJoystick(joystick=joystick_id, twipr=robot_id)


# ======================================================================================================================


def main():
    app = SimpleTwiprJoystickControl()
    app.init()
    app.start()

    while True:
        time.sleep(1)


if __name__ == '__main__':
    main()
