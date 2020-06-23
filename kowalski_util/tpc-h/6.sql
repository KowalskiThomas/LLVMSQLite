select sum(l_extendedprice * l_discount) as revenue
from lineitem
where l_shipdate >= date('{date}')
    and l_shipdate < date('{date}', '+1year')
    and l_discount between {discount} - 0.01 and {discount} + 0.01
    and l_quantity < {quantity};