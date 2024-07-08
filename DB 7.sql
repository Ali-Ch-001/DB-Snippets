
CREATE DATABASE Lab10

create table Student1
(RollNo varchar(7) primary key
,Name varchar(30)
,WarningCount int
,Department varchar(15)
)
GO
INSERT [dbo].[Student1] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'1', N'Ali', 0, N'CS')
INSERT [dbo].[Student1] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'2', N'Bilal', 0, N'CS')
INSERT [dbo].[Student1] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'3', N'Ayesha', 0, N'CS')
INSERT [dbo].[Student1] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'4', N'Ahmed', 0, N'CS')
INSERT [dbo].[Student1] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'5', N'Sara', 0, N'EE')
INSERT [dbo].[Student1] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'6', N'Salman', 1, N'EE')
INSERT [dbo].[Student1] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'7', N'Zainab', 2, N'CS')
INSERT [dbo].[Student1] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'8', N'Danial', 1, N'CS')

go
create table Course
(
CourseID int primary key,
CourseName varchar(40),
PrerequiteCourseID int,
CreditHours int
) 
GO
INSERT [dbo].[Course] ([CourseID], [CourseName],
 [PrerequiteCourseID],CreditHours) VALUES (10, N'Database Systems', 20, 3)
INSERT [dbo].[Course] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (20, N'Data Structures', 30,3)
INSERT [dbo].[Course] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (30, N'Programing', NULL,3)
INSERT [dbo].[Course] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (40, N'Basic Electronics', NULL,3)
go

go
Create table Instructor 
(
InstructorID int Primary key,
Name varchar(30),
Department varchar(7) ,
)
GO
INSERT [dbo].[Instructor] ([InstructorID], [Name], [Department]) VALUES (100, N'Ishaq Raza', N'CS')
INSERT [dbo].[Instructor] ([InstructorID], [Name], [Department]) VALUES (200, N'Zareen Alamgir', N'CS')
INSERT [dbo].[Instructor] ([InstructorID], [Name], [Department]) VALUES (300, N'Saima Zafar', N'EE')
go
Create table Semester
(
Semester varchar(15) Primary key,
[Status] varchar(10),
)
GO
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Fall2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2017', N'InProgress')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Summer2016', N'Cancelled')
go
Create table Courses_Semester
(
InstructorID int Foreign key References Instructor(InstructorID),
CourseID int Foreign key References Course(CourseID),
Semester varchar(15) Foreign key References Semester(Semester), 
Section varchar(1) ,
AvailableSeats int,
Department varchar(2)
)
GO
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'D', 45, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'C', 0, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (100, 10, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2016', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2016', N'A', 0, N'CS')

go



create table Registration
(
Semester varchar(15) Foreign key References Semester(Semester),
RollNumber  varchar(7) Foreign key References Student1(RollNo),
CourseID int Foreign key References Course(CourseID), 
Section varchar(1),
GPA float
)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'1', 20, N'A', 3.3)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'2', 20, N'B', 4)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2016', N'1', 30, N'A', 1.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'6', 40, N'D',0.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2017', N'6', 40, N'D',1)


go

Create table ChallanForm
(Semester varchar(15) Foreign key References Semester(Semester),
RollNumber  varchar(7) Foreign key References Student1(RollNo),
TotalDues int,
[Status] varchar(10)
)
GO
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'1', 100000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'2', 13333, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'3', 5000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'4', 20000, N'Pending')

CREATE TABLE Notify
(
    NotificationID int PRIMARY KEY,
    StudentID varchar(7) FOREIGN KEY REFERENCES Student1(RollNo),
    NotificationString varchar(200)
)
CREATE TABLE Enrolled_Courses
(
    RollNo varchar(7) FOREIGN KEY REFERENCES Student1(RollNo),
    CourseID int FOREIGN KEY REFERENCES Course(CourseID),
    Semester varchar(15) FOREIGN KEY REFERENCES Semester(Semester),
    Section varchar(1),
    FeeCharges int,
    PRIMARY KEY (RollNo, CourseID, Semester, Section)
)



select * from Student1
select * from Course
select * from Instructor
select * from Registration
select * from Semester
select * from Courses_Semester
select * from ChallanForm
select * from Notify
select * from Enrolled_Courses



--F1

CREATE TRIGGER TriggerPreventDeleteStudent
ON Students
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('You don''t have the permission to delete the student', 16, 1)
END



--F2

CREATE TRIGGER trg_NoInsertCourses ON Course
INSTEAD OF INSERT
AS
BEGIN
    PRINT 'You don''t have the permission to Insert a new Course'
END;

--does't insert
INSERT [dbo].[Course] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (12, N'Database Systems', 20, 3)


--F3


-- Create the trigger to notify students about registration status
CREATE TRIGGER trg_NotifyRegistrationStatus
ON Courses_Semester
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentID VARCHAR(7), @CourseID INT, @PrerequisiteCourseID INT, @AvailableSeats INT;

    -- Get the CourseID, PrerequisiteCourseID and AvailableSeats for the inserted row
    SELECT @CourseID = inserted.CourseID, @PrerequisiteCourseID = c.PrerequiteCourseID, @AvailableSeats = inserted.AvailableSeats
    FROM inserted
    JOIN Course c ON inserted.CourseID = c.CourseID;

    -- Check if the inserted course has any prerequisite course
    IF (@PrerequisiteCourseID IS NOT NULL)
    BEGIN
        -- Check if the student has passed the prerequisite course
        IF NOT EXISTS (SELECT 1 FROM Courses_Semester cs JOIN Student1 s ON cs.StudentID = s.RollNo WHERE cs.CourseID = @PrerequisiteCourseID AND cs.Section = inserted.Section AND cs.Semester = inserted.Semester AND s.RollNo = inserted.StudentID)
        BEGIN
            -- Student has not passed the prerequisite course
            INSERT INTO Notify(StudentID, NotificationString) VALUES (inserted.StudentID, 'You have not passed the prerequisite course for ' + (SELECT CourseName FROM Course WHERE CourseID = @CourseID));
            RETURN;
        END
    END

    -- Check if there are available seats for the inserted course
    IF (@AvailableSeats = 0)
    BEGIN
        -- No available seats
        INSERT INTO Notify(StudentID, NotificationString) VALUES (inserted.StudentID, 'No available seats for ' + (SELECT CourseName FROM Course WHERE CourseID = @CourseID));
        RETURN;
    END

    -- Course registration successful
    INSERT INTO Notify(StudentID, NotificationString) VALUES (inserted.StudentID, 'You have successfully registered for ' + (SELECT CourseName FROM Course WHERE CourseID = @CourseID));
END
GO



--F4

CREATE TRIGGER Enrolled_Courses_Insert
ON Enrolled_Courses
AFTER INSERT
AS
BEGIN
    IF EXISTS(
        SELECT RollNo, SUM(FeeCharges) as TotalFeeCharges
        FROM Enrolled_Courses
        WHERE RollNo = (SELECT RollNo FROM inserted)
        GROUP BY RollNo
        HAVING SUM(FeeCharges) > 20000
    )
    BEGIN
        RAISERROR ('Cannot insert. Fee charges limit exceeded.', 16, 1)
        DELETE FROM Enrolled_Courses WHERE RollNo = (SELECT RollNo FROM inserted)
        RETURN
    END
END


--F5


CREATE TRIGGER TR_Courses_Semester_Delete
ON Courses_Semester
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted WHERE AvailableSeats < 10)
    BEGIN
        PRINT 'not possible'
    END
    ELSE
    BEGIN
        DELETE Courses_Semester WHERE Semester IN (SELECT Semester FROM deleted)
        PRINT 'Successfully deleted'
    END
END


--F6

CREATE TRIGGER tr_stop_instructors_modification
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Instructor]') AND Type = 'U')
    BEGIN
        RAISERROR('Instructors table cannot be modified or dropped.', 16, 1);
        ROLLBACK;
    END
END
