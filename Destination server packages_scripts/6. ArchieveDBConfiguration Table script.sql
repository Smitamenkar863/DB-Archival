IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'ArchieveDBConfiguration'))  
BEGIN
Create Table ArchieveDBConfiguration (
id int,
ArchieveFromDate Datetime,
Active int,
Phase int
)
 
 

INSERT INTO ArchieveDBConfiguration VALUES (1, DATEADD(ms, -3,  DATEADD(MONTH, -1, DATEADD(dd, 0, DATEDIFF(dd, 0, getdate())))), 1,1);
insert into ArchieveDBConfiguration values (1, DATEADD(ms, -3,  DATEADD(year, -5, DATEADD(dd, 0, DATEDIFF(dd, 0, getdate())))), 1,2);
-- update ArchieveDBConfiguration set ArchieveFromDate = dateadd(HOUR, 23, ArchieveFromDate)
  -- update ArchieveDBConfiguration set ArchieveFromDate =   dateadd(MINUTE, 59, ArchieveFromDate)
  -- update ArchieveDBConfiguration set ArchieveFromDate =   dateadd(SECOND, 59, ArchieveFromDate)
END