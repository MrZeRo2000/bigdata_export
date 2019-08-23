

from context import component, inject
from config import Configuration
from email_send import EmailSender
from logging import Logger
from functools import reduce


@component
class EmailSendService:

    # noinspection PyPropertyDefinition
    @property
    @inject
    def configuration(self) -> Configuration: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    def send_content(self, content: list):
        if self.configuration.get().get("email_notification"):
            try:
                content_to_send = reduce(lambda s1, s2: "{}<BR>{}".format(s1, s2), content)
                (EmailSender(**self.configuration.get().get("email_settings"))).send_content(content_to_send)
            except Exception as e:
                self.logger.warning("Exception during sending e-mail: {}, e-mail configuration: {}".format(
                    str(e),
                    str(self.configuration.get().get("email_settings")))
                )
