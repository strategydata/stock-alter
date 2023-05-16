import unittest
from datetime import datetime
from stock_alerter.stock import Stock
class StockTest(unittest.TestCase):
    def test_price_of_a_new_stock_class_should_be_None(self):
        stock = Stock("GOOG")
        self.assertIsNone(stock.price)

    def test_stock_update(self):
        """
        
        """
        stock = Stock("GOOG")
        stock.update(datetime(2014, 2, 12), price=10)
        self.assertEqual(10, stock.price)