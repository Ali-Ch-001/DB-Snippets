create DATABASE L216003Lab

create table [UserType](
[userTypeId] int primary key,
[name] varchar(20) not null
)
go
create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[userType] int foreign key references UserType([userTypeId]),
[phoneNum] varchar(15) not null,
[city] varchar(20) not null 
)
go
create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go

Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go

create table TransactionType(
[transTypeID] int primary key,
[typeName] varchar(15),
[description] varchar(40) null
)

go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null,
transType int foreign key references TransactionType(transTypeID)
)




go
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (1, N'Silver')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (2, N'Gold')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (3, N'Bronze')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (4, N'Common')
GO






INSERT [dbo].[User] ([userId], [name], [userType],[phoneNum], [city]) VALUES (1, N'Ali',2, N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name],  [userType],[phoneNum], [city]) VALUES (2, N'Ahmed',1, N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (3, N'Aqeel',3, N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (4, N'Usman',4,  N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (5, N'Hafeez',2, N'03036061000', N'Lahore')
GO







INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (3, N'Gift', N'Enjoy')
GO





INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6569', 3, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'3336', 3, N'0234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6566', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6456', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'3436', 2, N'0034', CAST(N'2020-09-02' AS Date), 34025.12)
GO




INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'6569')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'3336')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'6566')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'3436')
GO





INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (1, N'Withdraw')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (2, N'Deposit')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (3, N'Scheduled')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (4, N'Failed')
GO





INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (1, CAST(N'2017-02-02' AS Date), N'6569', 500,1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (2, CAST(N'2018-02-03' AS Date), N'3436', 3000,3)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (3, CAST(N'2017-05-06' AS Date), N'6566', 2500,2)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (4, CAST(N'2016-09-09' AS Date), N'6566', 2000,1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (5, CAST(N'2015-02-10' AS Date), N'3336', 6000,4)
GO


Select * from UserType
Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]
Select * from TransactionType



--q1
CREATE PROCEDURE GetUserDetails
    @userName VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT u.userId, u.name, t.cardNum, c.balance, c.expireDate, tt.typeName, t.amount, u.phoneNum, u.city
    FROM [User] u
    INNER JOIN [UserCard] uc ON u.userId = uc.userID
    INNER JOIN [Card] c ON uc.cardNum = c.cardNum
    INNER JOIN [Transaction] t ON c.cardNum = t.cardNum
    INNER JOIN [TransactionType] tt ON t.transType = tt.transTypeID
    WHERE u.name = @userName
END


EXECUTE GetUserDetails 'Ali';


--q2

CREATE PROCEDURE spGetUserMinBalance
    
    @minBalance float OUTPUT
AS
BEGIN
    SELECT @minBalance = MIN(balance)
    FROM [Transaction] t
    JOIN [Card] c ON t.cardNum = c.cardNum
    JOIN [UserCard] uc ON c.cardNum = uc.cardNum

    RETURN
END


DECLARE @minBalance float
EXEC spGetUserMinBalance  @minBalance = @minBalance OUTPUT
SELECT @minBalance AS MinBalance


--q3

CREATE PROCEDURE GetCardCountForUser
    @UserName varchar(20),
    @UserID int,
    @CardCount int OUTPUT
AS
BEGIN
    SELECT @CardCount = COUNT(*)
    FROM UserCard uc
    JOIN [User] u ON uc.userID = u.userId
    WHERE u.name = @UserName AND u.userId = @UserID
END


DECLARE @CardCount int
EXEC GetCardCountForUser 'Ali', 1, @CardCount OUTPUT
PRINT 'Ali has ' + CAST(@CardCount AS varchar(10)) + ' cards'


--q4

CREATE PROCEDURE [dbo].[Login]
    @cardNum VARCHAR(4),
    @PIN VARCHAR(4),
    @status INT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [Card] WHERE [cardNum] = @cardNum AND [PIN] = @PIN)
        SET @status = -1;
    ELSE
        SET @status = 0;
END

DECLARE @status int
EXEC Login @cardNum = '3436', @PIN = '0034', @status = @status OUTPUT
SELECT @status as STATUS



--q5

CREATE PROCEDURE UpdatePIN
    @cardNum VARCHAR(20),
    @oldPIN VARCHAR(4),
    @newPIN VARCHAR(4)
AS
BEGIN
    -- Check if the new PIN is valid (4 digits)
    IF LEN(@newPIN) <> 4
    BEGIN
        PRINT 'Error: Invalid new PIN length. Must be 4 digits.'
        RETURN
    END

    -- Check if the old PIN matches the current PIN
    DECLARE @currentPIN VARCHAR(4)
    SELECT @currentPIN = PIN FROM Card WHERE cardNum = @cardNum

    IF @oldPIN <> @currentPIN
    BEGIN
        PRINT 'Error: Old PIN does not match current PIN.'
        RETURN
    END

    -- Update the PIN
    UPDATE Card SET PIN = @newPIN WHERE cardNum = @cardNum

    PRINT 'Updated PIN'
END


EXEC UpdatePIN 
    @cardNum = '3336',
    @oldPIN = '1234', 
    @newPIN = '5678' 



--q6

CREATE PROCEDURE WithDraw
(
    @cardNum varchar(20),
    @pin varchar(4),
    @amount float,
    @status INTEGER OUTPUT
)
AS
BEGIN
    -- Check if the card is valid
    DECLARE @isValid int
    EXEC Login @cardNum, @pin ,@status output
    IF @status = 0
    BEGIN
        PRINT 'Invalid card number or PIN'
        INSERT INTO [Transaction] (transId, transDate, cardNum, amount, transType)
        VALUES ((SELECT ISNULL(MAX(transId), 0) + 1 FROM [Transaction]), GETDATE(), @cardNum, @amount, 4)
        RETURN
    END

    -- Check if the balance is enough for the transaction
    DECLARE @balance float
    SELECT @balance = balance FROM [Card] WHERE cardNum = @cardNum
    IF @balance < @amount
    BEGIN
        PRINT 'Insufficient balance'
        INSERT INTO [Transaction] (transId, transDate, cardNum, amount, transType)
        VALUES ((SELECT ISNULL(MAX(transId), 0) + 1 FROM [Transaction]), GETDATE(), @cardNum, @amount, 4)
        RETURN
    END

    -- Update the balance and insert the transaction details
    UPDATE [Card] SET balance = balance - @amount WHERE cardNum = @cardNum
    INSERT INTO [Transaction] (transId, transDate, cardNum, amount, transType)
    VALUES ((SELECT ISNULL(MAX(transId), 0) + 1 FROM [Transaction]), GETDATE(), @cardNum, @amount, 1)
END



DECLARE @status int
EXEC WithDraw
@status = @status OUTPUT,
 @cardNum = '3436',
    @pin = '0034',
    @amount = 8000
    select @status as STATUS
    
