
import requests
import os
import json
from schema_processor import SchemaParser, SchemaDataGenerator
from data_generatior import DataGenerator
from timeit import default_timer as timer
import logging
import csv
import datetime
import concurrent.futures
import asyncio
from aiohttp import ClientSession


class DummySchemaPerformanceRunner:
    URL = "https://gsq0mgv1i6.execute-api.eu-central-1.amazonaws.com/int/dummyevent"
    HEADERS = {"content-type": "application/json", "x-api-key": "HdnVmPVaPn8vq8pY3Zcs123oztXfBnPy9TGRIR63"}
    BATCH_SIZES = range(1, 100)

    LOG_FORMAT = "%(asctime)s %(levelname)s %(name)s %(module)s %(message)s"
    """Log format"""

    LOG_FILE_FORMAT = "log_{0:04d}-{1:02d}-{2:02d}.txt"

    def get_full_data_file_name(self, file_name: str) -> str:
        return os.path.join(self.__script_dir, "../data", file_name)

    def __init__(self):
        self.__script_dir = os.path.dirname(__file__)
        data_file_name = self.get_full_data_file_name("dummy_schema.txt")
        self.__schema_data = SchemaParser(data_file_name).parse()

        string_file_name = self.get_full_data_file_name("string_list.txt")
        self.__data_generator = DataGenerator(string_file_name)
        self.__data_generator.prepare()

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

    def run_multiple(self, num: int):
        for i in range(num):
            self.run_one()

    def run_set(self):
        self.__logger.log(logging.INFO, "Started running set")

        stats = {}
        for batch_size in self.BATCH_SIZES:
            self.__logger.log(logging.INFO, "Batch size = " + str(batch_size))

            start_time = timer()

            self.run_multiple(batch_size)

            end_time = timer()

            self.__logger.log(logging.INFO, "Execution time: " + str(end_time - start_time))
            stats.update({batch_size:end_time - start_time})

        stats_file_name = self.get_full_data_file_name("stats.txt")
        stats_file = csv.writer(open(stats_file_name, "w"), delimiter=",", quoting=csv.QUOTE_NONNUMERIC)
        stats_file.writerow(["ROWS", "TIME_IN_SECONDS"])
        for key, val in stats.items():
            stats_file.writerow([key, val])

        self.__logger.log(logging.INFO, "Finished running set")

    def run_set_parallel(self, size, num, num_workers):
        self.__logger.log(logging.INFO, "Started running parallel size={} num={} workers={}".format(size, num, num_workers))

        stats = {}
        parallel_sizes = [size for _ in range(num)]

        for workers in range(1, num_workers):
            self.__logger.log(logging.INFO, "Number of workers = " + str(workers))

            start_time = timer()

            with concurrent.futures.ThreadPoolExecutor(max_workers=workers) as executor:
                executor.map(self.run_multiple, parallel_sizes)

            end_time = timer()
            self.__logger.log(logging.INFO, "Execution time: " + str(end_time - start_time))

            stats.update({workers: end_time - start_time})

        parallel_stats_file_name = self.get_full_data_file_name("stats_{}_{}.txt".format(size, num))
        stats_file = csv.writer(open(parallel_stats_file_name, "w"), delimiter=",", quoting=csv.QUOTE_NONNUMERIC)
        stats_file.writerow(["WORKERS", "TIME_IN_SECONDS"])
        for key, val in stats.items():
            stats_file.writerow([key, val])

        self.__logger.log(logging.INFO, "Finished running parallel")

    def run_1m_parallel(self):
        self.__logger.log(logging.INFO, "Started running parallel 1m")

        parallel_sizes = [1000 for _ in range(1000)]

        start_time = timer()

        with concurrent.futures.ThreadPoolExecutor(max_workers=100) as executor:
            executor.map(self.run_multiple, parallel_sizes)

        end_time = timer()
        self.__logger.log(logging.INFO, "Execution time: " + str(end_time - start_time))

        self.__logger.log(logging.INFO, "Finished running parallel 1m")

    async def async_run_one(self, url, session):
        schema_data = self.__schema_data_generator.generate()

        async with session.post(url, headers=self.HEADERS, data=schema_data) as response:
            return await response.json(), response.status

    async def async_bound_run_one(self, sem, url, session):
        # Getter function with semaphore.
        async with sem:
            return await self.async_run_one(url, session)

    async def async_run(self, num):
        tasks = []
        # create instance of Semaphore
        sem = asyncio.Semaphore(1000)

        # Create client session that will ensure we dont open new connection
        # per each request.
        async with ClientSession() as session:
            for i in range(num):
                # pass Semaphore and session to every GET request
                task = asyncio.ensure_future(self.async_bound_run_one(sem, self.URL, session))
                tasks.append(task)

            responses = asyncio.gather(*tasks)
            return await responses

    def async_run_all(self, num):
        self.__logger.log(logging.INFO, "Started running async {}".format(num))
        start_time = timer()

        loop = asyncio.get_event_loop()

        future = asyncio.ensure_future(self.async_run(num))
        loop.run_until_complete(future)

        end_time = timer()
        self.__logger.log(logging.INFO, "Finished running async {}, elapsed time {} seconds".format(num, end_time - start_time))

        fr = future.result()
        fr_errors = [x for x in fr if x[1] != 201]

        self.__logger.log(logging.INFO, "Total: {}, errors:{}".format(len(fr), len(fr_errors)))

        if len(fr_errors) != 0:
            self.__logger.log(logging.CRITICAL, str(fr_errors))


if __name__ == "__main__":
    pass
    # DummySchemaPerformanceRunner().run_set()
    # DummySchemaPerformanceRunner().run_set_parallel()
    # DummySchemaPerformanceRunner().run_1m_parallel()
    # DummySchemaPerformanceRunner().run_set_parallel(10, 200, 20)
    # DummySchemaPerformanceRunner().async_run_all(1000000)

