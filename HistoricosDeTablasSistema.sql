CREATE DATABASE test;

USE test;

CREATE TABLE ProductInventory (
	ProductID INT PRIMARY KEY,
	ProductName NVARCHAR(100),
	Quantity INT,
	Price DECIMAL(10, 2),
	ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START,
	ValidTo DATETIME2 GENERATED ALWAYS AS ROW END,
	PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ProductInventoryHistory))
;


INSERT INTO ProductInventory
	(ProductID, ProductName, Quantity, Price)
VALUES
	(1, 'LapTop', 50, 4200000)
;

SELECT * FROM ProductInventory;

UPDATE ProductInventory
SET 
	Quantity = 45, 
	Price = 2150000.00
WHERE
	ProductID = 1
;

SELECT * FROM ProductInventory;
SELECT * FROM ProductInventoryHistory;

SELECT 
	* 
FROM 
	ProductInventory
FOR 
	SYSTEM_TIME	ALL
WHERE
	ProductID = 1
;



IF OBJECT_ID('ProductInventory', 'U') IS NOT NULL
	BEGIN
		ALTER TABLE ProductInventory SET (SYSTEM_VERSIONING = OFF);
		DROP TABLE ProductInventory;

		IF OBJECT_ID ('ProductInventoryHistory', 'U') IS NOT NULL
			BEGIN
				DROP TABLE ProductInventoryHistory;
			END
	END
;

