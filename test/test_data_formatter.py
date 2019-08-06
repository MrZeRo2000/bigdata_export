
import json
from unittest import TestCase, skip
from test_common import ContextTestCase
from oracle_utils import OracleReader
from database_utils import QueryBuilder, DataFrameFormatter
from schema_processor import SchemaParser
import pandas as pd
import math
import os
import datetime
import functools
from multiprocessing.pool import ThreadPool
from itertools import repeat
from concurrent.futures import ThreadPoolExecutor
from concurrent.futures import ProcessPoolExecutor


def format_df(df, column_types):
    return DataFrameFormatter.format_as_json(df, column_types)


class TestOracleDataFormatter(ContextTestCase):
    def setUp(self) -> None:
        ContextTestCase.setUp(self)
        self.configuration.load("../test/cfg/test.json", "../test/cfg/tables_dn_dict_prd_catalog_map.json")

    def test_dn_dict_prd_catalog_map(self):
        schema_file_name = self.configuration.get_schema_file_name("dn_dict_prd_catalog_map")
        schema_parser = SchemaParser(schema_file_name)

        column_types = schema_parser.get_column_types()
        columns_string = schema_parser.get_columns_string()

        query_text = QueryBuilder().get_query("dn_dict_prd_catalog_map", columns_string, "")

        with OracleReader(self.configuration.get()["database"]["connection"], query_text) as r:
            df = r.read(1000)
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

    @skip
    def test_parallel_processing(self):

        schema_file_name = self.configuration.get_schema_file_name("dn_dim_rate")
        schema_parser = SchemaParser(schema_file_name)

        column_types = schema_parser.get_column_types()
        columns_string = schema_parser.get_columns_string()

        query_text = QueryBuilder().get_query("dn_dim_rate", columns_string, "")

        data_file_name = "../data/test_data_100k.txt"
        if not os.path.isfile(data_file_name):
            print("file not found, generating")
            with OracleReader(self.configuration.get()["database"]["connection"], query_text) as r:
                df = r.read(1000000)
                df.to_csv(data_file_name, sep=";")
                print("file generated")

        df = pd.read_csv(data_file_name, sep=";")
        print("read data from file: {0:d} rows".format(df.shape[0]))

        dff = DataFrameFormatter()

        t1 = datetime.datetime.now()
        # rowid_list, json_data = dff.format_as_json(df, column_types)
        # formatted_data = [dff.format_as_json(df.loc[i: i + 20 - 1, :], column_types) for i in range(0, df.shape[0], 20)]

        with ProcessPoolExecutor(2) as executor:
            results_future = [executor.submit(format_df, df.loc[i: i + 20 - 1, :], column_types) for i in range(0, df.shape[0], 20)]

        results = [r.result() for r in results_future]

        t2 = datetime.datetime.now()
        print("Data formatting {0:.4f} seconds".format((t2-t1).total_seconds()))

