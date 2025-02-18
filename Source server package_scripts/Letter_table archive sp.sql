Go 
IF OBJECT_ID('SP_Archive_Letter', 'P') IS NOT NULL
DROP PROCEDURE SP_Archive_Letter
 GO
CREATE   Procedure SP_Archive_Letter 
AS BEGIN IF (EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Letter_new'))  

		BEGIN   
 			 
			set nocount on;
			declare @trancount int;
			set @trancount = @@trancount;

			Declare @ArchieveFromDate DateTime   
			select @ArchieveFromDate = ArchieveFromDate from ArchieveDBConfiguration where phase = 2 and active = 1

			declare @CreatedDate date, @StartDate datetime, @EndDate datetime 
			Declare @MonthCount int,  @RowNo int  , @MinDate Datetime
           declare @counter int = 0;
			 select @MinDate = (select min(dateacctopen) from acct_five_Current)
               
			  select @RowNo = Rowno from tblAllMonthsRecords a    where month_start_date <= @ArchieveFromDate and month_end_date >=
			  @ArchieveFromDate
			  select @MonthCount = max(rowno) from tblAllMonthsRecords where month_start_Date >= @ArchieveFromDate and rowno >= @RowNo
			 
			 select @RowNo
			 select  @MonthCount
			  
			WHILE (@RowNo <= @MonthCount ) --@MonthCount
 
				BEGIN
  					BEGIN TRY   
					  if @trancount = 0
							BEGIN TRAN  ; 

								select @StartDate = Month_start_Date,@EndDate = Month_End_Date from tblAllMonthsRecords where rowno = @RowNo
								 
								if(@counter = 0)
								BEGIN
								set @StartDate = @ArchieveFromDate
								set @counter=1;
								END
								
								Insert Into  [dbo].Letter_new(runno,acctno,dateacctlttr,datedue,lettercode,addtovalue,ExcelGen)
								select a.runno,a.acctno,a.dateacctlttr,a.datedue,a.lettercode,a.addtovalue,a.ExcelGen from [dbo].Letter a with(nolock) 
								inner join acct_Five_Current b on a.acctno = b.acctno  where   b.dateacctopen >= @StartDate and   b.dateacctopen <= @EndDate
 
								INSERT INTO tblDBArchivestatus  (TableName, TableStatus, ArchDatetime) VALUES ('[dbo].Letter',@StartDate , GETDATE())
								  
								-- Delete a From [dbo].Letter  a with(nolock) inner join acct_Five_Current b on a.acctno = b.acctno
								-- where   b.dateacctopen >= @StartDate and   b.dateacctopen <= @EndDate
								
								-- INSERT INTO tblDBArchivestatus  (TableName, TableStatus, ArchDatetime) VALUES ('[dbo].Letter', --@StartDate, GETDATE())
							   set @RowNo = @RowNo+1;
						 if @trancount = 0
							COMMIT TRAN  
					END TRY 
					BEGIN CATCH  
						BEGIN   
						  declare @error int, @message varchar(4000), @xstate int;
							select @error = ERROR_NUMBER(), @message = ERROR_MESSAGE(), @xstate = XACT_STATE();
							if @xstate = -1
								rollback;
							if @xstate = 1 and @trancount = 0
								rollback
							INSERT INTO tblDBArchivestatus  (TableName, TableStatus, ArchDatetime) VALUES ('[dbo].Letter', @message, GETDATE())
					 END;  
					END CATCH 
				END  
		END
	END


