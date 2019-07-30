
import cx_Oracle
import pandas as pd


class OracleReader(object):
    def __init__(self, connection_string: str, sql_text: str):
        self.__connection_string = connection_string
        self.__sql_text = sql_text

    def read(self, limit):
        rows = self.__cursor.fetchmany(limit)
        if len(rows) == 0:
            return None

        df = pd.DataFrame(rows)
        df.columns = self.__column_names

        return df

    def __enter__(self):
        self.__connection = cx_Oracle.connect(self.__connection_string)
        self.__cursor = self.__connection.cursor()
        self.__cursor.execute(self.__sql_text)
        self.__column_names = [col[0] for col in self.__cursor.description]

        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.__cursor is not None:
            self.__cursor.close()

        if self.__connection is not None:
            self.__connection.close()
