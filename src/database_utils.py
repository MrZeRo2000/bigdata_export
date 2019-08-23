from context import inject, component
import math
import json
import pandas as pd
from pandas import NaT
import datetime
from functools import reduce


class QueryRepository:
    ROWID_COLUMN_NAME = "ROWID_CHAR"
    QUERY_TEMPLATE = "SELECT ROWIDTOCHAR(ROWID) AS " + ROWID_COLUMN_NAME + ",{0} FROM {1} WHERE {2}"
    DEFAULT_PREDICATE = "1 = 1"
    ROWID_PREDICATE = "ROWID IN({})"
    TIMESTAMP_FORMAT = "%Y-%m-%dT%H:%M:%SZ"


@component
class QueryBuilder:

    @staticmethod
    def get_query(table_name, column_names_string, predicate):
        if predicate is None or predicate == "":
            predicate_string = QueryRepository.DEFAULT_PREDICATE
        else:
            predicate_string = predicate

        return QueryRepository.QUERY_TEMPLATE.format(column_names_string, table_name, predicate_string)

    @staticmethod
    def get_rowids_predicate(rowids):
        return QueryRepository.ROWID_PREDICATE.format(
            "'{}'".format(
                reduce(lambda s1, s2: "{}','{}".format(s1, s2), rowids)
            )
        )


class DataFrameFormatter:

    @staticmethod
    def format_as_json(df, column_types):
        # convert replacing TimeStamps
        result = list(df.apply(lambda row: dict(
            map(
                lambda x:
                (x, row[x.upper()])
                if type(row[x.upper()]) not in [pd.Timestamp, datetime.datetime]
                else (x, row[x.upper()].strftime(QueryRepository.TIMESTAMP_FORMAT)),
                column_types)
        ), axis=1))

        # remove NULL and float NAN and NaT
        result = list(map(
            lambda x: {
                k: v for k, v in x.items()
                if v is not None
                   and not isinstance(v, type(NaT))
                   and (type(v) != float or (type(v) == float and not math.isnan(v)))
            },
            result)
        )

        # to capture data unable to serialize
        try:
            json_data = json.dumps(result)
        except TypeError as e:
            raise TypeError("Unable to serialize: {}, error message: {}".format(str(result), str(e)))
        except Exception as e:
            raise Exception("Exception during serialization: {}, error message: {}".format(str(result), str(e)))

        return df[QueryRepository.ROWID_COLUMN_NAME].tolist(), json_data

    @staticmethod
    def format_list_as_strings(data):
        return "'{}'".format(
            reduce(lambda s1, s2: "{}','{}".format(s1, s2), data)
        )
