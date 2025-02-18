IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'tblDBArchivestatus'))  
BEGIN 
create Table tblDBArchivestatus (TableName nvarchar(100), TableStatus nvarchar(max), ArchDatetime datetime)
END