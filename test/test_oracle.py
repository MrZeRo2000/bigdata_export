
from unittest import TestCase
from oracle_utils import OracleReader


class TestOracleReader(TestCase):
    def setUp(self) -> None:
        self.connection_string = "drivenow_bi/drivenow_bi@sxbistax"

    def test_basic_reader(self):
        with OracleReader(self.connection_string, "SELECT * FROM dual") as r:
            df = r.read(10)
            self.assertIs(1, len(df))

    def test_read_1m(self):
        with OracleReader(self.connection_string, "SELECT * FROM dn_fact_prd_usage_details") as r:
            df = r.read(100000)
            self.assertEqual(100000, len(df))