--- Aggregation
-- This allows to check whether aggregating tuples
-- is more / less efficient in the JIT.
SELECT SUM(
        I_ID * (I_Category - 23.0) * (I_ID / 4.0) + I_Price + (I_ID * I_Price - 4)
    )
FROM Items;