--- Aggregation
-- This allows to check whether aggregating tuples
-- is more / less efficient in the JIT.
SELECT SUM(I_ID * I_Category + I_Price) FROM Items;
