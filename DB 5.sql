create database lab5

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemNo] [int] NOT NULL,
	[Name] [varchar](10) NULL,
	[Price] [int] NULL,
	[Quantity in Store] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (100, N'A', 1000, 100)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (200, N'B', 2000, 50)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (300, N'C', 3000, 60)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (400, N'D', 6000, 400)
/****** Object:  Table [dbo].[Courses]    Script Date: 02/17/2017 13:04:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerNo] [varchar](2) NOT NULL,
	[Name] [varchar](30) NULL,
	[City] [varchar](3) NULL,
	[Phone] [varchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C1', N'AHMED ALI', N'LHR', N'111111')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C2', N'ALI', N'LHR', N'222222')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C3', N'AYESHA', N'LHR', N'333333')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C4', N'BILAL', N'KHI', N'444444')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C5', N'SADAF', N'KHI', N'555555')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C6', N'FARAH', N'ISL', NULL)
/****** Object:  Table [dbo].[Order]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderNo] [int] NOT NULL,
	[CustomerNo] [varchar](2) NULL,
	[Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (1, N'C1', CAST(0x7F360B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (2, N'C3', CAST(0x2A3C0B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (3, N'C3', CAST(0x493C0B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (4, N'C4', CAST(0x4A3C0B00 AS Date))
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderNo] [int] NOT NULL,
	[ItemNo] [int] NOT NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC,
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 200, 20)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 400, 10)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (2, 200, 5)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (3, 200, 60)

GO
/****** Object:  ForeignKey [FK__OrderDeta__ItemN__4316F928]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ItemNo])
REFERENCES [dbo].[Items] ([ItemNo])
GO
/****** Object:  ForeignKey [FK__OrderDeta__Order__4222D4EF]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderNo])
REFERENCES [dbo].[Order] ([OrderNo])
GO

--q1
CREATE VIEW [dbo].[OrderedItemsGreaterThanStock]
AS
SELECT Items.ItemNo, Items.Name, SUM(OrderDetails.Quantity) AS TotalOrdered, Items.[Quantity in Store]
FROM OrderDetails
INNER JOIN Items ON OrderDetails.ItemNo = Items.ItemNo
GROUP BY Items.ItemNo, Items.Name, Items.[Quantity in Store]
HAVING SUM(OrderDetails.Quantity) > Items.[Quantity in Store];

SELECT * FROM OrderedItemsGreaterThanStock;


--q2

CREATE VIEW MostInDemandItems
AS
SELECT i.ItemNo, i.Name, SUM(od.Quantity) AS TotalQuantitySold
FROM Items i
JOIN OrderDetails od ON i.ItemNo = od.ItemNo
GROUP BY i.ItemNo, i.Name
HAVING SUM(od.Quantity) > 30


SELECT * FROM MostInDemandItems;


--q3

CREATE VIEW PremiumCustomers AS
SELECT C.CustomerNo, C.Name, C.City, C.Phone, SUM(OD.Quantity * I.Price) AS TotalPurchase
FROM Customers C
JOIN [Order] O ON C.CustomerNo = O.CustomerNo
JOIN OrderDetails OD ON O.OrderNo = OD.OrderNo
JOIN Items I ON OD.ItemNo = I.ItemNo
GROUP BY C.CustomerNo, C.Name, C.City, C.Phone
HAVING SUM(OD.Quantity * I.Price) > 2500


SELECT * FROM PremiumCustomers;


--q4

CREATE VIEW MaxPurchase AS
SELECT TOP 1 O.Date, C.Name, SUM(OD.Quantity * I.Price) AS TotalPurchase
FROM [Order] O
INNER JOIN [OrderDetails] OD ON O.OrderNo = OD.OrderNo
INNER JOIN [Items] I ON OD.ItemNo = I.ItemNo
INNER JOIN [Customers] C ON O.CustomerNo = C.CustomerNo
GROUP BY O.Date, C.Name
ORDER BY TotalPurchase DESC


SELECT * FROM MaxPurchase;

--q5

CREATE VIEW CustomersView AS 
SELECT * FROM Customers;

INSERT INTO CustomersView (CustomerNo, Name, City, Phone)
VALUES ('C7', 'Sana', 'ISL', '121341');

SELECT * FROM CustomersView;


--q6

CREATE VIEW CustomersWithPhone
AS
SELECT *
FROM Customers
WHERE Phone IS NOT NULL;


CREATE VIEW CustomersWithPhoneCheck
AS
SELECT *
FROM Customers
WHERE Phone IS NOT NULL
WITH CHECK OPTION;

-- Attempt to insert a customer with a null phone number through the first view
INSERT INTO CustomersWithPhone (CustomerNo, Name, City, Phone)
VALUES ('C9', 'ALINA', 'ISL', NULL);
-- Query OK, 1 row affected (0.01 sec)

-- Attempt to insert a customer with a null phone number through the second view
INSERT INTO CustomersWithPhoneCheck (CustomerNo, Name, City, Phone)
VALUES ('C8', 'ALINA', 'ISL', NULL);
-- ERROR 550, Level 16, State 1
-- The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.

-- Attempt to delete a customer through the first view
DELETE FROM CustomersWithPhone
WHERE CustomerNo = 'C6';
-- Query OK, 1 row affected (0.01 sec)

-- Attempt to delete a customer through the second view
DELETE FROM CustomersWithPhoneCheck
WHERE CustomerNo = 'C5';
-- ERROR 550, Level 16, State 1
-- The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.

-- Attempt to update a customer's phone number through the first view
UPDATE CustomersWithPhone
SET Phone = '666666'
WHERE CustomerNo = 'C4';
-- Query OK, 1 row affected (0.01 sec)

-- Attempt to update a customer's phone number to null through the second view
UPDATE CustomersWithPhoneCheck
SET Phone = NULL
WHERE CustomerNo = 'C4';
-- ERROR 550, Level 16, State 1
-- The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.



--q7

CREATE VIEW ItemQuantityByCustomer
with SCHEMABINDING
AS
SELECT i.ItemNo as ItemNum , c.Name AS CustomerName, SUM(od.Quantity) AS TotalQuantity, COUNT_BIG(*) as total 
FROM dbo.Items i
INNER JOIN dbo.OrderDetails od ON i.ItemNo = od.ItemNo
INNER JOIN dbo.[Order] o ON od.OrderNo = o.OrderNo
INNER JOIN dbo.Customers c ON o.CustomerNo = c.CustomerNo
WHERE c.Name LIKE '%ALI%' AND od.Quantity BETWEEN 15 AND 25
GROUP BY i.ItemNo, c.Name

CREATE unique CLUSTERED INDEX
IDX_ItemQuantityByCustomer_ItemNo
on ItemQuantityByCustomer(ItemNum)

set STATISTICS io on

SELECT  * From ItemQuantityByCustomer;


--q8



CREATE view customer_order_totals
with SCHEMABINDING
AS
SELECT od.ItemNo, o.CustomerNo, COUNT_BIG(*) AS num_orders, SUM(isnull(od.Quantity,0)) AS total_quantity
FROM dbo.[Order] o
JOIN dbo.OrderDetails od ON o.OrderNo = od.OrderNo
GROUP BY od.ItemNo, o.CustomerNo;


CREATE unique CLUSTERED INDEX
IDX_customer_order_totals_OrderNo
on customer_order_totals(ItemNo,CustomerNo)

set STATISTICS io on

SELECT  * From customer_order_totals
SELECT  * From customer_order_totals with(noexpand)



select * from [Customers]
select * from [Order]
select * from [OrderDetails]
select * from [Items]