-- Join on non-indexed column
SELECT S_ID, S_Price, S_Client, S_Date, SI_I FROM Sales JOIN SaleItem ON Sales.S_ID = SaleItem.SI_S;
