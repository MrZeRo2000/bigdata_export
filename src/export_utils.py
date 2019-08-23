
from context import inject, component
from config import Configuration


@component
class ExportConfiguration:

    # noinspection PyPropertyDefinition
    @property
    @inject
    def configuration(self) -> Configuration: pass

    def get_url(self, table_name: str) -> str:
        return self.configuration.get_big_data_params().get("url").format(table_name)

    def get_headers(self):
        return {
            "content-type": "application/json",
            "x-api-key": self.configuration.get_big_data_params().get("api_key")
        }

    def get_data(self, table_name: str):
        return self.get_url(table_name), self.get_headers()
