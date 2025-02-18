 IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'acct_five_Current'))  
BEGIN
Declare @ArchieveFromDate Datetime 
select @ArchieveFromDate = ArchieveFromDate from ArchieveDBConfiguration where phase=2 and active=1

Select  * Into acct_five_Current from acct where dateacctopen >= @ArchieveFromDate 
Alter Table acct_five_Current Add constraint pkacctcurr Primary Key(Acctno)

		 

		  

-- Find an existing index named IX_ProductVendor_VendorID and delete it if found.
IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = N'IX_AcctFiveCurrent_dateacctopen')
    DROP INDEX IX_AcctFiveCurrent_dateacctopen ON dbo.acct_five_Current

-- Create a nonclustered index called IX_ProductVendor_VendorID
-- on the Purchasing.ProductVendor table using the BusinessEntityID column.
CREATE NONCLUSTERED INDEX IX_AcctFiveCurrent_dateacctopen
    ON dbo.acct_five_Current (dateacctopen desc) ;

 
  END