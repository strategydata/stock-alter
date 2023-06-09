from datetime import datetime

from stock_alerter.stock import Stock
from stock_alerter.rule import PriceRule


class FileReader:
    def __init__(self, filename,):
        self.filename = filename

    def parse_file(self):
        updates = []
        with open(self.filename, "r") as fp:
            for line in fp.readlines():
                symbol, timestamp, price = line.split(",")
                updates.append((symbol,
                                datetime.strptime(timestamp, "%Y-%m-%dT%H:%M:%S.%f"),
                                int(price)))
        return updates


class AlertProcessor:
    def __init__(self, autorun=True, reader=None, exchange=None):
    #     if exchange is None:
    #         self.exchange = {"GOOG": Stock("GOOG"), "AAPL": Stock("AAPL")}
    #     else:
    #         self.exchange = exchange
    #     rule_1 = PriceRule("GOOG", lambda stock: stock.price > 10)
    #     rule_2 = PriceRule("AAPL", lambda stock: stock.price > 5)
        
    #     self.exchange["GOOG"].updated.connect(
    #         lambda stock: print(stock.symbol, stock.price) \
    #             if rule_1.matches(self.exchange) else None)
    #     self.exchange["AAPL"].updated.connect(
    #         lambda stock: print(stock.symbol, stock.price) \
    #             if rule_2.matches(self.exchange) else None)

    #     updates = self.parse_csv()
    #     if autorun:
    #         self.mul_updates(updates)

    # def parse_csv(self):
    #     updates = []
    #     with open("updates.csv", "r") as fp:
    #         for line in fp.readlines():
    #             symbol, timestamp, price = line.split(",")
    #             updates.append((symbol, datetime.strptime(timestamp, "%Y-%m-%dT%H:%M:%S.%f"), int(price)))
    #     return updates

    # def mul_updates(self, updates):
    #     for symbol, timestamp, price in updates:
    #         stock = self.exchange[symbol]
    #         stock.update(timestamp, price)

        
        self.reader = reader if reader else FileReader("updates.csv")
        if exchange is None:
            self.exchange = {"GOOG": Stock("GOOG"), "AAPL": Stock("AAPL")}
        else:
            self.exchange = exchange
        rule_1 = PriceRule("GOOG", lambda stock: stock.price > 10)
        rule_2 = PriceRule("AAPL", lambda stock: stock.price > 5)
        self.exchange["GOOG"].updated.connect(lambda stock: self.print_action(stock, rule_1))
        self.exchange["AAPL"].updated.connect(lambda stock: self.print_action(stock, rule_2))
        if autorun:
            self.run()

    def print_action(self, stock, rule):
        print(stock.symbol, stock.price) \
            if rule.matches(self.exchange) else None

    def do_updates(self, updates):
        for symbol, timestamp, price in updates:
            stock = self.exchange[symbol]
            stock.update(timestamp, price)

    def run(self):
        updates = self.reader.parse_file()
        self.do_updates(updates)