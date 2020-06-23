types = {
    "1": {
        "delta": {
            "type": "int",
            "min": 60,
            "max": 120
        }
    }, 
    "2": {
        "size": {
            "type": "int",
            "min": 1,
            "max": 50
        },
        "type": {
            "type": "type"
        },
        "region": {
            "type": "region"
        }
    },
    "3": {
        "segment": {
            "type": "segment"
        },
        "date": {
            "type": "date",
            "min": "1995-03-01",
            "max": "1995-03-31"
        }
    },
    "4": {
        "date": {
            "type": "date",
            "min": "1993-01-01",
            "max": "1997-10-01"
        }
    },
    "5": {
        "region": {
            "type": "region"
        },
        "date": {
            "type": "date",
            "min": "1993-01-01",
            "max": "1997-01-01"
        }
    },
    "6": {
        "date": {
            "type": "date",
            "min": "1993-01-01",
            "max": "1997-01-01"
        },
        "discount": {
            "type": "float",
            "min": 0.02,
            "max": 0.09
        },
        "quantity": {
            "type": "int",
            "min": 24,
            "max": 25
        }
    },
    "7": {
        "nation1": {
            "type": "nation"
        },
        "nation2": {
            "type": "nation"
        }
    },
    "8": {
        "nation": {
            "type": "nation"
        },
        "region": {
            "type": "region"
        },
        "type": {
            "type": "type"
        }
    },
    "9": {
        "color": {
            "type": "p_name"
        }
    },
    "10": {
        "date": {
            "type": "date",
            "min": "1993-02-01",
            "max": "1995-01-01"
        }
    },
    "11": {
        "nation": {
            "type": "nation"
        },
        "fraction": {
            "type": "float",
            "value": 0.0001
        }
    },
    "12": {
        "shipmode1": {
            "type": "shipmode"
        },
        "shipmode2": {
            "type": "shipmode"
        },
        "date": {
            "type": "date",
            "min": "1993-01-01",
            "max": "1997-01-01"
        }
    },
    "13": {
        "word1": {
            "type": "union",
            "items": ["special", "pending", "unusual", "express"]
        }, 
        "word2": {
            "type": "union",
            "items": ["packages", "requests", "accounts", "deposits"]
        }
    },
    "14": {
        "date": {
            "type": "date",
            "min": "1993-01-01",
            "max": "1997-01-01"
        }
    },
    "15": {
        "date": {
            "type": "date",
            "min": "1993-01-01",
            "max": "1997-10-01"
        },
        "stream_id": {
            "type": "constant",
            "value": 15
        }
    },
    "16": {
        "brand": {
            "type": "brand"
        },
        "type": {
            "type": "type",
            "syllables": 2
        },
        "size1": {
            "type": "int",
            "min": 1,
            "max": 50
        },
        "size2": {
            "type": "int",
            "min": 1,
            "max": 50
        },
        "size3": {
            "type": "int",
            "min": 1,
            "max": 50
        },
        "size4": {
            "type": "int",
            "min": 1,
            "max": 50
        },
        "size5": {
            "type": "int",
            "min": 1,
            "max": 50
        },
        "size6": {
            "type": "int",
            "min": 1,
            "max": 50
        },
        "size7": {
            "type": "int",
            "min": 1,
            "max": 50
        },
        "size8": {
            "type": "int",
            "min": 1,
            "max": 50
        },
    },
    "17": {
        "brand": {
            "type": "brand"
        },
        "container": {
            "type": "container"
        }
    },
    "18": {
        "quantity": {
            "type": "int",
            "min": 312,
            "max": 315
        }
    },
    "19": {
        "quantity1": {
            "type": "int",
            "min": 1,
            "max": 10
        },
        "quantity2": {
            "type": "int",
            "min": 10,
            "max": 20
        },
        "quantity3": {
            "type": "int",
            "min": 20,
            "max": 30
        },
        "brand1": {
            "type": "brand"
        },
        "brand2": {
            "type": "brand"
        },
        "brand3": {
            "type": "brand"
        }
    },
    "20": {
        "color": {
            "type": "p_name"
        },
        "date": {
            "type": "date",
            "min": "1993-01-01",
            "max": "1997-01-01"
        },
        "nation": {
            "type": "nation"
        }
    },
    "21": {
        "nation": {
            "type": "nation"
        }
    }
}

segments = ["AUTOMOBILE", "BUILDING", "FURNITURE", "MACHINERY", "HOUSEHOLD"]
brands = []
types1 = ["STANDARD", "SMALL", "MEDIUM", "LARGE", "ECONOMY", "PROMO"]
types2 = ["ANODIZED", "BURNISHED", "PLATED", "POLISHED", "BRUSHED"]
types3 = ["TIN", "NICKEL", "BRASS", "STEEL", "COPPER"]
regions = ["AFRICA," "AMERICA", "ASIA", "EUROPE", "MIDDLE EAST"]
nations = ['ALGERIA', 'ARGENTINA', 'BRAZIL', 'CANADA', 'EGYPT', 'ETHIOPIA', 'FRANCE', 'GERMANY', 'INDIA', 'INDONESIA', 'IRAN', 'IRAQ', 'JAPAN', 'JORDAN', 'KENYA', 'MOROCCO', 'MOZAMBIQUE', 'PERU', 'CHINA', 'ROMANIA', 'SAUDI ARABIA', 'VIETNAM', 'RUSSIA', 'UNITED KINGDOM', 'UNITED STATES']
p_name_words = ["almond", "antique", "aquamarine", "azure", "beige", "bisque", "black", "blanched", "blue",
"blush", "brown", "burlywood", "burnished", "chartreuse", "chiffon", "chocolate", "coral",
"cornflower", "cornsilk", "cream", "cyan", "dark", "deep", "dim", "dodger", "drab", "firebrick",
"floral", "forest", "frosted", "gainsboro", "ghost", "goldenrod", "green", "grey", "honeydew",
"hot", "indian", "ivory", "khaki", "lace", "lavender", "lawn", "lemon", "light", "lime", "linen",
"magenta", "maroon", "medium", "metallic", "midnight", "mint", "misty", "moccasin", "navajo",
"navy", "olive", "orange", "orchid", "pale", "papaya", "peach", "peru", "pink", "plum", "powder",
"puff", "purple", "red", "rose", "rosy", "royal", "saddle", "salmon", "sandy", "seashell", "sienna",
"sky", "slate", "smoke", "snow", "spring", "steel", "tan", "thistle", "tomato", "turquoise", "violet",
"wheat", "white", "yellow"]
ship_modes = ["REG", "AIR", "AIR", "RAIL", "SHIP", "TRUCK", "MAIL", "FOB"]