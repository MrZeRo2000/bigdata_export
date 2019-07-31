
import json
from unittest import TestCase
from test_common import ContextTestCase
from oracle_utils import OracleReader
from database_utils import QueryBuilder, DataFrameFormatter
from schema_processor import SchemaParser
import pandas as pd
import math


class TestOracleDataFormatter(ContextTestCase):
    def setUp(self) -> None:
        ContextTestCase.setUp(self)
        self.configuration.load("../test/cfg/test.json", "../test/cfg/tables_dn_dict_prd_catalog_map.json")

    def test_dn_dict_prd_catalog_map(self):
        query_text = QueryBuilder().get_query("dn_dict_prd_catalog_map", "")

        schema_file_name = self.configuration.get_schema_file_name("dn_dict_prd_catalog_map")
        schema_parser = SchemaParser(schema_file_name)
        column_types = schema_parser.get_column_types()

        with OracleReader(self.configuration.get()["database"]["connection"], query_text) as r:
            df = r.read(10)
            pass

        result = []
        for row in df.iterrows():
            result.append(dict(map(lambda x: (x, row[1][x.upper()]), column_types)))

#        result = list(df.apply(lambda row: dict(map(lambda x: (x, row[x.upper()]), column_types)), axis=1))

        # convert replacing TimeStamps
        result = list(df.apply(lambda row: dict(
            map(
                lambda x:
                (x, row[x.upper()])
                    if type(row[x.upper()]) != pd.Timestamp else (x, row[x.upper()].strftime('%Y-%m-%dT%H:%M:%SZ')),
                column_types)
        ),axis=1))

        # remove NULL and float NAN
        result = list(map(
            lambda x: {
                k: v for k, v in x.items()
                if v is not None and (type(v) != float or (type(v) == float and not math.isnan(v)))
            },
            result)
        )

        result_json = json.dumps(result)
        print(result_json)

        dff = DataFrameFormatter()

        rowid_list, json_data = dff.format_as_json(df, column_types)
        print("rowid_list:" + str(rowid_list))
        print("json_data:" + json_data)
        print("formatted rowid_list:" + dff.format_list_as_strings(rowid_list))
