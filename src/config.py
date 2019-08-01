
import os
import json
from context import component


@component
class Configuration:
    CONFIG_PATH = "cfg"
    """Log path"""

    SCHEMA_PATH = "schema"
    """Schema path"""

    SCHEMA_FILE_NAME_TEMPLATE = "schema_{}.tf"
    """Schema File name templace"""

    CSV_DELIMITER = ';'
    """CSV file fields delimiter"""

    CONFIG_PARAM_TABLES = "tables"
    """Tables config"""

    CONFIG_PARAM_DEFAULTS = "defaults"
    """Defaults config"""

    CONFIG_PARAM_PREDICATE = "predicate"
    """Predicate config"""

    CONFIG_PARAM_BIGDATA = "big_data"
    """BigData config"""

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

    def get_schema_file_name(self, table_name: str) -> str:
        return os.path.abspath(
            os.path.join(
                os.path.dirname(__file__),
                "../" + self.SCHEMA_PATH + "/" + self.SCHEMA_FILE_NAME_TEMPLATE.format(table_name)
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

    def get_predicate(self, table_info) -> str:
        return self.get_table_param_value(table_info, self.CONFIG_PARAM_PREDICATE)

    def get_big_data_params(self):
        return self.__data.get(self.CONFIG_PARAM_BIGDATA)
