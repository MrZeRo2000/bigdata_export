
import datetime
import logging
import os
from context import component


class Formatter(logging.Formatter):
    def format(self, record):

        if len(record.args) == 0:
            module = record.module
        else:
            args_module = record.args.get("module")
            if args_module is not None:
                module = str(args_module)
            else:
                module = record.module

        if hasattr(record, "message"):
            message = record.message
        else:
            if hasattr(record, "msg"):
                message = str(record.msg)
            else:
                message = "No message for " + str(record)

        record.module = module
        record.message = message

        return super(Formatter, self).format(record)


class StatsFilter(logging.Filter):
    def filter(self, record):
        return type(record.args) == dict and record.args.get("table_stats") is not None


class MessagesFilter(logging.Filter):
    def filter(self, record):
        return type(record.args) == dict and \
               record.args.get("headers") is not None and \
               record.args.get("json_data") is not None


@component
class Logger:
    LOG_FILE_FORMAT = "log_%Y-%m-%d-%H-%M-%S-%f.txt"
    """Log file format"""

    LOG_STATS_FILE_FORMAT = "log_stats_%Y-%m-%d-%H-%M-%S-%f.txt"
    """Log stats file format"""

    LOG_MESSAGES_FILE_FORMAT = "log_messages_%Y-%m-%d-%H-%M-%S-%f.txt"
    """Log messages file format"""

    LOG_PATH = "log"
    """Log path"""

    LOG_FORMAT = "%(asctime)s %(levelname)s %(name)s %(module)s %(message)s"
    """Log format"""

    LOG_STATS_FORMAT = "%(asctime)s %(message)s"
    """Log stats format"""

    LOG_MESSAGES_FORMAT = "%(asctime)s %(message)s"
    """Log messages format"""

    COMPONENT_PROPERTY_NAME = "logger"

    def __init__(self):
        name = __file__.split(os.path.sep)[-3]

        self.__logger = logging.getLogger(name)
        self.__logger.setLevel(logging.DEBUG)

        today = datetime.datetime.now()

        log_path = os.path.join(os.path.dirname(__file__), "../" + self.LOG_PATH)

        log_file_name = os.path.join(log_path, today.strftime(self.LOG_FILE_FORMAT))
        formatter = Formatter(self.LOG_FORMAT)

        file_handler = logging.FileHandler(log_file_name, encoding='utf-8')
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(formatter)

        # stats
        stats_file_name = os.path.join(log_path, today.strftime(self.LOG_STATS_FILE_FORMAT))
        stats_file_handler = logging.FileHandler(stats_file_name)
        stats_file_handler.setFormatter(Formatter(self.LOG_STATS_FORMAT))
        stats_file_handler.addFilter(StatsFilter())

        # messages
        messages_file_name = os.path.join(log_path, today.strftime(self.LOG_MESSAGES_FILE_FORMAT))
        messages_file_handler = logging.FileHandler(messages_file_name)
        messages_file_handler.setFormatter(Formatter(self.LOG_MESSAGES_FORMAT))
        messages_file_handler.addFilter(MessagesFilter())

        # console
        console_handler = logging.StreamHandler()
        console_handler.setLevel(logging.DEBUG)
        console_handler.setFormatter(formatter)

        self.__logger.addHandler(file_handler)
        self.__logger.addHandler(stats_file_handler)
        self.__logger.addHandler(messages_file_handler)
        self.__logger.addHandler(console_handler)

    @property
    def logger(self) -> logging.Logger:
        return self.__logger


def log_method(func):
    def wrapper(*args, **kwargs):
        from app import AppContext
        ctx = AppContext.get_context()
        logger = ctx.match_component_by_type(logging.Logger)

        func_name = args[0].__class__.__name__ + "." + func.__name__
        module_name = args[0].__class__.__module__.strip("__")
        module_info = {"module": module_name}

        logger.info(func_name + " started", module_info)
        result = func(*args, **kwargs)
        logger.info(func_name + " completed", module_info)

        return result

    return wrapper

