CREATE TABLE meve_employee_4
(
employee_name VARCHAR2(50) PRIMARY KEY,
street VARCHAR2(50),
city VARCHAR2(30)
);

CREATE TABLE meve_company_4
(
company_name VARCHAR2(30) PRIMARY KEY,
city VARCHAR2(30)
);

CREATE TABLE meve_works_4
(
employee_name VARCHAR2(50) REFERENCES meve_employee_4(employee_name),
company_name VARCHAR2(30) REFERENCES meve_company_4(company_name),
salary NUMBER,

CONSTRAINT works_pk PRIMARY KEY (employee_name, company_name)
);

CREATE TABLE meve_manages_4
(
employee_name VARCHAR2(50) REFERENCES meve_employee_4(employee_name),
manager_name VARCHAR2(50) REFERENCES meve_employee_4(employee_name),

CONSTRAINT manages_pk PRIMARY KEY (employee_name, manager_name)
);


INSERT ALL
	INTO meve_employee_4 VALUES ('Arif', '51 upashahar', 'Rajshahi')
	INTO meve_employee_4 VALUES ('Sumon', '52 east', 'Moynamati')
	INTO meve_employee_4 VALUES ('Sagor', 'Neemgachhi', 'Sirajgong')
	INTO meve_employee_4 VALUES ('Abdul', 'Binodpur', 'Rajshahi')
	INTO meve_employee_4 VALUES ('Himesh', 'Nazrul avenue', 'Dhaka')
	INTO meve_employee_4 VALUES ('Amirul', 'Chawk bazar', 'Sylhet')
	INTO meve_employee_4 VALUES ('Sajib', '99 north', 'Chittagong')
	
	INTO meve_company_4 VALUES ('Agrani','Rajshahi')
	INTO meve_company_4 VALUES ('Sonali','Sylhet')
	INTO meve_company_4 VALUES ('Janata','Dhaka')
	
	INTO meve_works_4 VALUES ('Sumon','Agrani',12000)
	INTO meve_works_4 VALUES ('Abdul','Sonali',13000)
	INTO meve_works_4 VALUES ('Himesh','Agrani',6000)
	INTO meve_works_4 VALUES ('Amirul','Sonali',20000)
	INTO meve_works_4 VALUES ('Sagor','Sonali',8000)
	INTO meve_works_4 VALUES ('Arif','Janata',13000)
	INTO meve_works_4 VALUES ('Sajib','Janata',9000)
	
	INTO meve_manages_4 VALUES ('Amirul','Amirul')
	INTO meve_manages_4 VALUES ('Abdul','Amirul')
	INTO meve_manages_4 VALUES ('Sagor','Amirul')
	INTO meve_manages_4 VALUES ('Sumon','Sumon')
	INTO meve_manages_4 VALUES ('Himesh','Sumon')
	INTO meve_manages_4 VALUES ('Arif','Arif')
	INTO meve_manages_4 VALUES ('Sajib','Arif')

SELECT * FROM DUAL;




SELECT  *
FROM 	meve_employee_4

--5
SELECT 	e.*
FROM 	 meve_employee_4 e
		JOIN meve_works_4 w
		ON e.employee_name = w.employee_name
		LEFT JOIN meve_company_4 c
		ON c.company_name = w.company_name	
WHERE 	e.city = c.city
;

--6
SELECT 	e.employee_name, mn.employee_name
FROM 	meve_employee_4 e,
		meve_manages_4 m,
		meve_employee_4 mn 
WHERE 	e.employee_name = m.employee_name
		AND  e.employee_name = m.manager_name
		AND e.city = mn.city AND e.street = mn.street
;		

--  9
SELECT *
FROM 	meve_works_4
WHERE 	salary >(
					SELECT 	AVG(salary) 
					FROM 	meve_works_4
				)
;

--10

SELECT  max(num)
FROM (
	SELECT COUNT(employee_name)as num, company_name n 
	FROM 	meve_works_4
	GROUP by(company_name)
	ORDER BY num DESC 
)t
ha

SELECT COUNT(employee_name)as num, company_name n 
	FROM 	meve_works_4
	GROUP by(company_name)
	ORDER BY num DESC 
FETCH FIRST 1 ROW ONLY

SELECT c.company_name, COUNT(*) total_employees
FROM meve_company_4 c
JOIN meve_works_4 w ON c.company_name = w.company_name
GROUP BY c.company_name
ORDER BY total_employees DESC

FETCH FIRST 1 ROW ONLY;


SELECT c.company_name, COUNT(*) AS total_employees
FROM meve_company_4 c
JOIN meve_works_4 w ON c.company_name = w.company_name
GROUP BY c.company_name
ORDER BY total_employees DESC
FETCH NEXT 1 ROWS ONLY;



