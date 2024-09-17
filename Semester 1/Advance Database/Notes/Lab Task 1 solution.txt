-- Create meve_student table
CREATE TABLE meve_student (
    roll VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50),
    year VARCHAR(10),
    semester VARCHAR(10)
);

-- Insert values into meve_student table
INSERT ALL
    INTO meve_student (roll, name, dept, year, semester) VALUES ('06543201', 'Rahim', 'BBA', '2nd', '1st')
    INTO meve_student (roll, name, dept, year, semester) VALUES ('06543202', 'Karim', 'ICE', '2nd', '1st')
    INTO meve_student (roll, name, dept, year, semester) VALUES ('06543203', 'Motin', 'CSE', '1st', '2nd')
    INTO meve_student (roll, name, dept, year, semester) VALUES ('05654456', 'Swadhin', 'CSE', '1st', '2nd')
    INTO meve_student (roll, name, dept, year, semester) VALUES ('05654457', 'Hena', 'BBA', '4th', '2nd')
    INTO meve_student (roll, name, dept, year, semester) VALUES ('05654458', 'Sohag', 'CSE', '3rd', '1st')
SELECT * FROM dual;

-- Create meve_studentInfo table
CREATE TABLE meve_studentInfo (
    roll VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    fatherName VARCHAR(50),
    address VARCHAR(100),
    mobile VARCHAR(15)
);

-- Insert values into meve_studentInfo table
INSERT ALL
    INTO meve_studentInfo (roll, name, fatherName, address, mobile) VALUES ('06543201', 'Rahim', 'Ataur', 'Rajshahi', '01719201233')
    INTO meve_studentInfo (roll, name, fatherName, address, mobile) VALUES ('06543202', 'Karim', 'Tareq', 'Dhaka', '01719202020')
    INTO meve_studentInfo (roll, name, fatherName, address, mobile) VALUES ('06543203', 'Motin', 'Rahman', 'Khulna', '01719202678')
    INTO meve_studentInfo (roll, name, fatherName, address, mobile) VALUES ('05654456', 'Swadhin', 'Fazlu', 'Rajshahi', '01719204564')
    INTO meve_studentInfo (roll, name, fatherName, address, mobile) VALUES ('05654457', 'Hena', 'Rahman', 'Rajshahi', '01119212020')
    INTO meve_studentInfo (roll, name, fatherName, address, mobile) VALUES ('05654458', 'Sohag', 'Fazlul', 'Natore', '01719202222')
SELECT * FROM dual;

-- Select all rows from meve_student table
SELECT * FROM meve_student;

-- Select all rows from meve_studentInfo table
SELECT * FROM meve_studentInfo;

--Queries for meve_student Table:
--i. Names of students in 1st semester:
SELECT name FROM meve_student WHERE semester = '1st';


--ii. Names of students in 2nd year:
SELECT name FROM meve_student WHERE year = '2nd';

--iii. Names of students in CSE:
SELECT name FROM meve_student WHERE dept = 'CSE';

--iv. Name of the student with roll 06543201:
SELECT name FROM meve_student WHERE roll = '06543201';

--v. Names of students in specific locations:
SELECT name FROM meve_student WHERE 
    address IN ('Dhaka', 'Khulna', 'Rajshahi', 'Natore');
   
--Queries for meve_studentInfo Table:
--i. Names, address, and mobile of students whose fathers name is Rahman:
SELECT name, address, mobile FROM meve_studentInfo WHERE fatherName = 'Rahman';

--ii. Names, address, and mobile of students with mobile is 01719202020:
SELECT name, address, mobile FROM meve_studentInfo WHERE mobile = '01719202020';

 -- address is Rajshahi
SELECT name, address, mobile FROM meve_studentInfo WHERE address = 'Rajshahi'

-- address is Rajshahi and father’s name Rahman
SELECT name, address, mobile FROM meve_studentInfo WHERE  (address = 'Rajshahi' AND fatherName = 'Rahman')

-- roll is 05654456
SELECT name, address, mobile FROM meve_studentInfo WHERE roll = '05654456';

