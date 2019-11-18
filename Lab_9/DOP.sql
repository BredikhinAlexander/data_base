--кто, когда создавл PRIMARY KEY
USE Shipping

GO

DROP TABLE IF EXISTS user_PK
GO

CREATE TABLE user_PK
(
	name_user		varchar(200),
	name_PK	    	varchar(200),
	[date]			datetime
);

DROP TRIGGER  IF EXISTS Trigger_PK
ON DATABASE;
GO


CREATE TRIGGER [Trigger_PK]	
ON DATABASE
FOR ALTER_TABLE
AS

--INSERT INTO user_PK VALUES (ORIGINAL_LOGIN(), 
--(SELECT EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/Drop/Constraints/Name)[1]','nvarchar(max)')), SYSDATETIME())

INSERT INTO user_PK VALUES (ORIGINAL_LOGIN(), 
(SELECT EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/Create/Constraints/Name)[1]','nvarchar(max)')), SYSDATETIME())

GO 


--DROP TRIGGER IF EXISTS Trig_table1
--ON DATABASE;
--GO
--CREATE TRIGGER Trig_table1
--ON DATABASE
--FOR ALTER_TABLE
--AS
--SELECT EVENTDATA()
--GO




DROP TRIGGER  IF EXISTS Trigger_PK_CREATE
ON DATABASE;
GO

CREATE TRIGGER [Trigger_PK_CREATE]	
ON DATABASE
FOR CREATE_TABLE
AS


INSERT INTO user_PK VALUES (ORIGINAL_LOGIN(), 
(SELECT EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/Create/Constraints/Name)[1]','nvarchar(max)')), SYSDATETIME())

GO 

SELECT * FROM user_PK