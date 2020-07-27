import sqlite3
import random
import datetime
import sys


class MicroGen:
    def __init__(self, scale_factor: float = 1.0):
        self.scale_factor: float = float(scale_factor)

        self.db: sqlite3.Connection = None
        self.connect()

        self.clients: List[Tuple[Any]] = list()
        self.sales: List[Tuple[Any]] = list()
        self.items: List[Tuple[Any]] = list()
        self.sales_items: List[Tuple[Any]] = list()

    def connect(self):
        self.db = sqlite3.connect("micro.db")

    def create_schema(self):
        with open("microdb_schema.sql") as f:
            sql = f.read()

        self.db.executescript(sql)

    def generate(self):
        self.create_schema()
        self.insert_clients()
        self.insert_sales()
        self.insert_items()
        self.insert_sale_item()

    def finalise(self):
        self.db.commit()
        self.db.close()
        self.db = None

    def execute_many(self, sql, data):
        cur = self.db.cursor()
        cur.executemany(sql, data)
        cur.close()
        
        self.db.commit()

    def insert_sales(self):
        print("Generating sales")
        sql = "INSERT INTO Sales (S_ID, S_Price, S_Client, S_Date) VALUES (?, ?, ?, ?)"

        n_sales = int(10000 * self.scale_factor)
        for i in range(n_sales):
            client = random.choice(self.clients)
            self.sales.append((
                i,
                MicroGen.random_float(0, 10000),
                client[0],
                str(MicroGen.random_date())
            ))

        self.execute_many(sql, self.sales)   

    @staticmethod
    def random_name(length: int): 
        alphabet = [chr(c) for c in range(ord('a'), ord('z') + 1)]
        return "".join(random.choice(alphabet) for _ in range(length))

    @staticmethod
    def random_float(min: float, max: float):
        return random.randrange(1000 * min, 1000 * max) / float(1000)
    
    @staticmethod
    def random_date():
        base = datetime.datetime(1970, 1, 1, 0, 0, 0, 0)
        now = datetime.datetime.now()
        diff = (now - base).total_seconds()
        offset = random.randrange(0, int(diff))
        result = base + datetime.timedelta(seconds=offset)
        return result

    @staticmethod
    def random_int(min: int, max: int):
        return random.randint(min, max)

    def insert_clients(self):
        print("Generating clients")
        sql = "INSERT INTO Clients VALUES (?, ?, ?, ?, ?)"
        for i in range(int(self.scale_factor * 1000)):
            self.clients.append((
                i, 
                MicroGen.random_name(16), 
                str(MicroGen.random_date()), 
                MicroGen.random_name(256), 
                MicroGen.random_float(-500, 500)
            ))

        self.execute_many(sql, self.clients)    

    def insert_items(self):
        print("Generating items")
        sql = "INSERT INTO Items VALUES (?, ?, ?, ?)"
        n_items = int(100000 * self.scale_factor)
        for i in range(n_items):
            self.items.append((
                i,
                MicroGen.random_name(64),
                MicroGen.random_float(0, 2048),
                MicroGen.random_int(1, 50)
            ))

        self.execute_many(sql, self.items)

    def insert_sale_item(self):
        print("Generating SaleItems")
        sql = "INSERT INTO SaleItem VALUES (?, ?)"
        n_sale_item = int(75000 * self.scale_factor)
        for i in range(n_sale_item):
            item = random.choice(self.items)
            sale = random.choice(self.sales)
            self.sales_items.append((
                sale[0],
                item[0]
            ))

        self.execute_many(sql, self.sales_items)


def main():
    scale_factor = 1.0
    for i, x in enumerate(sys.argv):
        x = x.strip('-')
        if x.lower() in ("scale_factor", "sf", "factor", "scale"):
            scale_factor = float(sys.argv[i + 1])

    gen = MicroGen(scale_factor=scale_factor)
    print(f"Generating with scale factor {gen.scale_factor}")
    gen.generate()
    gen.finalise()
    print("Done")


if __name__ == '__main__':
    main()