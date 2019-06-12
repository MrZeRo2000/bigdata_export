
from unittest import TestCase
import os
import json
from schema_processor import SchemaParser, SchemaDataGenerator
from data_generatior import DataGenerator


class TestSchemaDataGenerator(TestCase):
    def setUp(self) -> None:
        script_dir = os.path.dirname(__file__)
        data_file_name = os.path.join(script_dir, "../data", "dummy_schema.txt")
        self.assertTrue(os.path.isfile(data_file_name))
        self.schema_data = SchemaParser(data_file_name).parse()

        string_file_name = os.path.join(script_dir, "../data", "string_list.txt")
        self.data_generator = DataGenerator(string_file_name)
        self.data_generator.prepare()

    def test_schema_data_generator(self):
        data_generator = SchemaDataGenerator(self.schema_data, self.data_generator)
        data = data_generator.generate()
        self.assertIsNotNone(data, "Empty data")
