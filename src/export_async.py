
import asyncio
from aiohttp import ClientSession
from context import inject, component
from logging import Logger
from database_utils import DataFrameFormatter


class ExportAsyncService:
    """
    Export with data formatting sequentially as needed
    """

    def __init__(self, url, headers):
        self.__url = url
        self.__headers = headers
        self.__log_messages = False

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    @property
    def log_messages(self):
        return self.__log_messages

    @log_messages.setter
    def log_messages(self, value):
        self.__log_messages = value

    async def run_one(self, session, column_types, json_array_size, df, i):
        # prepare json data
        d = df.loc[i: i + json_array_size - 1, :]
        rowid_list, json_data = DataFrameFormatter.format_as_json(d, column_types)

        if self.__log_messages:
            self.logger.debug("headers:{}".format(self.__headers) + ";" + "data:{}".format(json_data),
                              {"headers": self.__headers, "json_data": json_data})

        async with session.post(self.__url, headers=self.__headers, data=json_data) as response:
            return await response.json(), response.status, rowid_list

    async def bound_run_one(self, sem, session, column_types, json_array_size, df, i):
        # Getter function with semaphore.
        async with sem:
            return await self.run_one(session, column_types, json_array_size, df, i)

    async def run(self, df, column_types, json_array_size):
        tasks = []
        # create instance of Semaphore
        sem = asyncio.Semaphore(1000)

        # Create client session that will ensure we dont open new connection
        # per each request.
        async with ClientSession() as session:
            for i in range(0, len(df), json_array_size):
                # pass Semaphore and session to every GET request
                task = asyncio.ensure_future(self.bound_run_one(sem, session, column_types, json_array_size, df, i))
                tasks.append(task)

            responses = asyncio.gather(*tasks, return_exceptions=True)
            return await responses

    def run_all(self, df, column_types, json_array_size=20):
#        loop = asyncio.get_event_loop()
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)

        future = asyncio.ensure_future(self.run(df, column_types, json_array_size))
        loop.run_until_complete(future)

        return future.result()


class ExportAsyncService2:
    """
    Export with data formatting in a separate code part
    """

    def __init__(self, url, headers):
        self.__url = url
        self.__headers = headers
        self.__log_messages = False

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

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

    async def run(self, df, column_types, json_array_size):
        tasks = []
        # create instance of Semaphore
        sem = asyncio.Semaphore(1000)

        self.logger.debug("preparing data")
        formatted_data = [DataFrameFormatter.format_as_json(
            df.loc[i: i + json_array_size - 1, :], column_types)
            for i in range(0, df.shape[0], json_array_size)]

        self.logger.debug("exporting data")
        # Create client session that will ensure we dont open new connection
        # per each request.
        async with ClientSession() as session:
            for i in range(0, len(formatted_data)):
                # pass Semaphore and session to every GET request
                task = asyncio.ensure_future(self.bound_run_one(sem, session, formatted_data, i))
                tasks.append(task)

            responses = asyncio.gather(*tasks)
            return await responses

    def run_all(self, df, column_types, json_array_size=20):
#        loop = asyncio.get_event_loop()
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)

        future = asyncio.ensure_future(self.run(df, column_types, json_array_size))
        loop.run_until_complete(future)

        return future.result()


class ExportAsyncService3:
    """
    Export prepared formatted data
    """

    def __init__(self, url, headers):
        self.__url = url
        self.__headers = headers
        self.__log_messages = False

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

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

    async def run(self, formatted_data):
        tasks = []
        # create instance of Semaphore
        sem = asyncio.Semaphore(1000)

        self.logger.debug("exporting data")
        # Create client session that will ensure we dont open new connection
        # per each request.
        async with ClientSession() as session:
            for i in range(0, len(formatted_data)):
                # pass Semaphore and session to every GET request
                task = asyncio.ensure_future(self.bound_run_one(sem, session, formatted_data, i))
                tasks.append(task)

            responses = asyncio.gather(*tasks)
            return await responses

    def run_all(self, formatted_data):
#        loop = asyncio.get_event_loop()
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)

        future = asyncio.ensure_future(self.run(formatted_data))
        loop.run_until_complete(future)

        # added to avoid Task was destroyed but it is pending!
        loop.close()

        return future.result()
