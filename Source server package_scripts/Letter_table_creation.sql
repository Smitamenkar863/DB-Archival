IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'letter'))  
BEGIN
CREATE TABLE [dbo].[letter](
	[runno] [smallint] NULL,
	[acctno] [char](12) NOT NULL,
	[dateacctlttr] [datetime] NOT NULL,
	[datedue] [datetime] NULL,
	[lettercode] [varchar](10) NOT NULL,
	[addtovalue] [money] NULL,
	[ExcelGen] [bit] NULL
) ON [PRIMARY]
END