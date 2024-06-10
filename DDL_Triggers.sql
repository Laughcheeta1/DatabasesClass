USE AdventureWorks2022;

CREATE OR ALTER TRIGGER dl_db_create
ON DATABASE
FOR 
	CREATE_TABLE
AS
	PRINT 'CREATE NEW TABLE'
GO

CREATE TABLE NewTable (Column1 INT);

DROP TRIGGER dl_db_create ON DATABASE;
GO

DROP TABLE NewTable;


CREATE OR ALTER TRIGGER ddl_db_create
ON DATABASE
FOR 
	CREATE_TABLE
AS
	PRINT 'CREATE NEW TABLE'

	DECLARE @data XML;
	SET @data = EVENTDATA();
	PRINT CONVERT(nvarchar(max), @data);
GO

CREATE TABLE NewTable (Column1 INT);


DROP TABLE NewTable;
DROP TRIGGER ddl_db_create ON DATABASE;


CREATE TABLE dbo.logs2(
	LogId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	PostTime DATETIME NOT NULL,
	DatabaseUser SYSNAME NOT NULL,
	Event_Log SYSNAME NOT NULL,
	Schema_Log SYSNAME NOT NULL,
	Object_Log SYSNAME NOT NULL,
	TSQL_Log NVARCHAR(MAX) NOT NULL,
	XmlEvent XML NOT NULL
);


CREATE OR ALTER TRIGGER ddl_trig_database
ON DATABASE
FOR DDL_DATABASE_LEVEL_EVENTS
AS
	DECLARE @data XML;
	DECLARE @schema SYSNAME;
	DECLARE @object SYSNAME;
	DECLARE @eventType SYSNAME;
	DECLARE @user SYSNAME;

	SET @data = EVENTDATA();

	PRINT CONVERT(NVARCHAR(MAX), @data);

	SET @eventType = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'SYSNAME');
	SET @schema = @data.value('(/EVENT_INSTANCE/SchemaName)[1]', 'SYSNAME');
	SET @object = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'SYSNAME');
	SET @user = @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'SYSNAME');

	INSERT INTO dbo.logs2
	VALUES (
		GETDATE(),
		CONVERT(SYSNAME, @user),
		CONVERT(SYSNAME, @eventType),
		CONVERT(SYSNAME, @schema),
		CONVERT(SYSNAME, @object),
		@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
		@data
	)
	;
;



CREATE OR ALTER TRIGGER ddl_trig_server_database
ON ALL SERVER
FOR	CREATE_DATABASE
AS
	DECLARE @data XML;
	DECLARE @db SYSNAME;
	DECLARE @eventType SYSNAME;
	DECLARE @loginName SYSNAME;

	SET @data = EVENTDATA();
	SET @db = @data.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'SYSNAME');
	SET @loginName = @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'SYSNAME');
	
	PRINT 'New Database Created: ' + @db + ' by ' + @loginName;
go


CREATE DATABASE exampleDB;

DROP DATABASE exampleDB;

DROP TRIGGER ddl_trig_server_database ON ALL SERVER;



CREATE OR ALTER TRIGGER ddl_trig_server_dropdatabase
ON ALL SERVER
FOR	DROP_DATABASE
AS
	PRINT 'DROP DATABASE Issued';
	RAISERROR ('Cannot delete databases from this server', 16, 1);
	ROLLBACK;
GO