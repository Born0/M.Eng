CREATE TABLE employee (
	ssn varchar(10) PRIMARY KEY,
	name varchar(20),
	address  varchar(25),
	sex  varchar(8),
	salary NUMBER,
	dno NUMBER,
	FOREIGN KEY (dno) REFERENCES depertment(dno)
	);
	  

CREATE  TABLE depertment(
	dno NUMBER  PRIMARY KEY,
	dname varchar(20),
	mgr_ssn  varchar(10),
	mgr_start_date date
	);

DROP TABLE dlocation;

CREATE TABLE dlocation(
	dno NUMBER,
	dloc varchar(20),
	PRIMARY KEY (dno, dloc),
	FOREIGN KEY (dno) REFERENCES depertment(dno)
	);
	

CREATE TABLE project(
	pno NUMBER,
	pname varchar(50),
	plocation varchar(50),
	dno NUMBER,
	FOREIGN KEY (dno) REFERENCES depertment(dno)
);


CREATE TABLE works_on(
	ssn varchar(10),
	pno NUMBER,
	hours NUMBER
	PRIMARY KEY (ssn,pno),
	FOREIGN KEY (ssn) REFERENCES employee(ssn),
	FOREIGN KEY (pno) REFERENCES project(pno)
);


INSERT ALL
--	INTO depertment(dno,dname,mgr_ssn,mgr_start_date) VALUES (1,'Accouunts','01AB123',TO_DATE('01/01/2021','dd/mm/yyyy'))
--	INTO depertment(dno,dname,mgr_ssn,mgr_start_date) VALUES (2,'Water Resorces','01AB143',TO_DATE('02/02/2021','dd/mm/yyyy'))
	INTO depertment(dno,dname,mgr_ssn,mgr_start_date) VALUES (3,'Production','01AB125',TO_DATE('03/03/2021','dd/mm/yyyy'))
	INTO depertment(dno,dname,mgr_ssn,mgr_start_date) VALUES (4,'Quality Assessment','01AB126',TO_DATE('01/01/2021','dd/mm/yyyy'))
	INTO depertment(dno,dname,mgr_ssn,mgr_start_date) VALUES (5,'Human Resorces','01AB127',TO_DATE('02/02/2021','dd/mm/yyyy'))
SELECT * FROM dual;

SELECT * FROM depertment;

INSERT ALL
	INTO employee (ssn, name, address, sex, salary, dno) values('01AB123','Indra','Indranagar','Male',40000,1)
	INTO employee (ssn, name, address, sex, salary, dno) values('01AB124','Varuna','Banshankari','Male',50000,1)
	INTO employee (ssn, name, address, sex, salary, dno) values('01AB125','Agni','Hebbal','Male',60000,2)
	INTO employee (ssn, name, address, sex, salary, dno) values('01AB126','Vaayu','Vijaynagar','Male',70000,3)
	INTO employee (ssn, name, address, sex, salary, dno) values('01AB127','Scott','Kuvempunaga','Male',80000,4)
SELECT * FROM dual;

SELECT * FROM employee;

INSERT ALL
	INTO dlocation (dno,dloc) VALUES (1,'Bengalru')
	INTO dlocation (dno,dloc) VALUES (2,'Pune')
	INTO dlocation (dno,dloc) VALUES (3,'Chennai')
	INTO dlocation (dno,dloc) VALUES (4,'Bengalru')
	INTO dlocation (dno,dloc) VALUES (5,'Mysuru')
SELECT * FROM dual;

SELECT  * FROM dlocation;

INSERT ALL
	INTO project (pno, pname, plocation, dno) values(501,'Market Evaluation','Dodballapura',1)
	INTO project (pno, pname, plocation, dno) values(502,'IOT','Andheri',2)
	INTO project (pno, pname, plocation, dno) values(503,'Product Optimization','Chennai',2)
	INTO project (pno, pname, plocation, dno) values(504,'Yeild Increase','Yelahanka',4)
	INTO project (pno, pname, plocation, dno) values(505,'Product Refinement','Kuvempunagar, Mysuru',5)
SELECT * FROM dual;

SELECT * FROM project;

INSERT ALL
	INTO works_on (ssn,pno,hours) VALUES ('01AB123',501,6)
	INTO works_on (ssn,pno,hours) VALUES ('01AB124',502,7)
	INTO works_on (ssn,pno,hours) VALUES ('01AB125',503,8)
	INTO works_on (ssn,pno,hours) VALUES ('01AB126',503,8)
	INTO works_on (ssn,pno,hours) VALUES ('01AB127',504,6)
SELECT * FROM dual;

SELECT  * FROM works_on;
SELECT * FROM project;
SELECT  * FROM dlocation;
SELECT * FROM depertment;
SELECT * FROM employee;

--a
		
SELECT DISTINCT P.PNO
FROM PROJECT P
JOIN WORKS_ON W ON P.PNO = W.PNO
JOIN EMPLOYEE E ON W.SSN = E.SSN
WHERE E.Name = 'Scott'
UNION
SELECT DISTINCT P.PNO
FROM PROJECT P
, depertment D 
, EMPLOYEE E
WHERE P.dno = D.dno
		AND D.mgr_ssn = E.ssn
		AND E.Name = 'Scott';
		
-- b
SELECT  salary + salary *0.1, e.*
FROM employee e
WHERE ssn in
			(
			SELECT  ssn
			FROM 	works_on
			WHERE pno=
						(		
						SELECT pno
						FROM 	project 
						WHERE 	pname = 'IOT'
						)
			)

-- c

SELECT  sum(e.salary), max(e.salary), min(e.salary), AVG(e.salary) 
FROM 	employee e,
		depertment d
WHERE 	e.dno = d.dno
		AND d.dname  = 'Accouunts';

--d
SELECT E.Name
FROM EMPLOYEE E
WHERE NOT EXISTS (
    SELECT P.PNO
    FROM PROJECT P
    WHERE P.DNO = 5
    MINUS
    SELECT W.PNO
    FROM WORKS_ON W
    WHERE W.SSN = E.SSN
);
		
--e
SELECT D.DNo, COUNT(E.SSN) AS high
FROM depertment D
JOIN EMPLOYEE E ON D.DNo = E.DNo
WHERE E.Salary > 600000
GROUP BY D.DNo
HAVING COUNT(E.SSN) > 5;  
