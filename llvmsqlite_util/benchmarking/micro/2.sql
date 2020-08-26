--- Restricted SELECT on indexed column
-- This allows to check if tree traversal
-- is more / less efficient on the JIT.
SELECT * FROM Items WHERE I_ID < 30000;
