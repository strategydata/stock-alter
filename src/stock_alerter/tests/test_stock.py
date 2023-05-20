import unittest
from datetime import datetime
from stock_alerter.stock import Stock
class StockTest(unittest.TestCase):
    def setUp(self) -> None:
        self.stock = Stock("GOOG")
    
    def test_price_of_a_new_stock_class_should_be_None(self):
        self.assertIsNone(self.stock.price)

    def test_stock_update(self):
        """
        
        """
        
        self.stock.update(datetime(2014, 2, 12), price=10)
        self.assertEqual(10, self.stock.price)
        
    def test_negative_price_should_throw_ValueError(self):
        
        with self.assertRaises(ValueError):
            self.stock.update(datetime(2014, 2, 13), -1)
        
    def test_stock_price_should_give_the_latest_price(self):
        self.stock.update(datetime(2014, 2, 12), price=10)
        self.stock.update(datetime(2014, 2, 13), price=8.4)
        self.assertAlmostEqual(8.4, self.stock.price, delta=0.0001)
        
        

'''
assertIsNone
assertEqual
assertRaises
assertAlmostEqual
fail


assertFalse(x, msg), assertTrue(x, msg)
assertIsNone(x, msg), assertIsNotNone(x, msg)
assertEqual(x, y, msg), assertNotEqual(x, y, msg)
assertAlmostEqual(x, y, places, msg, delta), assertNotAlmostEqual(x, y, places, msg, delta)
assertGreater(x, y, msg), assertGreaterEqual(x, y, msg)
assertLess(x, y, msg), assertLessEqual(x, y, msg)
assertIs(x, y, msg), assertIsNot(x, y, msg)
assertIn(x, seq, msg), assertNotIn(x, seq, msg)
assertIsInstance(x, cls, msg), assertNotIsInstance(x, cls, msg)
assertRegex(text, regex, msg), assertNotRegex(text, regex, msg)
assertRaises(exception, callable, *args, **kwargs)
fail(msg)



import unittest

def setUpModule():
    print("setUpModule")

def tearDownModule():
    print("tearDownModule")

class Class1Test(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        print("  setUpClass")

    @classmethod
    def tearDownClass(cls):
        print("  tearDownClass")

    def setUp(self):
        print("       setUp")

    def tearDown(self):
        print("       tearDown")

    def test_1(self):
        print("         class 1 test 1")

    def test_2(self):
        print("         class 1 test 2")

class Class2Test(unittest.TestCase):
    def test_1(self):
        print("         class 2 test 1")


output:

setUpModule
  setUpClass
       setUp
         class 1 test 1
       tearDown
       setUp
         class 1 test 2
       tearDown
  tearDownClass
         class 2 test 1
tearDownModule



Class level and module level setups are only used when there is an expensive setup step, such as making a connection to a database or a remote server, and it is preferable to do this setup just once and share it between all the tests.

'''        