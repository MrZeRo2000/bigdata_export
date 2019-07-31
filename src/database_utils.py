
from config import Configuration
from context import inject, component
import math
import json
import pandas as pd
from logging import Logger
from log import log_method
from functools import reduce
from schema_processor import SchemaParser


class QueryRepository:
    ROWID_COLUMN_NAME = "ROWID_CHAR"
    QUERY_TEMPLATE = "SELECT ROWIDTOCHAR(ROWID) AS " + ROWID_COLUMN_NAME + ",{0} FROM {1} WHERE {2}"
    DEFAULT_PREDICATE = "1 = 1"
    TIMESTAMP_FORMAT = "%Y-%m-%dT%H:%M:%SZ"


@component
class QueryBuilder:

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
            predicate_string = QueryRepository.DEFAULT_PREDICATE
        else:
            predicate_string = predicate

        return QueryRepository.QUERY_TEMPLATE.format(column_names_string, table_name, predicate_string)


@component
class DataFrameFormatter:

    @staticmethod
    def format_as_json(df, column_types):
        # convert replacing TimeStamps
        result = list(df.apply(lambda row: dict(
            map(
                lambda x:
                (x, row[x.upper()])
                    if type(row[x.upper()]) != pd.Timestamp
                    else (x, row[x.upper()].strftime(QueryRepository.TIMESTAMP_FORMAT)),
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

        return df[QueryRepository.ROWID_COLUMN_NAME], json.dumps(result)

    @staticmethod
    def format_list_as_strings(data):
        return "'{}'".format(
            reduce(lambda s1, s2: "{}','{}".format(s1, s2), data)
        )
