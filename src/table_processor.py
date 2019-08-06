
from context import component, inject
from config import Configuration
from logging import Logger
from database_utils import QueryBuilder
from schema_processor import SchemaParser
from oracle_utils import OracleReader
from export_utils import ExportConfiguration
from export_async import ExportAsyncService, ExportAsyncService2, ExportAsyncService3
from concurrent import futures
from concurrent.futures import ThreadPoolExecutor
from database_utils import DataFrameFormatter
import pandas as pd


@component
class TableExportService:
    FORMATTED_DATE_SIZE = 20

    # noinspection PyPropertyDefinition
    @property
    @inject
    def configuration(self) -> Configuration: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def query_builder(self) -> QueryBuilder: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def export_configuration(self) -> ExportConfiguration: pass

    def __init__(self):
        self.__database_connection_string = self.__database_chunk_size = None
        self.__table_name = self.__predicate = None
        self.__column_types = self.__column_names_string = None
        self.__export_service = None
        self.__processing_params = None

    def prepare(self, table_info):
        self.__database_connection_string = self.configuration.get()["database"]["connection"]
        self.__database_chunk_size = self.configuration.get()["database"]["chunk_size"]
        self.__table_name = table_info["name"]
        self.__predicate = table_info.get("predicate")

        schema_file_name = self.configuration.get_schema_file_name(self.__table_name)
        schema_parser = SchemaParser(schema_file_name)
        self.__column_types = schema_parser.get_column_types()
        self.__column_names_string = schema_parser.get_columns_string()

        self.__processing_params = self.configuration.get()["processing"]

        self.__export_service = ExportAsyncService(*self.export_configuration.get_data(self.__table_name))
        self.__export_service.log_messages = self.__processing_params.get("log_messages")

    def execute(self):
        if self.__table_name is None:
            raise Exception("call 'prepare' method before calling 'execute'")

        self.logger.info("started {}".format(self.__table_name))
        self.logger.debug(
            "reading from database:{}, chunk size:{}".format(
                self.__database_connection_string,
                self.__database_chunk_size
            ))

        query_text = self.query_builder.get_query(self.__table_name, self.__column_names_string, self.__predicate)

        total_row_count = 0
        error_rowids = []
        for cycle_num in range(10):
            self.logger.debug("query:{}".format(query_text))
            self.logger.debug("processing cycle:{0:d}".format(cycle_num))

            # choose export method
            export_method = self.__processing_params.get("export_method")
            if export_method == "read_export_tasks_sequential":
                self.logger.debug("read and export tasks are sequential")
                export_method = self.export_query
            elif export_method == "read_export_tasks_parallel":
                self.logger.debug("read and export tasks are parallel")
                export_method = self.export_query_thread
            elif export_method == "read_format_export_tasks_parallel":
                self.logger.debug("read, format and export tasks are parallel")
                export_method = self.export_query_formatted_thread
            else:
                raise Exception("Unknown export method:{}".format(export_method))

            source_row_count, error_rowids, error_responses = export_method(query_text, cycle_num)
            total_row_count += source_row_count - len(error_rowids)

            if len(error_rowids) == 0:
                break
            else:
                self.logger.info("errors found, reprocessing rowids")
                self.logger.debug("errors: {}".format(str(error_responses)))
                query_text = self.query_builder.get_query(
                    self.__table_name,
                    self.__column_names_string,
                    self.query_builder.get_rowids_predicate(error_rowids)
                )

        if len(error_rowids) != 0:
            raise Exception("rowids left unprocessed in the last chunk: {0:d}".format(len(error_rowids)))

        self.logger.info("finished {0}, rows: {1:d}".format(self.__table_name, total_row_count))
        return total_row_count

    def get_chunk_size(self, cycle_num):
        """
        Returns read chunk size depending from processing cycle
        :param cycle_num: Processing cycle number
        :return: processing chunk size
        """
        if cycle_num in range(0, 5):
            return self.__database_chunk_size
        else:
            return 1

    def export_query(self, query_text, cycle_num):
        """
        Export query procedure with sequential reading, formatting and exporting data
        """
        source_row_count = 0
        error_rowids = []
        error_responses = []
        with OracleReader(self.__database_connection_string, query_text) as r:
            chunk_size = self.get_chunk_size(cycle_num)
            self.logger.debug("reading chunk {0:d}".format(chunk_size))
            for df in r.get(chunk_size):
                data_size = df.shape[0]
                self.logger.debug("processing chunk {0:d}".format(data_size))
                source_row_count += data_size

                export_result = self.__export_service.run_all(df, self.__column_types)
                export_exceptions = [r for r in export_result if type(r) == Exception]
                if export_exceptions is not None:
                    raise Exception("Export exceptions: {}".format(str(export_exceptions)))

                error_rowids.extend([item for sublist in [r[2] for r in export_result if r[1] != 201]
                                     for item in sublist])
                error_responses.extend([str(r[1]) + ":" + str(r[0]) for r in export_result if r[1] != 201])

                error_row_count = len(error_rowids)
                if error_row_count >= 1000:
                    raise Exception("too many errors during processing of {}:{}, last result:{}, aborting".
                                    format(self.__table_name, error_row_count, str(export_result[-1:])))

                self.logger.debug("reading next chunk")

        return source_row_count, error_rowids, error_responses

    def export_query_thread(self, query_text, cycle_num):
        """
        Export query procedure with ThreadPoolExecutor:
            load thread
            exporting data with formatting
        """
        source_row_count = 0
        error_rowids = []
        error_responses = []
        df = None
        export_future = None

        with OracleReader(self.__database_connection_string, query_text) as reader:
            chunk_size = self.get_chunk_size(cycle_num)
            while True:
                self.logger.debug("starting parallel working cycle")

                with ThreadPoolExecutor(max_workers=2) as executor:
                    self.logger.debug("reading next chunk {0:d}".format(chunk_size))
                    reader_future = \
                        executor.submit(lambda r: r.read(chunk_size), reader)

                    if df is not None:
                        self.logger.debug("exporting chunk {0:d}".format(df.shape[0]))
                        export_future = \
                            executor.submit(lambda d: self.__export_service.run_all(d, self.__column_types), df)
                    else:
                        self.logger.debug("no rows for exporting")

                exception_response = []
                reader_response = reader_future.result()
                if reader_response is not None:
                    if type(reader_response) == pd.DataFrame:
                        df = reader_response.copy()
                        data_size = df.shape[0]
                        self.logger.debug("read chunk {0:d}".format(data_size))
                        source_row_count += data_size
                    else:
                        reader_exceptions = [r for r in reader_response
                                             if type(reader_response) == list and isinstance(r, Exception)]
                        exception_response.extend({"process": "reader", "exceptions:": reader_exceptions})
                else:
                    self.logger.debug("no more rows read")

                if export_future is not None:
                    export_result = export_future.result()
                    if export_result is not None:
                        export_exceptions = [r for r in export_result
                                             if type(export_result) == list and isinstance(r, Exception)]
                        if len(export_exceptions) == 0:
                            error_rowids.extend([item for sublist in [r[2] for r in export_result if r[1] != 201]
                                                 for item in sublist])
                            error_responses.extend([str(r[1]) + ":" + str(r[0]) for r in export_result if r[1] != 201])

                            error_row_count = len(error_rowids)
                            if error_row_count >= 1000:
                                raise Exception("too many errors during processing of {}:{}, last result:{}, aborting".
                                                format(self.__table_name, error_row_count, str(export_result[-1:])))
                        else:
                            exception_response.extend([{"process": "exporter", "exceptions:": export_exceptions}])

                if len(exception_response) > 0:
                    raise Exception("Errors in executing working processes: {}".format(str(exception_response)))

                if reader_response is None:
                    break

        return source_row_count, error_rowids, error_responses

    def export_query_formatted_thread(self, query_text, cycle_num):
        """
        Export query procedure with ThreadPoolExecutor:
            load thread
            formatting thread
            exporting data
        """
        source_row_count = 0
        error_rowids = []
        error_responses = []
        df = None
        dff = None
        format_future = None
        export_future = None

        export_service = ExportAsyncService3(*self.export_configuration.get_data(self.__table_name))

        with OracleReader(self.__database_connection_string, query_text) as reader:
            chunk_size = self.get_chunk_size(cycle_num)
            while True:
                self.logger.debug("starting parallel working cycle")
                with ThreadPoolExecutor(max_workers=3) as executor:
                    self.logger.debug("reading next chunk {0:d}".format(chunk_size))
                    reader_future = \
                        executor.submit(lambda r: r.read(chunk_size), reader)

                    if df is not None:
                        self.logger.debug("formatting chunk {0:d}".format(df.shape[0]))
                        format_future = executor.submit(
                            lambda d, size, types: [DataFrameFormatter.format_as_json(d.loc[i: i + size - 1, :], types)
                             for i in range(0, d.shape[0], size)], df, self.FORMATTED_DATE_SIZE, self.__column_types
                        )
                        """
                        format_future = [executor.submit(
                            lambda d, column_types: DataFrameFormatter.format_as_json(d, column_types),
                            df.loc[i: i + self.FORMATTED_DATE_SIZE - 1, :], self.__column_types)
                            for i in range(0, df.shape[0], self.FORMATTED_DATE_SIZE)]
                        """
                    else:
                        self.logger.debug("no rows for formatting")
                        format_future = None

                    if dff is not None:
                        self.logger.debug("exporting chunk {0:d}".format(len(dff)))
                        export_future = \
                            executor.submit(lambda d: export_service.run_all(d), dff)
                    else:
                        self.logger.debug("no rows for exporting")
                        export_future = None

                self.logger.debug("working cycle complete")

                reader_response = reader_future.result()
                if reader_response is not None:
                    df = reader_response.copy()
                    data_size = df.shape[0]
                    self.logger.debug("read chunk {0:d}".format(data_size))
                    source_row_count += data_size
                else:
                    self.logger.debug("no more rows read")
                    df = None
#                    break

                if format_future is not None:
#                    format_results = [r.result() for r in format_future]
                    format_results = format_future.result()

                    if format_results is not None:
                        dff = format_results
                    else:
                        dff = None
                else:
                    dff = None

                if export_future is not None:
                    export_result = export_future.result()
                    if export_result is not None:
                        error_rowids.extend([item for sublist in [r[2] for r in export_result if r[1] != 201]
                                             for item in sublist])
                        error_responses.extend([str(r[1]) + ":" + str(r[0]) for r in export_result if r[1] != 201])

                        error_row_count = len(error_rowids)
                        if error_row_count >= 1000:
                            raise Exception("too many errors during processing of {}:{}, last result:{}, aborting".
                                            format(self.__table_name, error_row_count, str(export_result[-1:])))

                if df is None and dff is None:
                    self.logger.debug("no more actions")
                    break

        return source_row_count, error_rowids, error_responses
