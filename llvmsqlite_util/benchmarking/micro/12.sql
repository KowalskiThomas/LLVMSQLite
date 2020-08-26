--- Nested query with two ORDER BY's and HAVING
-- More complex query with a nested subquery. 
SELECT AVG(SI_I) FROM (
	SELECT SI_I, SI_S 
	FROM SaleItem 
	WHERE SI_S > 1000 
	ORDER BY SI_S + SI_I * 2
) SaleItem 
GROUP BY SI_S HAVING SUM(SI_I) + SI_S > 5000000 
ORDER BY SI_S;
