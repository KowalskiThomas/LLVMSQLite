--- Aggregation
-- This allows to check whether aggregating tuples
-- is more / less efficient in the JIT.

SELECT I_ID * I_Category + I_Price + (I_ID * I_Price) - (I_Category * (I_ID - I_Price * I_ID)) FROM Items;

