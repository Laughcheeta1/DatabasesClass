USE AdventureWorks2022;

CREATE TABLE Production.Test_Trigger_Product_Hist (
	ProductId INT NOT NULL,
	ModifiedDate DATETIME NOT NULL
	)
;


CREATE OR ALTER TRIGGER Production.TR_UPD_Product ON Production.Product
FOR UPDATE
AS
BEGIN
	INSERT INTO Production.Test_Trigger_Product_Hist
	SELECT ProductID, GETDATE()
	FROM inserted
END
;

SELECT * FROM Production.Product WHERE color IS NULL;

UPDATE Production.Product
SET color = 'without color'
WHERE color IS NULL
;

SELECT * FROM Production.Test_Trigger_Product_Hist;

UPDATE Production.Product
SET color = NULL
WHERE color = 'without color'
;



