--- Join on non-indexed column
-- This allows to check whether non-indexed joins are more / less
-- efficient in the JIT.
SELECT S_ID, S_Price, S_Client, S_Date, SI_I 
FROM Sales JOIN SaleItem ON Sales.S_ID = SaleItem.SI_S;
