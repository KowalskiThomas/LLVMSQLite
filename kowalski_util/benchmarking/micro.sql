-- Simple select
SELECT * FROM CUSTOMER;

-- Aggregation
SELECT SUM(C_CUSTKEY * C_NATIONKEY) FROM CUSTOMER;

-- Restricted SELECT on indexed column
SELECT * FROM ORDERS WHERE O_ORDERKEY < 30000;

-- Restricted SELECT on non-indexed column
SELECT * FROM ORDERS WHERE O_TOTALPRICE < 231964.11;

-- Join on indexed column
SELECT * FROM LINEITEM JOIN ORDERS ON LINEITEM.L_ORDERKEY = ORDERS.O_ORDERKEY;

-- Join on non-indexed column
-- SELECT * FROM 

-- Nested query
SELECT * FROM (
	SELECT * FROM LINEITEM
	WHERE L_QUANTITY < 15
) WHERE L_SHIPMODE = 'MAIL';
