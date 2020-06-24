select s_name,
    s_address
from supplier,
    nation
where s_suppkey in (
        select ps_suppkey
        from partsupp
        where ps_partkey in (
                select p_partkey
                from part
                where p_name like '{color}%'
            )
            and ps_availqty > (
                select 0.5 * sum(l_quantity)
                from lineitem
                where l_partkey = ps_partkey
                    and l_suppkey = ps_suppkey
                    and l_shipdate >= date('{date}')
                    and l_shipdate < date('{date}', '+1year')
            )
    )
    and s_nationkey = n_nationkey
    and n_name = '{nation}'
order by s_name;