
from context import inject
from logging import Logger


class ExportService:
    """
    Base class for export service
    """

    def __init__(self, url, headers):
        self._url = url
        self._headers = headers
        self._log_messages = False

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    @property
    def log_messages(self):
        return self._log_messages

    @log_messages.setter
    def log_messages(self, value):
        self._log_messages = value

