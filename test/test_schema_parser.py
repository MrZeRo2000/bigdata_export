
from unittest import TestCase
import os
import json
import re
from functools import reduce
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


class TestSchemaParserTF(TestCase):
    """
    Schema parser for TF files
    """
    def setUp(self) -> None:
        self.script_dir = os.path.dirname(__file__)
        # self.data_file_name = os.path.join(self.script_dir, "../schema", "schema_dn_dim_prd_catalog_l1.tf")
        self.data_file_name = os.path.join(self.script_dir, "../schema", "schema_jv_payment_instrument.tf")
        self.assertTrue(os.path.isfile(self.data_file_name))

    def test_process(self):
        with open(self.data_file_name, 'r') as file:
            data = file.read()

        # fix equals 2
        data = re.sub(r"(\s*)=(\s*)", ":", data)

        # fix equals
        # data = data.replace(" = ", ":")

        data = re.search(r'schema_columns:\[(.*?)\]', data, re.DOTALL).group(0)

        # add quotes 3
        data = reduce(lambda prev, current: re.sub(r"{}(\s*):".format(current), "\"{}\":".format(current), prev),
               [data, "name", "type", "comment", "schema_columns"])

        # add quotes 2
        # data = re.sub("name(\\s*):", "\"name\":", data)
        # data = re.sub("type(\\s*):", "\"type\":", data)
        # data = re.sub("comment(\\s*):", "\"comment\":", data)
        # data = re.sub("schema_columns(\\s*):", "\"schema_columns\":", data)

        # add quotes
        # data = data.\
        #     replace("name:", "\"name\":").\
        #     replace("type", "\"type\"").\
        #     replace("comment", "\"comment\"").\
        #     replace("schema_columns", "\"schema_columns\"")

        # add brackets
        data = "{" + data + "}"

        # ensure it is decoded
        json_data = json.loads(data)

        self.assertEqual("schema_columns", list(json_data.keys())[0])
        self.assertEqual(4, len(json_data["schema_columns"]))

    def test_schema_parser_tf_v1(self):
        schema_parser = SchemaParser(os.path.join(self.script_dir, "../schema", "schema_dn_dim_prd_catalog_l1.tf"))
        data = schema_parser.parse()
        self.assertEqual(6, len(data))

        print("TF schema parsed")
        print(data)

        column_types = schema_parser.get_column_types()
        self.assertEqual("double", column_types["id"])

    def test_schema_parser_tf_v2(self):
        schema_parser = SchemaParser(os.path.join(self.script_dir, "../schema", "schema_jv_payment_instrument.tf"))
        data = schema_parser.parse()
        self.assertEqual(4, len(data))

        print("TF schema parsed")
        print(data)

        column_types = schema_parser.get_column_types()
        self.assertEqual("string", column_types["status"])
