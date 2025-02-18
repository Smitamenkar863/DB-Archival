IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'BSAPILog'))  
BEGIN
CREATE TABLE [dbo].[BSAPILog](
	[Id] [int] NOT NULL,
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
 ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 END
 
 IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'StockInfoAudit'))  
BEGIN
 CREATE TABLE [dbo].[StockInfoAudit](
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
 ) ON [PRIMARY]
 END
 
 
  IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'ELMAH_Error'))  
BEGIN
 CREATE TABLE [dbo].[ELMAH_Error](
	[ErrorId] [uniqueidentifier] NOT NULL,
	[Application] [nvarchar](60) NOT NULL,
	[Host] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](100) NOT NULL,
	[Source] [nvarchar](60) NOT NULL,
	[Message] [nvarchar](500) NOT NULL,
	[User] [nvarchar](50) NOT NULL,
	[StatusCode] [int] NOT NULL,
	[TimeUtc] [datetime] NOT NULL,
	[Sequence] [int]  NOT NULL,
	[AllXml] [ntext] NOT NULL,
 ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 END
 
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

  IF (Not EXISTS (SELECT *  FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Event'))  
BEGIN
CREATE TABLE [dbo].[Event](
	[Id] [bigint]  NOT NULL,
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
 ) 
END