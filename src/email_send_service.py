

from context import component, inject
from config import Configuration
from email_send import EmailSender
from logging import Logger
from functools import reduce
from datetime import datetime


@component
class EmailSendService:
    FORMAT_DATE = "%Y-%m-%d %H:%M:%S"

    # noinspection PyPropertyDefinition
    @property
    @inject
    def configuration(self) -> Configuration: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    def __init__(self):
        self._content = []

    def add_content(self, content):
        self._content.append(content)

    def get_formatted_date(self):
        return datetime.now().strftime(self.FORMAT_DATE)

    def add_start_event(self, table_info):
        event_text = "{0:s} Started table:{1:s}".format(
            self.get_formatted_date(),
            table_info
        )
        self._content.append(event_text)

    def add_success_event(self, table_info, result):
        event_text = "{0:s} Successfully completed table:{1:s}, rows:{2:d}".format(
            self.get_formatted_date(),
            table_info,
            result
        )
        self._content.append(event_text)

    def add_failure_event(self, table_info):
        event_text = "{0:s} Failed table:{1:s}".format(
            self.get_formatted_date(),
            table_info
        )
        self._content.append(event_text)

    def get_formatted_content(self):
        return reduce(lambda s1, s2: "{}<BR>{}".format(s1, s2), self._content)

    def send_content(self):
        if self.configuration.get().get("email_notification"):
            try:
                (EmailSender(**self.configuration.get().get("email_settings"))).send_content(
                    self.get_formatted_content()
                )
            except Exception as e:
                self.logger.warning("Exception during sending e-mail: {}, e-mail configuration: {}".format(
                    str(e),
                    str(self.configuration.get().get("email_settings")))
                )
