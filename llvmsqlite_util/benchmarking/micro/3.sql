--- Restricted SELECT on non-indexed column
-- This allows to see whether relation traversal
-- is more / less efficient on the JIT.
SELECT * FROM Items WHERE I_Price < 231964.11;
