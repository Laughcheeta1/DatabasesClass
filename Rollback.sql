USE AdventureWorks2022;


SELECT 
	ProductID, Name, Color
INTO
	TestProduct
FROM
	Production.Product

SELECT * FROM TestProduct

SET IMPLICIT_TRANSACTIONS OFF;

UPDATE TestProduct
SET Color = NULL
WHERE ProductId = 1;
ROLLBACK

SET IMPLICIT_TRANSACTIONS ON;

UPDATE TestProduct
SET Color = NULL
WHERE ProductId = 1;
ROLLBACK

SELECT * FROM TestProduct;

SET IMPLICIT_TRANSACTIONS OFF;


BEGIN TRAN Demotran1;
INSERT INTO TestProduct
VALUES (2000000, 'NewTranc1', 'red')
;

SELECT *
FROM TestProduct
ORDER BY ProductId DESC;

ROLLBACK TRAN Demotran1;

SELECT *
FROM TestProduct
ORDER BY ProductId DESC;




BEGIN TRAN Demotran2;
INSERT INTO TestProduct
VALUES (300000000, 'NewTranc2', 'Red')
COMMIT TRAN Demotran2;

SELECT *
FROM TestProduct
ORDER BY ProductId DESC;

ROLLBACK TRAN Demotran2;

