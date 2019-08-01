
from context import component, inject
from config import Configuration
from logging import Logger
from database_utils import QueryBuilder
from schema_processor import SchemaParser
from oracle_utils import OracleReader
from export_utils import ExportConfiguration
from export_async import ExportAsyncService
from concurrent.futures import ThreadPoolExecutor


@component
class TableExportService:
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

    def execute(self):
        if self.__table_name is None:
            raise Exception("Call 'prepare' method before calling 'execute'")

        self.logger.info("Started {}".format(self.__table_name))
        self.logger.debug(
            "Reading from database:{}, chunk size:{}".format(
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
            if self.__processing_params.get("read_export_tasks_parallel"):
                self.logger.debug("Read and export tasks are parallel")
                export_method = self.export_query_thread
            else:
                self.logger.debug("Read and export tasks are sequential")
                export_method = self.export_query

            source_row_count, error_rowids, error_responses = export_method(query_text)
            total_row_count += source_row_count - len(error_rowids)

            if len(error_rowids) == 0:
                break
            else:
                self.logger.info("Errors found, reprocessing rowids")
                self.logger.debug("Errors: {}".format(str(error_responses)))
                query_text = self.query_builder.get_query(
                    self.__table_name,
                    self.__column_names_string,
                    self.query_builder.get_rowids_predicate(error_rowids)
                )

        if len(error_rowids) != 0:
            raise Exception("Rowids left unprocessed in the last chunk: {0:d}".format(len(error_rowids)))

        self.logger.info("Finished {0}, rows: {1:d}".format(self.__table_name, total_row_count))
        return total_row_count

    def export_query(self, query_text):
        source_row_count = 0
        error_rowids = []
        error_responses = []
        with OracleReader(self.__database_connection_string, query_text) as r:
            self.logger.debug("reading chunk {0:d}".format(self.__database_chunk_size))
            for df in r.get(self.__database_chunk_size):
                data_size = df.shape[0]
                self.logger.debug("processing chunk {0:d}".format(data_size))
                source_row_count += data_size

                export_result = self.__export_service.run_all(df, self.__column_types)

                error_rowids.extend([item for sublist in [r[2] for r in export_result if r[1] != 201]
                                     for item in sublist])
                error_responses.extend([str(r[1]) + ":" + str(r[0]) for r in export_result if r[1] != 201])

                error_row_count = len(error_rowids)
                if error_row_count >= 1000:
                    raise Exception("Too many errors during processing of {}:{}, last result:{}, aborting".
                                    format(self.__table_name, error_row_count, str(export_result[-1:])))

                self.logger.debug("reading next chunk")

        return source_row_count, error_rowids, error_responses

    def threaded_read(self, reader: OracleReader):
        return reader.read(self.__database_chunk_size)

    def threaded_export(self, df):
        return self.__export_service.run_all(df, self.__column_types)

    def export_query_thread(self, query_text):
        source_row_count = 0
        error_rowids = []
        error_responses = []
        df = None
        export_future = None

        with OracleReader(self.__database_connection_string, query_text) as reader:
            while True:
                self.logger.debug("starting parallel working cycle")
                with ThreadPoolExecutor(max_workers=2) as executor:
                    self.logger.debug("reading next chunk")
                    reader_future = \
                        executor.submit(lambda r: r.read(self.__database_chunk_size), reader)

                    if df is not None:
                        self.logger.debug("exporting chunk {0:d}".format(df.shape[0]))
                        export_future = \
                            executor.submit(lambda d: self.__export_service.run_all(d, self.__column_types), df)
                    else:
                        self.logger.debug("no rows for exporting")

                self.logger.debug("working cycle complete")

                reader_response = reader_future.result()
                if reader_response is not None:
                    df = reader_response.copy()
                else:
                    self.logger.debug("no more rows read")
                    break

                data_size = df.shape[0]
                self.logger.debug("read chunk {0:d}".format(data_size))
                source_row_count += data_size

                if export_future is not None:
                    export_result = export_future.result()
                    if export_result is not None:
                        error_rowids.extend([item for sublist in [r[2] for r in export_result if r[1] != 201]
                                             for item in sublist])
                        error_responses.extend([str(r[1]) + ":" + str(r[0]) for r in export_result if r[1] != 201])

                        error_row_count = len(error_rowids)
                        if error_row_count >= 1000:
                            raise Exception("Too many errors during processing of {}:{}, last result:{}, aborting".
                                            format(self.__table_name, error_row_count, str(export_result[-1:])))

        return source_row_count, error_rowids, error_responses
