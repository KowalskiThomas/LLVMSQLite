select s_suppkey,
    s_name,
    s_address,
    s_phone,
    total_revenue
from supplier,
    (
        select l_suppkey as supplier_no,
            sum(l_extendedprice * (1 - l_discount)) as total_revenue
        from lineitem
        where l_shipdate >= date('{date}')
            and l_shipdate < date('{date}', '+3 month')
        group by l_suppkey
    )
where s_suppkey = supplier_no
    and total_revenue = (
        select max(total_revenue)
        from (
            select l_suppkey as supplier_no,
                sum(l_extendedprice * (1 - l_discount)) as total_revenue
            from lineitem
            where l_shipdate >= date('1997-04-03')
                and l_shipdate < date('1997-04-03', '+3 month')
            group by l_suppkey
        )
    )
order by s_suppkey;
