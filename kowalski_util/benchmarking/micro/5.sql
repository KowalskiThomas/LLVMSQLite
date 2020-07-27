-- Join on indexed column
SELECT * FROM Sales JOIN Clients ON Sales.S_Client = Clients.C_ID;
