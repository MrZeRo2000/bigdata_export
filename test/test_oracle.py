
from unittest import TestCase, skip
from oracle_utils import OracleReader
import logging


class TestOracleReader(TestCase):
    def setUp(self) -> None:
        self.connection_string = "drivenow_bi/drivenow_bi@sxbistax"

    def test_basic_reader(self):
        with OracleReader(self.connection_string, "SELECT * FROM dual") as r:
            df = r.read(10)
            self.assertIs(1, len(df))

    @skip
    def test_read_1m(self):
        with OracleReader(self.connection_string, "SELECT * FROM dn_fact_prd_usage_details") as r:
            df = r.read(100000)
            self.assertEqual(100000, len(df))

    def test_get(self):
        with OracleReader(self.connection_string, "SELECT * FROM dual") as r:
            for d in r.get(1000):
                logging.info("test get")
                pass

    @skip
    def test_get_customer_v2(self):
        with OracleReader(self.connection_string, "SELECT * FROM dn_dim_customer_v2") as r:
            for d in r.get(100000):
                print("Read {} rows".format(d.shape[0]))
                pass
