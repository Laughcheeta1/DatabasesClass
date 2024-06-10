USE test;

CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
	ProductName NVARCHAR(50) UNIQUE
);

CREATE TABLE Sales (
	Sale INT PRIMARY KEY,
	SaleDate DATE DEFAULT GETDATE(),
	ProductID INT,
	Quantity INT,
	CONSTRAINT FK_SalesProduct FOREIGN KEY (ProductID)
		REFERENCES Products(ProductID),
	CONSTRAINT CHK_Quantity CHECK (Quantity > 0)
);


-- Debe de funcionar
INSERT INTO Products
	(ProductID, ProductName)
VALUES
	(1, 'LapTop')
;


-- Dede de funcionar
INSERT INTO Sales
	(Sale, ProductID, Quantity)
VALUES
	(1, 1, 5)
;


-- Debe de fallar por check
INSERT INTO Sales
	(Sale, ProductID, Quantity)
VALUES
	(2, 1, -3)
;


-- Las contraints no se pueden modificar, tienen que eliminarse y volver a meterse
ALTER TABLE 