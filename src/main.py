from app import AppContext
from config import Configuration
from context import inject, ComponentFactory
import sys
from logging import Logger
from table_processor import TableExportService
from email_send_service import EmailSendService


class Main:
    def __init__(self, args):
        self.__args = args
        # AppConfig.execute()
        AppContext.initialize_context(__file__)

    # noinspection PyPropertyDefinition
    @property
    @inject
    def configuration(self) -> Configuration: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def table_export_service(self) -> TableExportService: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def email_send_service(self) -> EmailSendService: pass

    def configure(self):
        if len(self.__args) < 2:
            raise Exception("Configuration file name should be provided as first argument")

        if len(self.__args) < 3:
            raise Exception("Tables file name should be provided as second argument")

        self.configuration.load(self.__args[1], self.__args[2])

        self.logger.setLevel(self.configuration.get().get("logging").get("level"))

        return self

    def execute(self):
        try:
            for table_info in self.configuration.get_tables():
                self.logger.info("Started table:{}".format(str(table_info)), {"table_stats": table_info})

                try:
                    self.table_export_service.prepare(table_info)
                    result = self.table_export_service.execute()
                    self.logger.info("Successfully completed table:{0:s}, rows:{1:d}".format(str(table_info), result), {"table_stats": table_info})
                    self.email_send_service.add_content(
                        "Successfully completed table:{0:s}, rows:{1:d}".format(str(table_info), result))
                except Exception as e:
                    self.logger.info("Failed table:{}".format(str(table_info)),
                                     {"table_stats": table_info})
                    self.email_send_service.add_content("Failed table:{}".format(str(table_info)))
                    self.logger.error(e, exc_info=True)

            self.email_send_service.send_content()

            return self
        except Exception as e:
            self.logger.fatal(e, exc_info=True)
            exit(1)


if __name__ == "__main__":
    Main(sys.argv).configure().execute()

