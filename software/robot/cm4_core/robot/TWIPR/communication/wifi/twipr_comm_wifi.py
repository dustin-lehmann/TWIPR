# Sample
from cm4_core.interface.wifi_interface import WIFI_Interface
from cm4_core.utils.callbacks import Callback
class TWIPR_WIFI_Interface:
    interface: WIFI_Interface

    callbacks: dict

    def __init__(self, interface: WIFI_Interface):
        self.interface = interface

        self.interface.registerCallback('connected', self._connectedCallback)
        self.interface.registerCallback('disconnected', self._disconnectedCallback)

        self.callbacks = {
            'connected': [],
            'disconnected': [],
        }

    # ------------------------------------------------------------------------------------------------------------------
    def registerCallback(self, callback_id, function: callable, parameters: dict = None, lambdas: dict = None,
                         **kwargs):
        callback = Callback(function, parameters, lambdas, **kwargs)

        if callback_id in self.callbacks:
            self.callbacks[callback_id].append(callback)
        else:
            raise Exception("Invalid Callback type")

    # ------------------------------------------------------------------------------------------------------------------
    def sendMessage(self, message):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def sendStream(self, data):
        ...

    # ==================================================================================================================
    def _connectedCallback(self, *args, **kwargs):
        ...

    # ------------------------------------------------------------------------------------------------------------------
    def _disconnectedCallback(self, *args, **kwargs):
        ...
