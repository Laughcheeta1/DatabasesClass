USE AdventureWorks2022;

DECLARE employee_cursor CURSOR
	FOR SELECT * FROM HumanResources.Employee

OPEN employee_cursor

FETCH NEXT FROM employee_cursor

CLOSE employee_cursor

DEALLOCATE employee_cursor


--- Procedure con cursor
CREATE PROCEDURE ListEmployeeNames AS
BEGIN
	DECLARE @FirstName NVARCHAR(50);
	DECLARE @LastName NVARCHAR(50);

	DECLARE employee_cursor CURSOR FOR (
			SELECT
				FirstName,
				LastName
			FROM
				Person.Person
			WHERE
				BusinessEntityID IN (
						SELECT
							BusinessEntityID
						FROM
							HumanResources.Employee
					)
		)
	;

	OPEN employee_cursor;

	-- Para que @@FETCH_STATUS sea diferente de 0, toca primero hacer un FETCH
	FETCH NEXT FROM employee_cursor INTO @FirstName, @LastName; 

	-- Como se supone que uno solo trabaja con un cursor a la vez, este FETCH_STATUS devuelve el 
	-- Si tenemos mas de un cursor a la vez, el @@FETCH_STATUS va a devolver el estado del ultimo fetch
	-- ejecutado, no importa de que cursor sea, es el ultimo fetch global hecho
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Employee Name: ' + @FirstName + ' ' + @LastName;
		FETCH NEXT FROM employee_cursor INTO @FirstName, @LastName;
	END
	;

	CLOSE employee_cursor; -- Cerrar el cursor
	DEALLOCATE employee_cursor;

END
;


EXEC ListEmployeeNames;


-- LOCAL CURSORS
-- This means that is local to the code being executed, like variables. 
-- Cant be used outside the execution of the single code
DECLARE employee_cursor CURSOR LOCAL
	FOR SELECT * FROM HumanResources.Employee
OPEN employee_cursor
FETCH NEXT FROM employee_cursor
CLOSE employee_cursor
DEALLOCATE employee_cursor