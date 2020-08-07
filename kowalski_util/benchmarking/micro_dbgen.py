import sqlite3
import random
import datetime
import sys
import os


class MicroGen:
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

    @staticmethod
    def get_permutation(n: int):
        n = int(n)
        permut = list(range(n))
        random.shuffle(permut)
        assert len(permut) == n
        return permut

    def __init__(self, output, scale_factor: float = 1.0):
        self.scale_factor: float = float(scale_factor)

        self.output = output
        self.db: sqlite3.Connection = None
        self.connect()

        self.clients: List[Tuple[Any]] = list()
        self.sales: List[Tuple[Any]] = list()
        self.items: List[Tuple[Any]] = list()
        self.sales_items: List[Tuple[Any]] = list()

    def connect(self):
        self.db = sqlite3.connect(self.output)

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
        ids = MicroGen.get_permutation(n_sales)

        for i in ids:
            client = random.choice(self.clients)
            self.sales.append((
                i,
                MicroGen.random_float(0, 10000),
                client[0],
                str(MicroGen.random_date())
            ))

        self.execute_many(sql, self.sales)   

    def insert_clients(self):
        print("Generating clients")
        sql = "INSERT INTO Clients (C_ID, C_Name, C_CreatedAt, C_Address, C_Balance) VALUES (?, ?, ?, ?, ?)"
        
        n_clients = int(self.scale_factor * 1000)
        ids = MicroGen.get_permutation(n_clients)

        self.clients = list() 
        for i in ids:
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
        ids = MicroGen.get_permutation(n_items)

        for i in ids:
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
        ids = MicroGen.get_permutation(n_sale_item)
        for i in ids:
            item = random.choice(self.items)
            sale = random.choice(self.sales)
            self.sales_items.append((
                sale[0],
                item[0]
            ))

        self.execute_many(sql, self.sales_items)


def main():
    import sys
    if len(sys.argv) > 1:
        output = sys.argv[1]
    else:
        output = "micro.db"
    print(f"Output: {output}")

    if os.path.isfile(output):
        overwrite = False
        answer = input(f"File '{output}' exists. Overwrite? [y/N] ")
        if answer == "y":
            overwrite = True

        if not overwrite:
            sys.exit(2)
        else:
            os.unlink(output)
                


    scale_factor = 1.0
    for i, x in enumerate(sys.argv):
        x = x.strip('-')
        if x.lower() in ("scale_factor", "sf", "factor", "scale"):
            scale_factor = float(sys.argv[i + 1])

    gen = MicroGen(output=output, scale_factor=scale_factor)
    print(f"Generating with scale factor {gen.scale_factor}")
    gen.generate()
    gen.finalise()
    print("Done")


if __name__ == '__main__':
    main()
