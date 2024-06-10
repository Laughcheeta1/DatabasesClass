USE AdventureWorks2022;

SELECT
* 
FROM
Purchasing.ShipMethod


-- TRY CATCH
BEGIN TRY
	INSERT INTO Purchasing.ShipMethod
		(Name, ShipBase, ShipRate, rowguid, ModifiedDate)
	VALUES
		('Overseas Express', NULL, 3.20, NEWID(), GETDATE())

	PRINT 'Succesfull'
END TRY
BEGIN CATCH
	PRINT 'Unsuccesfull'

END CATCH
;


-- 