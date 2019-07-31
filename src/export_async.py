
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

    # noinspection PyPropertyDefinition
    @property
    @inject
    def logger(self) -> Logger: pass

    # noinspection PyPropertyDefinition
    @property
    @inject
    def data_frame_formatter(self) -> DataFrameFormatter: pass

    async def run_one(self, session, json_data, rowid_list):
        async with session.post(self.__url, headers=self.__headers, data=json_data) as response:
            return await response.json(), response.status, rowid_list

    async def bound_run_one(self, sem, session, json_data, rowid_list):
        # Getter function with semaphore.
        async with sem:
            return await self.run_one(session, json_data, rowid_list)

    async def run(self, df, column_types):
        tasks = []
        # create instance of Semaphore
        sem = asyncio.Semaphore(1000)

        # Create client session that will ensure we dont open new connection
        # per each request.
        async with ClientSession() as session:
            for d in (df.loc[i: i + self.JSON_ARRAY_SIZE - 1, :] for i in range(0, len(df), self.JSON_ARRAY_SIZE)):
                # prepare json data
                rowid_list, json_data = self.data_frame_formatter.format_as_json(d, column_types)

                # pass Semaphore and session to every GET request
                task = asyncio.ensure_future(self.bound_run_one(sem, session, json_data, rowid_list))
                tasks.append(task)

            responses = asyncio.gather(*tasks)
            return await responses

    def run_all(self, df, column_types):
        loop = asyncio.get_event_loop()

        future = asyncio.ensure_future(self.run(df, column_types))
        loop.run_until_complete(future)

        return future.result()
