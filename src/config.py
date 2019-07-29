
import os
import json
from context import component


@component
class Configuration:
    CONFIG_PATH = "cfg"
    """Log path"""

    CSV_DELIMITER = ';'
    """CSV file fields delimiter"""

    CONFIG_PARAM_TABLES = "tables"
    """Tables config"""

    CONFIG_PARAM_DEFAULTS = "defaults"
    """Defaults config"""

    CONFIG_PARAM_LOAD_METHOD = "load_method"
    """Load method config"""

    CONFIG_PARAM_PREDICATE = "predicate"
    """Predicate config"""

    def __init__(self):
        self.__data = {}
        self.__tables = {}

    def get_full_file_name(self, file_name):
        return os.path.abspath(
            os.path.join(
                os.path.dirname(__file__),
                "../" + self.CONFIG_PATH + "/" + file_name
            )
        )

    def load(self, config_file_name, tables_file_name):
        self.__data = dict(json.loads(open(self.get_full_file_name(config_file_name), mode='r').read()))
        self.__tables = dict(json.loads(open(self.get_full_file_name(tables_file_name), mode='r').read()))

    def get(self) -> dict:
        return self.__data

    def get_tables(self) -> list:
        return self.__tables.get(self.CONFIG_PARAM_TABLES)

    def get_table_param_value(self, table_info, param_value) -> str:
        result = table_info.get(param_value)
        if result is None:
            result = self.__tables.get(self.CONFIG_PARAM_DEFAULTS).get(param_value)

        return result

    def get_load_method(self, table_info) -> str:
        return self.get_table_param_value(table_info, self.CONFIG_PARAM_LOAD_METHOD)

    def get_predicate(self, table_info) -> str:
        return self.get_table_param_value(table_info, self.CONFIG_PARAM_PREDICATE)
