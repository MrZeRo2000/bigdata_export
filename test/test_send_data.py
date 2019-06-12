
from unittest import TestCase
import requests
import os
import json
from schema_processor import SchemaParser, SchemaDataGenerator
from data_generatior import DataGenerator


class TestSendData(TestCase):
    def setUp(self) -> None:
        script_dir = os.path.dirname(__file__)
        data_file_name = os.path.join(script_dir, "../data", "dummy_schema.txt")
        self.assertTrue(os.path.isfile(data_file_name))
        self.schema_data = SchemaParser(data_file_name).parse()

        string_file_name = os.path.join(script_dir, "../data", "string_list.txt")
        self.data_generator = DataGenerator(string_file_name)
        self.data_generator.prepare()

    def test_send_one(self):
        data_generator = SchemaDataGenerator(self.schema_data, self.data_generator)
        data = data_generator.generate()

        url = "https://gsq0mgv1i6.execute-api.eu-central-1.amazonaws.com/int/dummyevent"
        headers = {"content-type": "application/json", "x-api-key": "HdnVmPVaPn8vq8pY3Zcs123oztXfBnPy9TGRIR63"}

        r = requests.post(url, data=data, headers=headers)
        self.assertEqual(201, r.status_code)
        print(r.content.decode("utf-8"))
