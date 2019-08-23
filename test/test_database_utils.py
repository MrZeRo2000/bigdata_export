
from test_common import ContextTestCase
from database_utils import QueryBuilder


class TestQueryBuilder(ContextTestCase):

    def setUp(self) -> None:
        ContextTestCase.setUp(self)
        self.configuration.load("../test/cfg/test.json", "../test/cfg/tables_dim_promocode_category.json")

    def test_query_builder(self):
        query_text = QueryBuilder().get_query("dm_dim_promocode_category", "category,category_name,insert_date", "")
        self.assertEqual("SELECT ROWIDTOCHAR(ROWID) AS ROWID_CHAR,category,category_name,insert_date " +
                         "FROM dm_dim_promocode_category WHERE 1 = 1", query_text)


