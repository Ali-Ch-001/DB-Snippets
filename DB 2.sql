CREATE DATABASE UNI

CREATE TABLE Students
(
    Student_id int PRIMARY KEY,
    Student_Name VARCHAR(255) NOT NULL,
    Student_Address VARCHAR(255) NOT NULL,
    Student_Batch VARCHAR(255) NOT NULL,
    Department VARCHAR(100) NOT NULL,
    CGPA FLOAT NOT Null

);

CREATE TABLE Instructors
(
    Instructor_id int PRIMARY KEY,
    Instructor_Name VARCHAR(255) Not NULL,
    Salary FLOAT Not NULL,
    Joing_Date DATE Not Null

); 

CREATE TABLE Courses
(
    Course_id int PRIMARY KEY,
    Course_Name VARCHAR(255) NOT NULL,
    Course_Credit_Hours FLOAT NOT NULL,
    InstructorID int NOT NULL 
 
);

CREATE Table Registration 
(
    StudentID int not null,
    CourseID int NOT NULL,
    Grade VARCHAR(5)

);


Alter TABLE Courses add CONSTRAINT fk_instructor_id FOREIGN key (InstructorID) REFERENCES Instructors(Instructo_id);

ALTER TABLE  Registration Add CONSTRAINT fk_StudentID FOREIGN KEY (StudentID) REFERENCES Students(Student_id);

ALTER TABLE  Registration ADD CONSTRAINT fk_CourseID FOREIGN KEY (CourseID) REFERENCES Courses(Course_id);

ALTER TABLE  Registration ADD CONSTRAINT Pk_composite PRIMARY key(StudentID,CourseID);


insert into students(Student_id , Student_Name , Student_Address , Student_Batch , Department ,CGPA)
values (1,'Ali Raza Awan','123 model town',2019 , 'CS' ,3.3),
(2,'Ayesha Khan','563 model town',2018 , 'DS' ,4),
(3,'CH Ahmed Mughal','890 Gaujumata town',2020 , 'EE' ,2.2)

INSERT into Instructors(Instructor_id , Instructor_Name ,  Salary ,Joing_Date)
VALUES (1,'Muhammad Nasir Khan',89000 , '2018-01-12'),
(2,'Muhammad Zafar Cheema',90000 , '2018-01-12'),
(3,'Sadia Dildar Waraich',85000 , '2015-10-12'),
(4,'Ch Samia Nadeem' ,99999 , '2020-03-11')

INSERT into Courses(Course_id , Course_Name , Course_Credit_Hours ,InstructorID)
VALUES (1,'Conputer Programming', 3, 1),
(2,'Computer Organization and Assembly',3 ,2 ),
(3,'Database Systems',2 ,1 )

INSERT into Registration(StudentID ,CourseID ,Grade)
VALUES (1, 2 ,'I'),
(1,3 ,'A+'),
(2 ,2 ,'F')

SELECT * from Students
SELECT * from Instructors
SELECT * from Courses
SELECT * from Registration


SELECT Student_id , Student_Batch from Students

SELECT * from Students 
where (Department = 'DS');


EXEC sp_rename 'Courses.Course_Name' , 'Subject_Name','COLUMN';


SELECT * from Instructors
WHERE Instructor_Name LIKE 'Muhammad%'


SELECT * from Instructors
order by Salary DESC


SELECT * from Instructors
where Joing_Date like '%-01-%' OR Joing_Date like  '%-12-%';

SELECT * from Instructors
where MONTH(Joing_Date)=01 OR  MONTH(Joing_Date)=12 ;

SELECT * from Instructors
where  year(Joing_Date)<2018;

SELECT Instructor_Name , Salary + 5000 from Instructors

SELECT * from Courses
