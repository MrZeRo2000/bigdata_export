from app import AppContext
from config import Configuration
from context import inject
import sys
from logging import Logger
from log import log_method
from table_processor import TableExportService


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

    def configure(self):
        if len(self.__args) < 2:
            raise Exception("Configuration file name should be provided as first argument")

        if len(self.__args) < 3:
            raise Exception("Tables file name should be provided as second argument")

        self.configuration.load(self.__args[1], self.__args[2])

        self.logger.setLevel(self.configuration.get().get("logging").get("level"))

        return self

    @log_method
    def execute(self):
        try:
            for table_info in self.configuration.get_tables():
                self.logger.info("Loading table:{0}".format(str(table_info)))
                load_method = self.configuration.get_load_method(table_info)
                self.logger.info("Load method for {0}:{1}".format(table_info.get("name"), load_method))

                try:
                    self.table_export_service.prepare(table_info)
                    self.table_export_service.execute()
                except Exception as e:
                    self.logger.error(e, exc_info=True)

            return self
        except Exception as e:
            self.logger.fatal(e, exc_info=True)
            exit(1)


if __name__ == "__main__":
    Main(sys.argv).configure().execute()

