
from app import AppContext
from config import Configuration
from context import inject, component
import sys
import math
import json
import pandas as pd
from logging import Logger
from log import log_method
from schema_processor import SchemaParser


@component
class QueryBuilder:
    QUERY_TEMPLATE = "SELECT ROWIDTOCHAR(ROWID) AS rowid_char,{0} FROM {1} WHERE {2}"
    DEFAULT_PREDICATE = "1 = 1"

    # noinspection PyPropertyDefinition
    @property
    @inject
    def configuration(self) -> Configuration: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    def get_query(self, table_name, predicate):
        schema_file_name = self.configuration.get_schema_file_name(table_name)
        schema_parser = SchemaParser(schema_file_name)
        column_names_string = schema_parser.get_columns_string()

        if predicate is None or predicate == "":
            predicate_string = self.DEFAULT_PREDICATE
        else:
            predicate_string = predicate

        return self.QUERY_TEMPLATE.format(column_names_string, table_name, predicate_string)


@component
class DataFrameFormatter:
    TIMESTAMP_FORMAT = "%Y-%m-%dT%H:%M:%SZ"

    @staticmethod
    def format_as_json(df, column_types):
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

        return json.dumps(result)
