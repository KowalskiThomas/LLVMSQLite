select cntrycode,
    count(*) as numcust,
    sum(c_acctbal) as totacctbal
from (
        select substring(
                c_phone
                from 1 for 2
            ) as cntrycode,
            c_acctbal
        from customer
        where substring(
                c_phone
                from 1 for 2
            ) in ('{i1}', '{i2}', '{i3}', '{i4}', '{i5}', '{i6}', '{i7}')
            and c_acctbal > (
                select avg(c_acctbal)
                from customer
                where c_acctbal > 0.00
                    and substring (
                        c_phone
                        from 1 for 2
                    ) in ('{i1}', '{i2}', '{i3}', '{i4}', '{i5}', '{i6}', '{i7}')
            )
            and not exists (
                select *
                from orders
                where o_custkey = c_custkey
            )
    ) as custsale
group by cntrycode
order by cntrycode;