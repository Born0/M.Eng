-- Classroom table
CREATE TABLE Classroom (
    building VARCHAR2(50),
    room_number VARCHAR2(10),
    capacity NUMBER(5),
    CONSTRAINT pk_classroom PRIMARY KEY (building, room_number)
);

-- Department table
CREATE TABLE Department (
    dept_name VARCHAR2(50),
    building VARCHAR2(50),
    budget NUMBER(12,2),
    CONSTRAINT pk_department PRIMARY KEY (dept_name)
);

-- Course table
CREATE TABLE Course (
    course_id VARCHAR2(10),
    title VARCHAR2(100),
    dept_name VARCHAR2(50),
    credits NUMBER(2),
    CONSTRAINT pk_course PRIMARY KEY (course_id),
    CONSTRAINT fk_course_department FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

-- Instructor table
CREATE TABLE Instructor (
    ID VARCHAR2(10),
    name VARCHAR2(50),
    dept_name VARCHAR2(50),
    salary NUMBER(10,2),
    CONSTRAINT pk_instructor PRIMARY KEY (ID),
    CONSTRAINT fk_instructor_department FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

-- Section table
CREATE TABLE Section (
    course_id VARCHAR2(10),
    sec_id VARCHAR2(10),
    semester VARCHAR2(10),
    year NUMBER(4),
    building VARCHAR2(50),
    room_number VARCHAR2(10),
    time_slot_id VARCHAR2(10),
    CONSTRAINT pk_section PRIMARY KEY (course_id, sec_id, semester, year),
    CONSTRAINT fk_section_course FOREIGN KEY (course_id) REFERENCES Course(course_id),
    CONSTRAINT fk_section_classroom FOREIGN KEY (building, room_number) REFERENCES Classroom(building, room_number)
);

-- Teaches table
CREATE TABLE Teaches (
    ID VARCHAR2(10),
    course_id VARCHAR2(10),
    sec_id VARCHAR2(10),
    semester VARCHAR2(10),
    year NUMBER(4),
    CONSTRAINT pk_teaches PRIMARY KEY (ID, course_id, sec_id, semester, year),
    CONSTRAINT fk_teaches_instructor FOREIGN KEY (ID) REFERENCES Instructor(ID),
    CONSTRAINT fk_teaches_section FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section(course_id, sec_id, semester, year)
);

-- Student table
CREATE TABLE Student (
    ID VARCHAR2(10),
    name VARCHAR2(50),
    dept_name VARCHAR2(50),
    tot_credit NUMBER(3),
    CONSTRAINT pk_student PRIMARY KEY (ID),
    CONSTRAINT fk_student_department FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

-- Takes table
CREATE TABLE Takes (
    ID VARCHAR2(10),
    course_id VARCHAR2(10),
    sec_id VARCHAR2(10),
    semester VARCHAR2(10),
    year NUMBER(4),
    grade VARCHAR2(2),
    CONSTRAINT pk_takes PRIMARY KEY (ID, course_id, sec_id, semester, year),
    CONSTRAINT fk_takes_student FOREIGN KEY (ID) REFERENCES Student(ID),
    CONSTRAINT fk_takes_section FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section(course_id, sec_id, semester, year)
);

-- Advisor table
CREATE TABLE Advisor (
    s_ID VARCHAR2(10),
    i_ID VARCHAR2(10),
    CONSTRAINT pk_advisor PRIMARY KEY (s_ID),
    CONSTRAINT fk_advisor_student FOREIGN KEY (s_ID) REFERENCES Student(ID),
    CONSTRAINT fk_advisor_instructor FOREIGN KEY (i_ID) REFERENCES Instructor(ID)
);

-- Time_slot table
CREATE TABLE Time_slot (
    time_slot_id VARCHAR2(10),
    day VARCHAR2(10),
    start_time VARCHAR2(10),
    end_time VARCHAR2(10),
    CONSTRAINT pk_time_slot PRIMARY KEY (time_slot_id, day, start_time)
);

-- Prereq table
CREATE TABLE Prereq (
    course_id VARCHAR2(10),
    prereq_id VARCHAR2(10),
    CONSTRAINT pk_prereq PRIMARY KEY (course_id, prereq_id),
    CONSTRAINT fk_prereq_course FOREIGN KEY (course_id) REFERENCES Course(course_id),
    CONSTRAINT fk_prereq_prereq_course FOREIGN KEY (prereq_id) REFERENCES Course(course_id)
);



