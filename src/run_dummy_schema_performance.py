
import requests
import os
import json
from schema_processor import SchemaParser, SchemaDataGenerator
from data_generatior import DataGenerator
from timeit import default_timer as timer
import logging
import csv
import datetime


class DummySchemaPerformanceRunner:
    URL = "https://gsq0mgv1i6.execute-api.eu-central-1.amazonaws.com/int/dummyevent"
    HEADERS = {"content-type": "application/json", "x-api-key": "HdnVmPVaPn8vq8pY3Zcs123oztXfBnPy9TGRIR63"}
    BATCH_SIZES = range(1, 100)

    LOG_FORMAT = "%(asctime)s %(levelname)s %(name)s %(module)s %(message)s"
    """Log format"""

    LOG_FILE_FORMAT = "log_{0:04d}-{1:02d}-{2:02d}.txt"

    def __init__(self):
        script_dir = os.path.dirname(__file__)
        data_file_name = os.path.join(script_dir, "../data", "dummy_schema.txt")
        self.__schema_data = SchemaParser(data_file_name).parse()

        string_file_name = os.path.join(script_dir, "../data", "string_list.txt")
        self.__data_generator = DataGenerator(string_file_name)
        self.__data_generator.prepare()

        self.__stats_file_name = os.path.join(script_dir, "../data", "stats.txt")

        self.__schema_data_generator = SchemaDataGenerator(self.__schema_data, self.__data_generator)

        log_formatter = logging.Formatter(self.LOG_FORMAT)

        self.__logger = logging.getLogger("DummySchemaPerformanceRunner")
        self.__logger.setLevel(logging.DEBUG)

        console_handler = logging.StreamHandler()
        console_handler.setLevel(logging.DEBUG)
        console_handler.setFormatter(log_formatter)

        self.__logger.addHandler(console_handler)

        today = datetime.datetime.now()
        log_path = os.path.join(os.path.dirname(__file__), "../log")
        log_file_name = os.path.join(log_path, self.LOG_FILE_FORMAT.format(today.year, today.month, today.day))
        file_handler = logging.FileHandler(log_file_name)
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(log_formatter)

        self.__logger.addHandler(file_handler)

    def run_one(self):
        schema_data = self.__schema_data_generator.generate()

        r = requests.post(self.URL, data=schema_data, headers=self.HEADERS)
        if r.status_code != 201:
            raise ValueError("Error processing data:" + r.content.decode("utf-8"))

    def run_set(self):
        self.__logger.log(logging.INFO, "Started running set")

        stats = {}
        for batch_size in self.BATCH_SIZES:
            self.__logger.log(logging.INFO, "Batch size = " + str(batch_size))

            start_time = timer()

            for i in range(batch_size):
                self.run_one()

            end_time = timer()

            self.__logger.log(logging.INFO, "Execution time: " + str(end_time - start_time))
            stats.update({batch_size:end_time - start_time})

        stats_file = csv.writer(open(self.__stats_file_name, "w"), delimiter=",", quoting=csv.QUOTE_NONNUMERIC)
        stats_file.writerow(["ROWS", "TIME_IN_SECONDS"])
        for key, val in stats.items():
            stats_file.writerow([key, val])

        self.__logger.log(logging.INFO, "Finished running set")


if __name__ == "__main__":
    DummySchemaPerformanceRunner().run_set()
