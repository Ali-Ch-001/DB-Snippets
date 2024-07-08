CREATE DATABASE Managment

CREATE TABLE Student
(
    RollNum VARCHAR(255) not NULL,
    Name VARCHAR(255) not NULL,
    Gender VARCHAR(255) NOT NULL,
    Phone int Not Null

);

INSERT into Student(RollNum,Name,Gender,Phone)
VALUES ('P16441','Ahmad Butt','Male',1234567810),
('P16443','Muhammad Ahmed','Male',1234562789),
('P16444','Ali','Male',1233326789)



CREATE TABLE Attendence
(
     RollNum VARCHAR(255) not NULL,
     Date Date Not NULL,
     Status VARCHAR(2) Not NULL,
     ClassVenue int Not NULL

);


INSERT into Attendence(RollNum,Date,Status,ClassVenue)
VALUES('P16441','2023-02-22','P',7),('P16443','2023-02-23','A',8),('P16444','2023-03-04','P',9)

CREATE TABLE ClassVenue
(
    ID int NOT Null,
    Building VARCHAR(255) NOT Null,
    RoomNum Int NOT Null,
    Teacher VARCHAR(255) NOT Null

);


INSERT into ClassVenue(ID,Building,RoomNum,Teacher)
VALUES( 1, 'CS' , 2,'Irtaza'),( 2, 'Electrical' , 7,'Aamir')


CREATE TABLE Teacher 
(
    Name VARCHAR(255) NOT Null,
    Designation VARCHAR(255) NOT Null,
    Department VARCHAR(255) NOT Null
);
INSERT into Teacher(Name,Designation,Department)
VALUES('Irtaza','Lecturer','Computer Science'),('Aamir','Assistant Prof','Civil Engineering'),('Arshad','Professor','Electrical Engineering')


ALTER TABLE Student
ADD CONSTRAINT PK_Students PRIMARY KEY(RollNum)



ALTER TABLE Attendence
ADD CONSTRAINT Fk_Attendence FOREIGN KEY (RollNum) REFERENCES Student(RollNum) on  update cascade;
ALTER TABLE Attendence
ADD CONSTRAINT PK_Attendence PRIMARY KEY(ClassVenue);


ALTER TABLE ClassVenue
ADD CONSTRAINT FK_ClassVenue FOREIGN KEY (RoomNum) REFERENCES Attendence(ClassVenue) on  update cascade ;

ALTER TABLE ClassVenue
ADD CONSTRAINT PK_ClassVenue PRIMARY KEY(ID)

ALTER TABLE Teacher
ADD CONSTRAINT PK_Teacher PRIMARY KEY(Name,Designation,Department)

ALTER TABLE Student
Drop COLUMN Phone
ALTER TABLE Student
Add warning_count int

/* This will be a vaild insersetion but the last column is for warining counts which is int but data represents gpa or some other thing 
so only 3 will be inserted */
INSERT into Student(RollNum,Name,Gender,warning_count)
VALUES ('P16233', 'Faizan', 'Male', 3.2)

INSERT into ClassVenue(ID,Building,RoomNum,Teacher)
VALUES( 3, 'CS' , 5,'Ali')


/* First we need to add data of kashif into Teachers then we can update it*/
INSERT into Teacher(Name,Designation,Department)
VALUES('Kashif','HOD','Computer Science')

update Teacher
set Name ='Dr. Kashif Zafar'
WHERE Name='Kashif' AND Designation ='HOD' AND Department='Computer Science'

DELETE from Student
WHERE RollNum='P16443'

DELETE from Student
WHERE RollNum='P16444'

ALTER TABLE Teacher
add CONSTRAINT uk_name UNIQUE(Name)

TRUNCATE Table Student


EXEC sp_rename 'Teacher','Faculty';

alter TABLE Faculty
add Age int

update Faculty
set age = (42) 
WHERE NAME='Irtaza'

update Faculty
set age = (48) 
WHERE NAME='Aamir'

update Faculty
set age = (45) 
WHERE NAME='Arshad'

update Faculty
set age = (59) 
WHERE NAME='Dr. Kashif Zafar'


SELECT * FROM Student
SELECT * FROM Attendence
SELECT * FROM ClassVenue
SELECT * FROM Faculty