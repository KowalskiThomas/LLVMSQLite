import sqlite3

class MicroGen:
    def __init__(self, scale_factor: float = 1.0):
        self.scale_factor = scale_factor

        self.connect()

        self.db: sqlite3.Connection = None
        self.connect()

    def connect(self):
        self.db = sqlite3.connect("micro.db")

    def generate(self):
        self.insert_clients()
        self.insert_sales()
        self.insert_items()
        self.insert_sale_item()

    def finalise(self):
        self.db.commit()
        self.db.close()
        self.db = None

    def insert_sales(self):
        pass

    def insert_clients(self):
        pass

    def insert_items(self):
        pass

    def insert_sale_item(self):
        pass


def main():
    gen = MicroGen()
    print("Generating")
    gen.generate()
    gen.finalise()
    print("Done")


if __name__ == '__main__':
    main()