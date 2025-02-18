IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'TblDBArchiveTablesInfo_Phase1'))  
BEGIN
 -- One Time Activity

 Create Table TblDBArchiveTablesInfo_Phase1 (Tblname varchar(50), PreviouRecordsCount int, PreviousTableSizeinMB NUMERIC(36, 2), 
 PreviuosArchiveDate datetime, LatestRecordsCount int, LatestTableSizeinMB NUMERIC(36, 2), LatestArchiveDate Datetime)
 END 
 IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'TblDBArchiveTablesHistory_Phase1'))  
BEGIN
Create Table TblDBArchiveTablesHistory_Phase1 (Tblname varchar(50), PreviouRecordsCount int, PreviousTableSizeinMB NUMERIC(36, 2), 
 PreviuosArchiveDate datetime, LatestRecordsCount int, LatestTableSizeinMB NUMERIC(36, 2), LatestArchiveDate Datetime)
 END


 if( (select count(*) from TblDBArchiveTablesInfo_Phase1)=0)
 BEGIN

 insert into TblDBArchiveTablesInfo_Phase1 (Tblname,LatestRecordsCount,LatestTableSizeinMB,LatestArchiveDate)
SELECT 
    s.name+'.'+ t.name AS TableName, 
		    p.rows,
 	    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB,
		GETDATE()
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.object_id = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
      t.is_ms_shipped = 0
	      AND i.object_id > 255
		  and t.name not in ('TblDBArchiveTablesInfo','TblDBArchiveTablesHistory','TblDBArchiveTablesInfo_Phase1','TblDBArchiveTablesHistory_Phase1')
		  and t.name in('stockinfoaudit','elmah_error','letter','event','bsapilog')
 GROUP BY 
     t.name, s.name, p.rows
	 ORDER BY 
 TotalSpaceMB DESC, t.name
 END