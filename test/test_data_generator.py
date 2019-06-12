
from unittest import TestCase
from data_generatior import DataGenerator
import os


class TestDataGenerator(TestCase):
    def setUp(self) -> None:
        self.script_dir = os.path.dirname(__file__)
        self.data_file_name = os.path.join(self.script_dir, "../data", "string_list.txt")
        self.assertTrue(os.path.isfile(self.data_file_name))

    def test_data_generator(self):
        data_generator = DataGenerator(self.data_file_name)
        data_generator.prepare()

        for i in range(1000):
            dummy_string = data_generator.get_string()
            dummy_boolean = DataGenerator.get_boolean()
            dummy_int = DataGenerator.get_int()
            dummy_float = DataGenerator.get_float()

        test_int = data_generator.get_by_type("int")
        print("test_int:" + str(test_int))

        test_boolean = data_generator.get_by_type("boolean")
        print("test_boolean:" + str(test_boolean))

        test_string = data_generator.get_by_type("string")
        print("test_string:" + test_string)

        test_float = data_generator.get_by_type("float")
        print("test_float:" + str(test_float))

        test_double = data_generator.get_by_type("double")
        print("test_double:" + str(test_double))

        test_bigint = data_generator.get_by_type("bigint")
        print("test_bigint:" + str(test_bigint))
