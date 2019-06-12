
from unittest import TestCase
import os
import json
from schema_processor import SchemaParser


class TestSchemaParser(TestCase):
    def setUp(self) -> None:
        self.script_dir = os.path.dirname(__file__)
        self.data_file_name = os.path.join(self.script_dir, "../data", "dummy_schema.txt")
        self.assertTrue(os.path.isfile(self.data_file_name))

    def test_process(self):
        with open(self.data_file_name, 'r') as file:
            data = file.read()

        # fix equals
        data = data.replace(" = ", ":")

        # add quotes
        data = data.\
            replace("name", "\"name\"").\
            replace("type", "\"type\"").\
            replace("comment", "\"comment\"").\
            replace("schema_columns", "\"schema_columns\"")

        # add brackets
        data = "{" + data + "}"

        # ensure it is decoded
        json_data = json.loads(data)

        self.assertEqual("schema_columns", list(json_data.keys())[0])
        self.assertEqual(102, len(json_data["schema_columns"]))

    def test_schema_parser(self):
        data = SchemaParser(self.data_file_name).parse()
        self.assertEqual(102, len(data))

        print(data)
