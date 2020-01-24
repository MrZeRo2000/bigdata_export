
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
import time
from database_utils import DataFrameFormatter
import numpy as np
from export_service import ExportService


class ExportSeqService(ExportService):
    RETRY_DELAY = 1
    RETRY_COUNT_LIMIT = 10
    SERVER_RESPONSE_TIMEOUT = 60
    """
    Export data in sequence
    """

    def run_one(self, s, column_types, json_array_size, df, i):
        # prepare json data
        d = df.loc[i: i + json_array_size - 1, :]
        rowid_list, json_data = DataFrameFormatter.format_as_json(d, column_types)

        if self._log_messages:
            self.logger.debug("headers:{}".format(self._headers) + ";" + "data:{}".format(json_data),
                              {"headers": self._headers, "json_data": json_data})

        retry_count = 0

        while True:
            if retry_count > 0:
                self.logger.warning("Retry after unsuccessful transfer attempt {0:d} for {1:d} seconds".
                                    format(retry_count, self.RETRY_DELAY))
                time.sleep(self.RETRY_DELAY)

            try:
                response = s.post(self._url, data=json_data, timeout=self.SERVER_RESPONSE_TIMEOUT)
                if response.status_code == 201:
                    return response.json(), response.status_code, rowid_list
                else:
                    error_exception = None
                    error_response = response
                    self.logger.warning("Error response from the server: {}, details: {}, data: {}".
                                        format(str(error_response), response.json(), json_data))
            except Exception as e:
                self.logger.warning("Exception during transfer of {}: {}".format(str(rowid_list), str(e)))
                error_exception = e
                error_response = None

            retry_count = retry_count + 1

            if retry_count > self.RETRY_COUNT_LIMIT:
                if error_exception is not None:
                    return error_exception
                if error_response is not None:
                    return error_response.json(), error_response.status_code, rowid_list
                raise Exception("Unknown error processing {}".format(str(rowid_list)))

    def run_all(self, df, column_types, json_array_size=20):
        # fix for conversion of double type
        DataFrameFormatter.prepare_df(df, column_types)

        responses = []

        with requests.Session() as s:
            retries = Retry(total=10,
                            backoff_factor=0.5,
                            status_forcelist=[500, 502, 503, 504])

            s.mount('http://', HTTPAdapter(max_retries=retries))
            s.mount('https://', HTTPAdapter(max_retries=retries))
            s.headers.update(self._headers)

            for i in range(0, len(df), json_array_size):
                responses.append(self.run_one(s, column_types, json_array_size, df, i))

        return responses
