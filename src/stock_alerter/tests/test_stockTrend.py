import unittest
from stock_alerter.stock import Stock
import datetime

class StockTrendTest(unittest.TestCase):
    def setUp(self):
        self.trend = Stock("GOOG")
    def given_a_series_of_prices(self, prices):
        timestamps = [datetime(2014, 2, 11), datetime(2014, 2, 12), datetime(2014, 2, 13)]
        for timestamp,price in zip(timestamps,prices):
            self.trend.update(timestamp, price)
            
    def test_increasing_trend_is_true_if_price_increase_for_3_updates(self):
        self.given_a_series_of_prices([8, 10, 12])
        self.assertTrue(self.trend.is_increasing_trend())
        
    def test_increasing_trend_is_false_if_price_decreases(self):
        self.given_a_series_of_prices([8, 12, 10])
        self.assertFalse(self.trend.is_increasing_trend())
        
    def test_increasing_trend_is_false_if_price_equal(self):
        self.given_a_series_of_prices([8, 10, 10])
        self.assertFalse(self.trend.is_increasing_trend())
    
