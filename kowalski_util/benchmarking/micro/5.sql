--- Join on indexed column
-- This allows to see if indexed joins are more / less 
-- efficient in the JIT.
SELECT * FROM Sales JOIN Clients ON Sales.S_Client = Clients.C_ID;
