
import asyncio
from aiohttp import ClientSession
import os
from schema_processor import SchemaParser, SchemaDataGenerator
from data_generatior import DataGenerator


from unittest import TestCase


class TestAIOHttp(TestCase):
    URL = "https://gsq0mgv1i6.execute-api.eu-central-1.amazonaws.com/int/dummyevent"
    HEADERS = {"content-type": "application/json", "x-api-key": "HdnVmPVaPn8vq8pY3Zcs123oztXfBnPy9TGRIR63"}

    def setUp(self) -> None:
        script_dir = os.path.dirname(__file__)

        data_file_name = os.path.join(script_dir, "../data", "dummy_schema.txt")
        self.assertTrue(os.path.isfile(data_file_name))
        self.schema_data = SchemaParser(data_file_name).parse()

        string_file_name = os.path.join(script_dir, "../data", "string_list.txt")
        self.data_generator = DataGenerator(string_file_name)
        self.data_generator.prepare()

    async def fetch(self, session, url):
        data_generator = SchemaDataGenerator(self.schema_data, self.data_generator)
        data = data_generator.generate()

        async with session.post(url, headers=self.HEADERS, data=data) as response:
            return await response.json(), response.status

    async def main(self):
        async with ClientSession() as session:
            response, status = await self.fetch(session, self.URL)
            print(response)

    def test_request(self):
        loop = asyncio.get_event_loop()
        loop.run_until_complete(self.main())