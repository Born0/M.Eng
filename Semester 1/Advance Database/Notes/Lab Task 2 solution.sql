-- Create tables
CREATE TABLE meve_employee (
    employee_name VARCHAR2(50) PRIMARY KEY,
    street VARCHAR2(50),
    city VARCHAR2(50)
);

CREATE TABLE meve_works (
    employee_name VARCHAR2(50) PRIMARY KEY,
    company_name VARCHAR2(50),
    salary NUMBER
);




SELECT *
FROM   meve_employee;	

SELECT *
FROM   meve_works;

-- Insert data into tables
INSERT ALL
		INTO meve_employee (employee_name, street, city) VALUES ('Arif', '51 upashahar', 'Rajshahi')
        INTO meve_employee (employee_name, street, city) VALUES ('Sumon', '52 east', 'Moynamati')
        INTO meve_employee (employee_name, street, city) VALUES ('Sagor', 'Neemgachhi', 'Sirajgong')
        INTO meve_employee (employee_name, street, city) VALUES ('Abdul', 'Binodpur', 'Rajshahi')
        INTO meve_employee (employee_name, street, city) VALUES ('Himesh', 'Nazrul avenue', 'Dhaka')
        INTO meve_employee (employee_name, street, city) VALUES ('Amirul', 'Chawk bazar', 'Sylhet')
        INTO meve_employee (employee_name, street, city) VALUES ('Sajib', '99 north', 'Chittagong')
SELECT * FROM dual;

INSERT ALL
		 INTO meve_works (employee_name, company_name, salary) VALUES ('Sumon', 'Agrani', 12000)
		 INTO meve_works (employee_name, company_name, salary) VALUES ('Abdul', 'Sonali', 13000)
		 INTO meve_works (employee_name, company_name, salary) VALUES ('Himesh', 'Agrani', 6000)
		 INTO meve_works (employee_name, company_name, salary) VALUES ('Amirul', 'Sonali', 20000)
		 INTO meve_works (employee_name, company_name, salary) VALUES ('Sagor', 'Sonali', 8000)
		 INTO meve_works (employee_name, company_name, salary) VALUES ('Arif', 'Janata', 13000)
		 INTO meve_works (employee_name, company_name, salary) VALUES ('Sajib', 'Janata', 9000)
SELECT * FROM dual;

-- Queries
-- Find the names of all employees who live in Rajshahi city
SELECT employee_name FROM meve_employee WHERE city = 'Rajshahi';

-- Find the names and streets address of all employees who live in Rajshahi city
SELECT employee_name, street FROM meve_employee WHERE city = 'Rajshahi';

-- Find the names of all employees who work for (i) Sonali (ii) Agrani (iii) Janata
SELECT employee_name FROM meve_works WHERE company_name IN ('Sonali', 'Agrani', 'Janata');

-- Find the names and salary of all employees who work for (i) Sonali (ii) Agrani (iii) Janata
SELECT employee_name, salary FROM meve_works WHERE company_name IN ('Sonali', 'Agrani', 'Janata');

-- Find the names of all employees whose salary is (i) 12000 (ii) >=12000 (iii) <12000
SELECT employee_name FROM meve_works WHERE salary = 12000;
SELECT employee_name FROM meve_works WHERE salary >= 12000;
SELECT employee_name FROM meve_works WHERE salary < 12000;

-- Find the names and company of all employees whose salary is (i) 12000 (ii) >=12000 (iii) <12000
SELECT employee_name, company_name FROM meve_works WHERE salary = 12000;
SELECT employee_name, company_name FROM meve_works WHERE salary >= 12000;
SELECT employee_name, company_name FROM meve_works WHERE salary < 12000;

-- Find the names, streets and cities of all employees who work for Agrani
SELECT e.employee_name, e.street, e.city
FROM meve_employee e
JOIN meve_works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'Agrani';

-- Find the names, streets and cities of all employees who earn >=10000
SELECT e.employee_name, e.street, e.city
FROM meve_employee e
JOIN meve_works w ON e.employee_name = w.employee_name
WHERE w.salary >= 10000;

-- Find the names, company and salary of all employees who live in Rajshahi city
SELECT e.employee_name, w.company_name, w.salary
FROM meve_employee e
JOIN meve_works w ON e.employee_name = w.employee_name
WHERE e.city = 'Rajshahi';

-- Find the names, streets, cities and companies of all employees who earn >=10000
SELECT e.employee_name, e.street, e.city, w.company_name
FROM meve_employee e
JOIN meve_works w ON e.employee_name = w.employee_name
WHERE w.salary >= 10000;

-- Find the names, streets and cities of all employees who work for Sonali and earn more than 12000
SELECT e.employee_name, e.street, e.city
FROM meve_employee e
JOIN meve_works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'Sonali' AND w.salary > 12000;

-- Find all employees in the database who do not work for Sonali Bank
SELECT e.employee_name
FROM meve_employee e
WHERE NOT EXISTS (
    SELECT 1 FROM meve_works w
    WHERE e.employee_name = w.employee_name AND w.company_name = 'Sonali'
);


-- Modify "Arif" to live in Natore
UPDATE meve_employee SET city = 'Natore' WHERE employee_name = 'Arif';

-- Give all employees of "Agrani" Bank 10 percent salary raise
UPDATE meve_works SET salary = salary * 1.10 WHERE company_name = 'Agrani';

-- Delete all records for "Sagor" in employee table
DELETE FROM meve_employee WHERE employee_name = 'Sagor';

-- Add a column "manager" in the company table
ALTER TABLE meve_works ADD manager VARCHAR2(50);