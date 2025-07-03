CREATE DATABASE [EsemkaStore]
GO
USE [EsemkaStore]

CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Description] [text] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Qty] [int] NOT NULL,
	[TransactionID] [int] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Brand] [varchar](100) NULL,
	[Stock] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Price] [float] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Transaction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](255) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 
GO
INSERT [dbo].[Category] ([ID], [Name], [Description]) VALUES (1, N'Aksesoris', N'Aksesoris fashion')
GO
INSERT [dbo].[Category] ([ID], [Name], [Description]) VALUES (2, N'Fashion Pria', N'')
GO
INSERT [dbo].[Category] ([ID], [Name], [Description]) VALUES (3, N'Komputer dan Aksesoris', NULL)
GO
INSERT [dbo].[Category] ([ID], [Name], [Description]) VALUES (4, N'Elektronik', NULL)
GO
INSERT [dbo].[Category] ([ID], [Name], [Description]) VALUES (5, N'Jam Tangan', NULL)
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 
GO
INSERT [dbo].[Order] ([ID], [ProductID], [Qty], [TransactionID]) VALUES (1, 2, 5, 1)
GO
INSERT [dbo].[Order] ([ID], [ProductID], [Qty], [TransactionID]) VALUES (2, 1, 2, 1)
GO
INSERT [dbo].[Order] ([ID], [ProductID], [Qty], [TransactionID]) VALUES (3, 4, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([ID], [Name], [Brand], [Stock], [CategoryID], [Price]) VALUES (1, N'Produk A', N'Brand A', 100, 1, 15000)
GO
INSERT [dbo].[Product] ([ID], [Name], [Brand], [Stock], [CategoryID], [Price]) VALUES (2, N'Produk B', N'Brand B', 50, 3, 21650)
GO
INSERT [dbo].[Product] ([ID], [Name], [Brand], [Stock], [CategoryID], [Price]) VALUES (3, N'Produk C', N'Brand C', 10, 2, 10000)
GO
INSERT [dbo].[Product] ([ID], [Name], [Brand], [Stock], [CategoryID], [Price]) VALUES (4, N'Produk D', N'Brand D', 5, 4, 125000)
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 
GO
INSERT [dbo].[Transaction] ([ID], [CustomerName], [TransactionDate]) VALUES (1, N'Joko Subagjo', CAST(N'1996-05-21T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Product]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Transaction] FOREIGN KEY([TransactionID])
REFERENCES [dbo].[Transaction] ([ID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Transaction]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
USE [master]
GO
ALTER DATABASE [EsemkaStore] SET  READ_WRITE 
GO
