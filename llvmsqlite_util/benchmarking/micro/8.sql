--- Two nested queries
-- More complex nested query benchmark to see the influence of the number of 
-- nested queries. 
SELECT S_ID, S_Price, S_Client, S_Date, I_ID, I_Name, I_Price, I_Category 
FROM Items JOIN 
	(
		SELECT S_ID, S_Price, S_Client, S_Date, SI_I 
		FROM 
			(
				SELECT * FROM Sales WHERE S_ID < (SELECT MIN(S_ID) + 5000 FROM Sales)
			) AS Sales
		JOIN SaleItem ON Sales.S_ID = SaleItem.SI_S
	) As Temp 
ON Temp.SI_I = Items.I_ID;