-- Create Publisher Table
CREATE TABLE Publisher (
    Name VARCHAR2(100) PRIMARY KEY,
    Address VARCHAR2(255),
    Phone VARCHAR2(15)
);

-- Create LibraryBranch Table
CREATE TABLE LibraryBranch (
    BranchId NUMBER PRIMARY KEY,
    BranchName VARCHAR2(100),
    Address VARCHAR2(255)
);

-- Create Borrower Table
CREATE TABLE Borrower (
    CardNo NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Address VARCHAR2(255),
    Phone VARCHAR2(15)
);

DROP TABLE BookLoan;
DROP TABLE BookAuthors;
DROP TABLE BookCopies;
DROP TABLE Book;


-- Create Book Table
CREATE TABLE Book (
    BookId VARCHAR2(15) PRIMARY KEY,
    Title VARCHAR2(255),
    PublisherName VARCHAR2(100),
    FOREIGN KEY (PublisherName) REFERENCES Publisher(Name)
);

-- Create BookCopies Table
CREATE TABLE BookCopies (
    BookId VARCHAR2(15),
    BranchId NUMBER,
    PRIMARY KEY (BookId, BranchId),
    FOREIGN KEY (BookId) REFERENCES Book(BookId),
    FOREIGN KEY (BranchId) REFERENCES LibraryBranch(BranchId)
);

ALTER TABLE BookCopies
ADD NoOfCopies NUMBER ;



-- Create BookAuthors Table
CREATE TABLE BookAuthors (
    BookId VARCHAR2(15),
    AuthorName VARCHAR2(100),
    PRIMARY KEY (BookId, AuthorName),
    FOREIGN KEY (BookId) REFERENCES Book(BookId)
);

-- Create BookLoan Table
CREATE TABLE BookLoan (
    BookId VARCHAR2(15),
    BranchId NUMBER,
    CardNo NUMBER,
    DateOut DATE,
    PRIMARY KEY (BookId, BranchId, CardNo),
    FOREIGN KEY (BookId) REFERENCES Book(BookId),
    FOREIGN KEY (BranchId) REFERENCES LibraryBranch(BranchId),
    FOREIGN KEY (CardNo) REFERENCES Borrower(CardNo)
);

ALTER TABLE BookLoan
ADD DueDate Date ;


-- Insert into Publisher Table
INSERT ALL
    INTO Publisher (Name, Address, Phone) VALUES ('PHI', '20 Delhi Super Market', '01715-454678')
    INTO Publisher (Name, Address, Phone) VALUES ('Tata', 'North Kolkata', '0156-2345445')
    INTO Publisher (Name, Address, Phone) VALUES ('Galgotia', 'Mumbai', '0192-203490')
SELECT * FROM dual;

-- Insert into LibraryBranch Table
INSERT ALL
    INTO LibraryBranch (BranchId, BranchName, Address) VALUES (1001, 'CSE Seminar Library', 'Rajshahi')
    INTO LibraryBranch (BranchId, BranchName, Address) VALUES (1002, 'RU Central Library', 'Rajshahi')
    INTO LibraryBranch (BranchId, BranchName, Address) VALUES (1003, 'DU Central Library', 'Dhaka')
SELECT * FROM dual;


-- Insert into Borrower Table
INSERT ALL
    INTO Borrower (CardNo, Name, Address, Phone) VALUES (10001, 'Saidur', 'CSE', '01714-400567')
    INTO Borrower (CardNo, Name, Address, Phone) VALUES (10002, 'Rafiq', 'PHYSICS', '0194-300456')
    INTO Borrower (CardNo, Name, Address, Phone) VALUES (10003, 'Masud', 'CSE', '0156-345678')
    INTO Borrower (CardNo, Name, Address, Phone) VALUES (10004, 'Nobir', 'ICT', '01199-203456')
SELECT * FROM dual;

-- Insert into Book Table
INSERT ALL
    INTO Book (BookId, Title, PublisherName) VALUES ('100.001cn', 'Computer Network', 'PHI')
    INTO Book (BookId, Title, PublisherName) VALUES ('100.002dsc', 'Database System', 'Tata')
    INTO Book (BookId, Title, PublisherName) VALUES ('100.003ds', 'Digital System', 'PHI')
    INTO Book (BookId, Title, PublisherName) VALUES ('100.004db', 'DBMS', 'PHI')
    INTO Book (BookId, Title, PublisherName) VALUES ('100.005ora', 'Oracle 2000', 'Galgotia')
SELECT * FROM dual;

-- Insert into BookCopies Table with NoOfCopies
INSERT ALL
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.001cn', 1001, 2)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.001cn', 1002, 5)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.002dsc', 1001, 3)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.002dsc', 1002, 4)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.003ds', 1001, 3)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.003ds', 1003, 5)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.004db', 1001, 2)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.004db', 1002, 5)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.005ora', 1001, 2)
    INTO BookCopies (BookId, BranchId, NoOfCopies) VALUES ('100.005ora', 1002, 7)
SELECT * FROM dual;


-- Insert into BookAuthors Table
INSERT ALL
    INTO BookAuthors (BookId, AuthorName) VALUES ('100.001cn', 'A S Tanenbaum')
    INTO BookAuthors (BookId, AuthorName) VALUES ('100.002dsc', 'Silberschatz')
    INTO BookAuthors (BookId, AuthorName) VALUES ('100.003ds', 'Ronald J Tocci')
    INTO BookAuthors (BookId, AuthorName) VALUES ('100.004db', 'Ivan Bayross')
    INTO BookAuthors (BookId, AuthorName) VALUES ('100.005ora', 'Ivan Bayross')
SELECT * FROM dual;

-- Insert into BookLoan Table
INSERT ALL
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.001cn', 1001, 10001, TO_DATE('15-Jan-15', 'DD-Mon-YY'), TO_DATE('15-Feb-15', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.001cn', 1002, 10002, TO_DATE('25-Jan-15', 'DD-Mon-YY'), TO_DATE('25-Feb-15', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.002dsc', 1001, 10003, TO_DATE('20-Feb-15', 'DD-Mon-YY'), TO_DATE('20-Mar-15', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.002dsc', 1002, 10004, TO_DATE('15-Mar-15', 'DD-Mon-YY'), TO_DATE('15-Apr-15', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.003ds', 1001, 10001, TO_DATE('07-Jun-15', 'DD-Mon-YY'), TO_DATE('07-Jul-15', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.003ds', 1003, 10002, TO_DATE('15-Oct-15', 'DD-Mon-YY'), TO_DATE('15-Nov-15', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.004db', 1001, 10003, TO_DATE('25-Oct-15', 'DD-Mon-YY'), TO_DATE('25-Nov-15', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.004db', 1002, 10004, TO_DATE('15-Nov-15', 'DD-Mon-YY'), TO_DATE('15-Dec-15', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.005ora', 1001, 10003, TO_DATE('22-Dec-15', 'DD-Mon-YY'), TO_DATE('22-Jan-16', 'DD-Mon-YY'))
    INTO BookLoan (BookId, BranchId, CardNo, DateOut, DueDate) VALUES ('100.005ora', 1002, 10001, TO_DATE('25-Dec-15', 'DD-Mon-YY'), TO_DATE('25-Jan-16', 'DD-Mon-YY'))
SELECT * FROM dual;



