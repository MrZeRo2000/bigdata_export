
import json
import re
from data_generatior import DataGenerator


class SchemaParser:
    def __init__(self, file_name):
        self.__data_file_name = file_name

    def parse(self):
        with open(self.__data_file_name, 'r') as file:
            data = file.read()

        # fix equals
        data = data.replace(" = ", ":")

        # remove redundant characters
        data = re.search(r'schema_columns:\[(.*?)\]', data, re.DOTALL).group(0)

        # add quotes
        data = data.\
            replace("name:", "\"name\":").\
            replace("type:", "\"type\":").\
            replace("comment:", "\"comment\":").\
            replace("schema_columns:", "\"schema_columns\":")

        # add brackets
        data = "{" + data + "}"

        # ensure it is decoded
        json_data = json.loads(data)

        # return data
        return json_data["schema_columns"]


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
