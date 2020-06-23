select p_brand,
    p_type,
    p_size,
    count(distinct ps_suppkey) as supplier_cnt
from partsupp,
    part
where p_partkey = ps_partkey
    and p_brand <> '{brand}'
    and p_type not like '{type}%'
    and p_size in (
        {size1},
        {size2},
        {size3},
        {size4},
        {size5},
        {size6},
        {size7},
        {size8}
    )
    and ps_suppkey not in (
        select s_suppkey
        from supplier
        where s_comment like '%Customer%Complaints%'
    )
group by p_brand,
    p_type,
    p_size
order by supplier_cnt desc,
    p_brand,
    p_type,
    p_size;