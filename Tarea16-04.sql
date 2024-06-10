USE AdventureWorks2022;

-- Literalmente el problema aparentemente es la linea en la que estoy diciendo que si ambos son nulos, entonces que sea 1
-- ESTA TAMPOCO FUNCIONA Y NI IDEA
DECLARE @colorList VARCHAR(500);
DECLARE @dynamicSql VARCHAR(MAX);

SELECT
	@colorList = STRING_AGG(QUOTENAME(COALESCE(Color, 'withoutColor')), ',')
FROM
(
	SELECT
		DISTINCT Color
	FROM
		Production.Product
) AS A
;

PRINT @colorList;

SET @dynamicSql = '
	SELECT
		*
	FROM (
		SELECT
			CategoryColor.Name,
			CategoryColor.Color AS Color,
			SUM(CategoryColor.isThisColor) AS Qty
		FROM
			(
				SELECT
					pc.Name,
					COALESCE(c.Color, ''withoutColor'') AS ''Color'',
					CASE
						WHEN c.Color IS NULL AND p.Color IS NULL then 1
						WHEN c.Color = p.Color THEN 1
						ELSE 0
					END AS ''IsThisColor''
				FROM
					Production.Product AS P
					INNER JOIN Production.ProductSubcategory AS ps
						ON p.ProductSubcategoryID = ps.ProductSubcategoryID
					INNER JOIN Production.ProductCategory AS pc
						ON ps.ProductCategoryID = pc.ProductCategoryID
					CROSS JOIN
						(
							SELECT 
								DISTINCT color AS ''Color''
							FROM
								Production.Product
						) AS c
			) AS CategoryColor
		GROUP BY
			CategoryColor.Name,
			CategoryColor.Color
		) AS SourceTable
	PIVOT (
		SUM(Qty)
		FOR Color IN ([withoutColor],[Black],[Blue],[Grey],[Multi],[Red],[Silver],[Silver/Black],[White],[Yellow])
	) AS pvt
';

EXEC (@dynamicSql);