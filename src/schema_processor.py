
import json
import re
from functools import reduce
from data_generatior import DataGenerator


class SchemaParser:
    def __init__(self, file_name):
        self.__data_file_name = file_name
        self.__data = None

    def parse(self):
        with open(self.__data_file_name, 'r') as file:
            data = file.read()

        # fix equals
        data = data.replace(" = ", ":")

        # remove redundant characters
#        data = re.search(r'schema_columns:\[(.*?)\]', data, re.DOTALL).group(0)
        data = re.search(r'schema_columns:\[(.*?)\]\n', data, re.DOTALL).group(0)

        # add quotes 3
        data = reduce(lambda prev, current: re.sub(current + "(\\s*):", "\"" + current + "\":", prev),
               [data, "name", "type", "comment", "schema_columns"])

        # add quotes
        # data = data.\
        #     replace("name:", "\"name\":").\
        #     replace("type:", "\"type\":").\
        #     replace("comment:", "\"comment\":").\
        #     replace("schema_columns:", "\"schema_columns\":")

        # add brackets
        data = "{" + data + "}"

        # ensure it is decoded
        json_data = json.loads(data)

        self.__data = json_data["schema_columns"]

        # return data
        return self.__data

    def ensure_data(self):
        if self.__data is None:
            self.parse()

    def get_columns_list(self):
        self.ensure_data()
        return [d["name"] for d in self.__data]

    def get_columns_string(self):
        columns_list = self.get_columns_list()
        return '"' + reduce((lambda s1, s2: s1.upper() + '","' + s2.upper()), columns_list) + '"'

    def get_column_types(self):
        self.ensure_data()
        return dict(map(lambda x: (x["name"], x["type"]), list(self.__data)))


class SchemaDataGenerator:
    def __init__(self, schema_data, data_generator: DataGenerator):
        self.__schema_data = schema_data
        self.__data_generator = data_generator

    def generate_data(self):
        data = {}

        _ = [data.update({row["name"]: self.__data_generator.get_by_type(row["type"])}) for row in self.__schema_data]

        return data

    def generate(self) -> str:
        data = self.generate_data()

        return json.dumps(data)

    def generate_array(self, num) -> str:
        result = []

        _ = [result.append(self.generate_data()) for _ in range(num)]

        return json.dumps(result)
