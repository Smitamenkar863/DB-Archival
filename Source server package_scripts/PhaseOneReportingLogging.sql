 insert into TblDBArchiveTablesHistory_Phase1
  select * from TblDBArchiveTablesInfo_Phase1 

  update TblDBArchiveTablesInfo_Phase1 set   PreviouRecordsCount = LatestRecordsCount,  PreviousTableSizeinMB = LatestTableSizeinMB, PreviuosArchiveDate = LatestArchiveDate
  where Tblname = Tblname


   update TblDBArchiveTablesInfo_Phase1 set   LatestRecordsCount = 0, LatestTableSizeinMB=0 , LatestArchiveDate = null
  where Tblname = Tblname
   
  SELECT 
    s.name+'.'+ t.name AS TableName, 
		    p.rows as RowsCount,
 	    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB,
		GETDATE() as ArchiveDate
		into #TempDBArchiveTablesInfo_Phase1
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
  
   update  a  set   LatestRecordsCount = RowsCount, LatestTableSizeinMB=TotalSpaceMB , LatestArchiveDate = ArchiveDate
   from TblDBArchiveTablesInfo_Phase1 a inner join #TempDBArchiveTablesInfo_Phase1 b on 
 a.Tblname = b.TableName


 drop table #TempDBArchiveTablesInfo_Phase1

