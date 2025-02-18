IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'tblAllMonthsRecords'))  
BEGIN   
    
create Table tblAllMonthsRecords (RowNo int, month_start_date Datetime, month_end_date datetime)


create Table TempMonthsRecords ( month_start_date Datetime, month_end_date datetime)



insert into TempMonthsRecords values('1900-01-01 00:00:00.000','1912-12-31 00:00:00.000')
insert into TempMonthsRecords values('1980-01-01 00:00:00.000','1990-12-31 00:00:00.000')
insert into TempMonthsRecords values('1991-01-01 00:00:00.000','2000-12-31 00:00:00.000') 

insert into TempMonthsRecords values('2001-01-01 00:00:00.000','2001-12-31 00:00:00.000')
insert into TempMonthsRecords values('2002-01-01 00:00:00.000','2002-12-31 00:00:00.000')
insert into TempMonthsRecords values('2003-01-01 00:00:00.000','2003-12-31 00:00:00.000')
insert into TempMonthsRecords values('2004-01-01 00:00:00.000','2004-12-31 00:00:00.000')
insert into TempMonthsRecords values('2005-01-01 00:00:00.000','2005-12-31 00:00:00.000')
insert into TempMonthsRecords values('2006-01-01 00:00:00.000','2006-12-31 00:00:00.000')
insert into TempMonthsRecords values('2007-01-01 00:00:00.000','2007-12-31 00:00:00.000')
insert into TempMonthsRecords values('2008-01-01 00:00:00.000','2008-12-31 00:00:00.000')
insert into TempMonthsRecords values('2009-01-01 00:00:00.000','2009-12-31 00:00:00.000')
insert into TempMonthsRecords values('2010-01-01 00:00:00.000','2010-12-31 00:00:00.000')
insert into TempMonthsRecords values('2011-01-01 00:00:00.000','2011-12-31 00:00:00.000') 

  
select distinct  year(dateacctopen) as DataYear, DENSE_RANK() OVER (  ORDER BY year(dateacctopen)) as RowNo   into #TempYears 
from  acct 
where year(dateacctopen) is not null and  year(dateacctopen) > 2011
group by year(dateacctopen)
order by year(dateacctopen)

Declare @rno  int = 1, @Year int, @FirstDate datetime, @LastDate datetime 

while (@rno <= (select max( RowNo )  from  #TempYears))
begin

set @Year  =  (select DataYear from #TempYears where RowNo = @rno)

set @FirstDate = (select DATEADD(month,0,DATEADD(year,@Year-1900,0))) /*First*/
set @LastDate = (select DATEADD(day,-1,DATEADD(month,12,DATEADD(year,@Year-1900,0)))) /*Last*/

;with Months as (
select top (datediff(month,@FirstDate,@LastDate)+1) 
    [month_start_date] = dateadd(month
               , datediff(month, 0, @FirstDate) + row_number() over (order by number) -1
               , 0)
    , month_end_date = dateadd(day,-1,dateadd(month
               , datediff(month, 0, @FirstDate) + row_number() over (order by number) 
               ,0))
  from master.dbo.spt_values
  order by [month_start_date]
)
  insert into TempMonthsRecords
select   *   from Months   ;

set @rno = @rno +1

END
 
 insert into tblAllMonthsRecords
select DENSE_RANK() OVER (  ORDER BY month_start_date)  as RowNo ,  *   from TempMonthsRecords   ;


  update tblAllMonthsRecords set month_end_date = dateadd(HOUR, 23, month_end_date)
  update tblAllMonthsRecords set month_end_date =   dateadd(MINUTE, 59, month_end_date)
  update tblAllMonthsRecords set month_end_date =   dateadd(SECOND, 59, month_end_date) 
   update tblAllMonthsRecords set month_end_date =   dateadd(MILLISECOND, 997, month_end_date) 

   drop table TempMonthsRecords
   drop table #TempYears
END


   
   