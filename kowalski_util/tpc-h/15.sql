create view revenue {stream_id} (supplier_no, total_revenue) as
select l_suppkey,
    sum(l_extendedprice * (1 - l_discount))
from lineitem
where l_shipdate >= date('{date}'
    and l_shipdate < date('{date}', '+3month')
group by l_suppkey;
select s_suppkey,
    s_name,
    s_address,
    s_phone,
    total_revenue
from supplier,
    revenue {stream_id}
where s_suppkey = supplier_no
    and total_revenue = (
        select max(total_revenue)
        from revenue {stream_id}
    )
order by s_suppkey;
drop view revenue {stream_id};