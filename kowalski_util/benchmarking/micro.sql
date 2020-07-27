-- Simple select
SELECT * FROM Items;

-- Restricted SELECT on indexed column
SELECT * FROM Items WHERE I_ID < 30000;

-- Restricted SELECT on non-indexed column
SELECT * FROM Items WHERE I_Price < 231964.11;

-- Aggregation
SELECT SUM(I_ID * I_Category + I_Price) FROM Items;

-- Join on indexed column
SELECT * FROM Sales JOIN Clients ON Sales.S_Client = Clients.C_ID;

-- Join on non-indexed column
SELECT S_ID, S_Price, S_Client, S_Date, SI_I FROM Sales JOIN SaleItem ON Sales.S_ID = SaleItem.SI_S;

-- Nested query
SELECT S_ID, S_Price, S_Client, S_Date, I_ID, I_Name, I_Price, I_Category 
FROM Items JOIN 
	(
		SELECT S_ID, S_Price, S_Client, S_Date, SI_I 
		FROM Sales JOIN SaleItem ON Sales.S_ID = SaleItem.SI_S
	) As Temp 
ON Temp.SI_I = Items.I_ID;