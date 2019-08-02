
import asyncio
from aiohttp import ClientSession
from context import inject, component
from logging import Logger
from database_utils import DataFrameFormatter


class ExportAsyncService:
    JSON_ARRAY_SIZE = 20

    def __init__(self, url, headers):
        self.__url = url
        self.__headers = headers
        self.__log_messages = False

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def data_frame_formatter(self) -> DataFrameFormatter: pass

    @property
    def log_messages(self):
        return self.__log_messages

    @log_messages.setter
    def log_messages(self, value):
        self.__log_messages = value

    async def run_one(self, session, column_types, df, i):
        # prepare json data
        d = df.loc[i: i + self.JSON_ARRAY_SIZE - 1, :]
        rowid_list, json_data = self.data_frame_formatter.format_as_json(d, column_types)

        if self.__log_messages:
            self.logger.debug("Logging message")
            self.logger.debug("headers:{}".format(self.__headers))
            self.logger.debug("data:{}".format(json_data))

        async with session.post(self.__url, headers=self.__headers, data=json_data) as response:
            return await response.json(), response.status, rowid_list

    async def bound_run_one(self, sem, session, column_types, df, i):
        # Getter function with semaphore.
        async with sem:
            return await self.run_one(session, column_types, df, i)

    async def run(self, df, column_types):
        tasks = []
        # create instance of Semaphore
        sem = asyncio.Semaphore(1000)

        # Create client session that will ensure we dont open new connection
        # per each request.
        async with ClientSession() as session:
            for i in range(0, len(df), self.JSON_ARRAY_SIZE):
                # pass Semaphore and session to every GET request
                task = asyncio.ensure_future(self.bound_run_one(sem, session, column_types, df, i))
                tasks.append(task)

            responses = asyncio.gather(*tasks)
            return await responses

    def run_all(self, df, column_types):
#        loop = asyncio.get_event_loop()
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)

        future = asyncio.ensure_future(self.run(df, column_types))
        loop.run_until_complete(future)

        return future.result()


class ExportAsyncService2:
    JSON_ARRAY_SIZE = 20

    def __init__(self, url, headers):
        self.__url = url
        self.__headers = headers
        self.__log_messages = False

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def data_frame_formatter(self) -> DataFrameFormatter: pass

    @property
    def log_messages(self):
        return self.__log_messages

    @log_messages.setter
    def log_messages(self, value):
        self.__log_messages = value

    async def run_one(self, session, data, i):
        # prepare json data
        rowid_list, json_data = data[i]

        if self.__log_messages:
            self.logger.debug("Logging message")
            self.logger.debug("headers:{}".format(self.__headers))
            self.logger.debug("data:{}".format(json_data))

        async with session.post(self.__url, headers=self.__headers, data=json_data) as response:
            return await response.json(), response.status, rowid_list

    async def bound_run_one(self, sem, session, data, i):
        # Getter function with semaphore.
        async with sem:
            return await self.run_one(session, data, i)

    async def run(self, df, column_types):
        tasks = []
        # create instance of Semaphore
        sem = asyncio.Semaphore(1000)

        self.logger.debug("Preparing data")
        formatted_data = [self.data_frame_formatter.format_as_json(
            df.loc[i: i + self.JSON_ARRAY_SIZE - 1, :], column_types)
            for i in range(0, df.shape[0], self.JSON_ARRAY_SIZE)]

        self.logger.debug("Exporting data")
        # Create client session that will ensure we dont open new connection
        # per each request.
        async with ClientSession() as session:
            for i in range(0, len(formatted_data)):
                # pass Semaphore and session to every GET request
                task = asyncio.ensure_future(self.bound_run_one(sem, session, formatted_data, i))
                tasks.append(task)

            responses = asyncio.gather(*tasks)
            return await responses

    def run_all(self, df, column_types):
#        loop = asyncio.get_event_loop()
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)

        future = asyncio.ensure_future(self.run(df, column_types))
        loop.run_until_complete(future)

        return future.result()
