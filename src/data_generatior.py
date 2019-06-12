
import random


class DataGenerator:
    def __init__(self, string_file_name: str):
        self.__string_file_name = string_file_name
        self.__string_list = []

    def load_string_list(self) -> None:
        with open(self.__string_file_name, 'r') as file:
            self.__string_list = file.read().splitlines()

    def prepare(self) -> None:
        self.load_string_list()

    def get_string(self) -> str:
        rand_num = random.randint(0, len(self.__string_list) - 1)
        return self.__string_list[rand_num]

    @staticmethod
    def get_boolean() -> bool:
        return bool(random.randint(0, 1))

    @staticmethod
    def get_int() -> int:
        return random.randint(0, 100000)

    @staticmethod
    def get_float() -> float:
        return random.random() * 10000

    def get_by_type(self, data_type: str):
        if data_type == "int":
            return DataGenerator.get_int()
        elif data_type == "boolean":
            return DataGenerator.get_boolean()
        elif data_type == "string":
            return self.get_string()
        elif data_type == "float":
            return DataGenerator.get_float()
        elif data_type == "double":
            return DataGenerator.get_float()
        elif data_type == "bigint":
            return DataGenerator.get_int()
        else:
            raise ValueError("Unknown data type: " + data_type)