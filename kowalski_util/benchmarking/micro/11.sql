--- Query with GROUP BY, ORDER BY and HAVING
-- Example of a more complex query. 
SELECT AVG(SI_I) FROM SaleItem 
GROUP BY SI_S HAVING SUM(SI_I) + SI_S > 5000000 
ORDER BY SI_S;
