------------------------------------------
 
IF( (select COUNT(*)

      from sys.all_columns c

      join sys.tables t on t.object_id = c.object_id

      join sys.schemas s on s.schema_id = t.schema_id

      join sys.default_constraints d on c.default_object_id = d.object_id

    where t.name = 'ELMAH_Error'

      and c.name = 'ErrorId'

      and s.name = 'DBO') >0)

	  BEGIN 

ALTER TABLE ELMAH_Error

DROP CONSTRAINT DF_ELMAH_Error_ErrorId;

end

Go

IF( ( SELECT COUNT(*)

FROM   sys.key_constraints

WHERE  [type] = 'PK'

       AND [parent_object_id] = Object_id('dbo.Elmah_error'))>0)

	   begin

	   ALTER TABLE ELMAH_Error

		DROP CONSTRAINT PK_ELMAH_Error

end

Go

IF( (select COUNT(*)

      from sys.all_columns c

      join sys.tables t on t.object_id = c.object_id

      join sys.schemas s on s.schema_id = t.schema_id

      join sys.default_constraints d on c.default_object_id = d.object_id

    where t.name = 'STOCKINFOAUDIT'

      and c.name = 'ID'

      and s.name = 'DBO') >0)

	  BEGIN 

ALTER TABLE STOCKINFOAUDIT

DROP CONSTRAINT DF__StockInfoAud__ID__4564DFB9;

end

Go

IF( (select COUNT(*)

      from sys.all_columns c

      join sys.tables t on t.object_id = c.object_id

      join sys.schemas s on s.schema_id = t.schema_id

      join sys.default_constraints d on c.default_object_id = d.object_id

    where t.name = 'STOCKINFOAUDIT'

      and c.name = 'RepossessedItem'

      and s.name = 'DBO') >0)

	  BEGIN 

ALTER TABLE STOCKINFOAUDIT

DROP CONSTRAINT DF__StockInfo__Repos__465903F2;

end

Go

IF( (select COUNT(*)

      from sys.all_columns c

      join sys.tables t on t.object_id = c.object_id

      join sys.schemas s on s.schema_id = t.schema_id

      join sys.default_constraints d on c.default_object_id = d.object_id

    where t.name = 'STOCKINFOAUDIT'

      and c.name = 'SparePart'

      and s.name = 'DBO') >0)

	  BEGIN 

ALTER TABLE STOCKINFOAUDIT

DROP CONSTRAINT DF__StockInfo__Spare__5A2AF275;

end

Go

  IF( ( SELECT COUNT(*)

FROM   sys.key_constraints

WHERE  [type] = 'PK'

       AND [parent_object_id] = Object_id('dbo.StockInfoAudit'))>0)

	   begin

	   ALTER TABLE StockInfoAudit

		DROP CONSTRAINT PK_StockInfoAudit;

end

Go


IF( (select COUNT(*)

      from sys.all_columns c

      join sys.tables t on t.object_id = c.object_id

      join sys.schemas s on s.schema_id = t.schema_id

      join sys.default_constraints d on c.default_object_id = d.object_id

    where t.name = 'BSAPilog'

      and c.name = 'CreatedOn'

      and s.name = 'DBO') >0)

	  BEGIN 

ALTER TABLE BSAPilog

DROP CONSTRAINT DF_BSAPILog_CreatedOn;

end

IF( ( SELECT COUNT(*)

FROM   sys.key_constraints

WHERE  [type] = 'PK'

       AND [parent_object_id] = Object_id('dbo.bsapilog'))>0)

	   begin

	   ALTER TABLE BSAPilog

		DROP CONSTRAINT PK_BSAPILog;

end

Go

IF( (select COUNT(*)

      from sys.all_columns c

      join sys.tables t on t.object_id = c.object_id

      join sys.schemas s on s.schema_id = t.schema_id

      join sys.default_constraints d on c.default_object_id = d.object_id

    where t.name = 'Letter'

      and c.name = 'dateacctlttr'

      and s.name = 'DBO') >0)

	  BEGIN 

ALTER TABLE letter

DROP CONSTRAINT DF__letter__dateacct__027D5126;

end

GO
 


/****** Object:  Trigger [TR_Letter_AddTo_Remove_ReFin]    Script Date: 1/7/2025 12:26:14 AM ******/

IF EXISTS (SELECT * FROM sys.objects WHERE [name] = N'TR_Letter_AddTo_Remove_ReFin' AND [type] = 'TR')

BEGIN 

DROP TRIGGER [dbo].[TR_Letter_AddTo_Remove_ReFin];

END;

GO

IF EXISTS (SELECT * FROM sys.objects WHERE [name] = N'tr_letter_addto_removerf' AND [type] = 'TR')

BEGIN 

DROP TRIGGER [dbo].[tr_letter_addto_removerf];

END;

GO 

if( ( SELECT count(*)

FROM sys.indexes 

WHERE name='IX_letter_acctno_lettercode' AND object_id = OBJECT_ID('dbo.letter')) >0)

begin

Drop index IX_letter_acctno_lettercode  on  dbo.letter

End


GO

if( ( SELECT count(*)

FROM sys.indexes 

WHERE name='ix_letter_date_code' AND object_id = OBJECT_ID('dbo.letter')) >0)

begin

Drop index ix_letter_date_code  on  dbo.letter

End

GO

if( ( SELECT count(*)

FROM sys.indexes 

WHERE name='ixcl_letter' AND object_id = OBJECT_ID('dbo.letter')) >0)

begin

Drop index ixcl_letter  on  dbo.letter

End


GO
if( ( SELECT count(*)

FROM sys.indexes 

WHERE name='August-2022_missing_index_30_29_BSAPILog' AND object_id = OBJECT_ID('dbo.bsapilog')) >0)

begin

Drop index [August-2022_missing_index_30_29_BSAPILog]  on  dbo.bsapilog

End



GO


IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'bsapilog_new'))  

BEGIN

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

CREATE TABLE [dbo].[bsapilog_new](

	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,

	[UniqueId] [varchar](50) NULL,

	[CoSaCSAPIName] [varchar](200) NULL,

	[MambuAPIName] [varchar](200) NULL,

	[APIURL] [varchar](500) NULL,

	[RequestJSON] [varchar](max) NULL,

	[ResponseJSON] [varchar](max) NULL,

	[IsSuccess] [bit] NULL,

	[IsDBError] [bit] NULL,

	[ErrorDetail] [varchar](max) NULL,

	[CreatedOn] [datetime] NULL,

	[RequestTraceId] [nvarchar](500) NULL,

	[ResponseTraceId] [nvarchar](500) NULL,

	[RequestHeaders] [nvarchar](max) NULL,

	[ResponseHeaders] [nvarchar](max) NULL,

CONSTRAINT [PK_BSAPILog] PRIMARY KEY CLUSTERED 

(

	[Id] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--ALTER TABLE [dbo].[bsapilog_new] ADD  CONSTRAINT [DF_BSAPILog_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]

SET ANSI_PADDING OFF

END

Go

IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'StockInfoAudit_New'))  

BEGIN

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

CREATE TABLE [dbo].[StockInfoAudit_New](

	[Itemno] [varchar](18) NOT NULL,

	[Itemdescr1] [varchar](32) NOT NULL,

	[Itemdescr2] [varchar](40) NOT NULL,

	[Category] [smallint] NULL,

	[Supplier] [varchar](40) NULL,

	[ProdStatus] [varchar](1) NULL,

	[SupplierCode] [varchar](18) NULL,

	[Warrantable] [smallint] NULL,

	[Itemtype] [varchar](1) NOT NULL,

	[WarrantyRenewalFlag] [char](1) NOT NULL,

	[Leadtime] [smallint] NOT NULL,

	[AssemblyRequired] [char](1) NULL,

	[Taxrate] [float] NOT NULL,

	[DateChange] [datetime] NOT NULL,

	[ID] [int] NOT NULL,

	[SKU] [varchar](18) NOT NULL,

	[IUPC] [varchar](18) NULL,

	[Class] [varchar](5) NULL,

	[SubClass] [char](5) NULL,

	[ColourName] [varchar](12) NULL,

	[ColourCode] [varchar](3) NULL,

	[QtyBoxes] [smallint] NULL,

	[WarrantyLength] [smallint] NULL,

	[VendorWarranty] [smallint] NULL,

	[Brand] [varchar](25) NULL,

	[VendorStyle] [varchar](12) NULL,

	[VendorLongStyle] [varchar](25) NULL,

	[VendorEAN] [varchar](18) NULL,

	[RepossessedItem] [bit] NOT NULL,

	[ItemPOSDescr] [varchar](25) NULL,

	[SparePart] [bit] NOT NULL,

CONSTRAINT [PK_StockInfoAudit] PRIMARY KEY CLUSTERED 

(

	[ID] ASC,

	[DateChange] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

) ON [PRIMARY]


--ALTER TABLE [dbo].[StockInfoAudit_New] ADD  DEFAULT ((0)) FOR [ID]

--ALTER TABLE [dbo].[StockInfoAudit_New] ADD  DEFAULT ((0)) FOR [RepossessedItem]

--ALTER TABLE [dbo].[StockInfoAudit_New] ADD  DEFAULT ((0)) FOR [SparePart]

SET ANSI_PADDING OFF

END

Go

  IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'ELMAH_Error_New'))  

BEGIN

-- SET ANSI_NULLS ON

SET ANSI_NULLS ON

SET ANSI_PADDING ON

SET QUOTED_IDENTIFIER ON

CREATE TABLE [dbo].[ELMAH_Error_New](

	[ErrorId] [uniqueidentifier] NOT NULL,

	[Application] [nvarchar](60) NOT NULL,

	[Host] [nvarchar](50) NOT NULL,

	[Type] [nvarchar](100) NOT NULL,

	[Source] [nvarchar](60) NOT NULL,

	[Message] [nvarchar](500) NOT NULL,

	[User] [nvarchar](50) NOT NULL,

	[StatusCode] [int] NOT NULL,

	[TimeUtc] [datetime] NOT NULL,

	[Sequence] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,

	[AllXml] [ntext] NOT NULL,

CONSTRAINT [PK_ELMAH_Error] PRIMARY KEY NONCLUSTERED 

(

	[ErrorId] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


--ALTER TABLE [dbo].[ELMAH_Error_New] ADD  CONSTRAINT [DF_ELMAH_Error_ErrorId]  DEFAULT (newid()) FOR [ErrorId]


SET ANSI_PADDING OFF

END

Go

  IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Event_New'))  

BEGIN

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

CREATE TABLE [dbo].[event_new](

	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,

	[EventOnUtc] [datetime] NOT NULL,

	[EventType] [nvarchar](100) NOT NULL,

	[EventCategory] [nvarchar](50) NULL,

	[EventBy] [nvarchar](50) NULL,

	[IndexName1] [nvarchar](50) NULL,

	[IndexValue1] [nvarchar](100) NULL,

	[IndexName2] [nvarchar](50) NULL,

	[IndexValue2] [nvarchar](100) NULL,

	[IndexName3] [nvarchar](50) NULL,

	[IndexValue3] [nvarchar](100) NULL,

	[Payload] [varbinary](max) NOT NULL,

	[ClientAddress] [varchar](50) NULL,

CONSTRAINT [PK_Event1] PRIMARY KEY CLUSTERED 

(

	[Id] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [AUDIT]

) ON [AUDIT] TEXTIMAGE_ON [AUDIT]


SET ANSI_PADDING OFF

End
 
GO
 


IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'letter_new'))  

BEGIN

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON
 
CREATE TABLE [dbo].[letter_new](

	[runno] [smallint] NULL,

	[acctno] [char](12) NOT NULL,

	[dateacctlttr] [datetime] NOT NULL,

	[datedue] [datetime] NULL,

	[lettercode] [varchar](10) NOT NULL,

	[addtovalue] [money] NULL,

	[ExcelGen] [bit] NULL

) ON [PRIMARY]

SET ANSI_PADDING off

End

--ALTER TABLE [dbo].[letter_new] ADD  DEFAULT (' ') FOR [dateacctlttr]

GO


 
 
 
------------------------------------------
 