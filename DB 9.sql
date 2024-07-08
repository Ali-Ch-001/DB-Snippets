use master
go
drop  database ATM
go 
Create database ATM
go 
use ATM
go

create table [User](
[userId] int primary key,
[name] varchar(20) not null,
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
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null
)


INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (1, N'Ali', N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (2, N'Ahmed', N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (3, N'Aqeel', N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (4, N'Usman', N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (5, N'Hafeez', N'03036061000', N'Lahore')
GO


INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1234', 1, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1235', 1, N'9234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1236', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1237', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1238', 2, N'9004', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1234')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1235')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'1236')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'1238')
GO
Insert  [dbo].[UserCard] ([userID], [cardNum]) VALUES (4, N'1237')

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1234', 500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (2, CAST(N'2018-02-03' AS Date), N'1235', 3000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (3, CAST(N'2020-01-06' AS Date), N'1236', 2500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (4, CAST(N'2016-09-09' AS Date), N'1238', 2000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (5, CAST(N'2020-02-10' AS Date), N'1234', 6000)
GO


Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]



--q1


CREATE PROCEDURE USER_VERIFICATION
    @userId INT,
    @Pin VARCHAR(4),
    @output VARCHAR(20) OUTPUT
AS
BEGIN
    SET @output = 'not_verified'

    IF EXISTS (SELECT * FROM [User] u
                JOIN UserCard uc ON u.userId = uc.userID
                JOIN [Card] c ON uc.cardNum = c.cardNum
                WHERE u.userId = @userId AND c.PIN = @Pin)
    BEGIN
        SET @output = 'verified'
    END
END


DECLARE @result VARCHAR(20)
EXECUTE USER_VERIFICATION @userId = 1, @Pin = '1770', @output = @result OUTPUT
SELECT @result



--q2

CREATE PROCEDURE BALANCE_INQUIRY
    @userId INT,
    @Pin VARCHAR(4),
    @status INT OUTPUT
AS
BEGIN
    DECLARE @output VARCHAR(20)

    EXEC USER_VERIFICATION @userId, @Pin, @output OUTPUT

    IF @output = 'verified'
    BEGIN
        DECLARE @balance FLOAT

        SELECT @balance = balance
        FROM [User] u
        JOIN UserCard uc ON u.userId = uc.userID
        JOIN [Card] c ON uc.cardNum = c.cardNum
        WHERE u.userId = @userId AND c.PIN = @Pin

        IF @balance = 0
            SET @status = 0
        ELSE IF @balance > 25000
            SET @status = 1
        ELSE
            SET @status = -1
    END
    ELSE
        SET @status = -1
END


DECLARE @userId INT = 1
DECLARE @Pin VARCHAR(4) = '1770'
DECLARE @status INT

EXEC BALANCE_INQUIRY @userId, @Pin, @status OUTPUT

SELECT @status as 'Balance Status'


--q3

CREATE PROCEDURE NOTIFY_USER
    @userId INT,
    @Pin VARCHAR(4)
AS
BEGIN
    DECLARE @status INT
    DECLARE @balance FLOAT

    EXEC BALANCE_INQUIRY @userId, @Pin, @status OUTPUT

    IF @status = 1
    BEGIN
        UPDATE [Card] SET balance = balance + 5000
        WHERE cardNum IN (
            SELECT cardNum FROM UserCard WHERE userID = @userId
        )

        PRINT 'savings account interest amount added'
    END
END


EXEC NOTIFY_USER @userId = 1, @Pin = '1770'



--q4


CREATE PROCEDURE RECORD_UPDATE
    @phoneNum VARCHAR(15),
    @newphonenum VARCHAR(15)
AS
BEGIN
    DECLARE @userId INT

    SELECT @userId = userId FROM [User] WHERE phoneNum = @phoneNum

    IF @userId IS NULL
    BEGIN
        PRINT 'Phone number not found'
    END
    ELSE
    BEGIN
        PRINT 'Record found. Please update the phone number:'
        
        UPDATE [User] SET phoneNum = @newphonenum WHERE userId = @userId
    END
END


EXEC RECORD_UPDATE @phoneNum = '03036067000', @newphonenum = '555-555-5555'




--q5


CREATE PROCEDURE UpdateUserBalance AS
BEGIN
    DECLARE @userId INT
    DECLARE @balance FLOAT
    DECLARE @cardNum VARCHAR(20)
    DECLARE @name VARCHAR(20)
    DECLARE @phoneNum VARCHAR(15)
    DECLARE @city VARCHAR(20)
    
    DECLARE UserCursor CURSOR FOR
        SELECT u.userId, u.name, u.phoneNum, u.city, c.balance, uc.cardNum
        FROM [User] u
        JOIN UserCard uc ON u.userId = uc.userID
        JOIN [Card] c ON uc.cardNum = c.cardNum
    
    OPEN UserCursor
    
    FETCH NEXT FROM UserCursor INTO @userId, @name, @phoneNum, @city, @balance, @cardNum
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE [Card] SET balance = balance + 1500 WHERE cardNum = @cardNum
        
        PRINT 'Updated balance for ' + @name + ': ' + CAST(@balance + 1500 AS VARCHAR(20))
        
        FETCH NEXT FROM UserCursor INTO @userId, @name, @phoneNum, @city, @balance, @cardNum
    END
    
    CLOSE UserCursor
    DEALLOCATE UserCursor
END



EXEC UpdateUserBalance
