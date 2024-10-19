-- Create meve_person table
CREATE TABLE meve_person (
    nid NUMBER(10) PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    address VARCHAR2(200)
);

-- Create meve_car table
CREATE TABLE meve_car (
    license VARCHAR2(20) PRIMARY KEY,
    year NUMBER(4) NOT NULL,
    model VARCHAR2(50) NOT NULL
);

-- Create meve_accident table
CREATE TABLE meve_accident (
    adate DATE,
    driver VARCHAR2(100),
    damage_amount NUMBER(10,2) NOT NULL,
    PRIMARY KEY (adate, driver)
    --,FOREIGN KEY (driver) REFERENCES meve_person(name)
);

-- Create meve_owns table
CREATE TABLE meve_owns (
    nid NUMBER(10),
    license VARCHAR2(20),
    PRIMARY KEY (nid, license),
    FOREIGN KEY (nid) REFERENCES meve_person(nid),
    FOREIGN KEY (license) REFERENCES meve_car(license)
);

-- Create meve_log table
CREATE TABLE meve_log (
    license VARCHAR2(20),
    adate DATE,
    driver VARCHAR2(100),
    PRIMARY KEY (license, adate, driver),
    FOREIGN KEY (license) REFERENCES meve_car(license),
    --FOREIGN KEY (driver) REFERENCES meve_person(name),
    FOREIGN KEY (adate, driver) REFERENCES meve_accident(adate, driver)
);




-- Insert data into meve_Person
INSERT ALL
    INTO meve_Person (nid, name, address) VALUES (123451, 'Arif', 'Rajshahi')
    INTO meve_Person (nid, name, address) VALUES (123452, 'Sumon', 'Moynamati')
    INTO meve_Person (nid, name, address) VALUES (123453, 'Sagor', 'Sirajgang')
    INTO meve_Person (nid, name, address) VALUES (123454, 'Abdul', 'Rajshahi')
    INTO meve_Person (nid, name, address) VALUES (123455, 'Himesh', 'Dhaka')
    INTO meve_Person (nid, name, address) VALUES (123456, 'Amirul', 'Sylhet')
    INTO meve_Person (nid, name, address) VALUES (123457, 'Sajib', 'Chittagang')
SELECT * FROM dual;

-- Insert data into meve_Car
INSERT ALL
    INTO meve_Car (license, year, model) VALUES ('12-3000', 2012, 'Axio')
    INTO meve_Car (license, year, model) VALUES ('11-3000', 2008, 'Corolla')
    INTO meve_Car (license, year, model) VALUES ('12-4000', 2013, 'Axio')
    INTO meve_Car (license, year, model) VALUES ('12-5000', 2013, 'Premio')
    INTO meve_Car (license, year, model) VALUES ('11-5000', 2010, 'Nano')
    INTO meve_Car (license, year, model) VALUES ('11-6000', 2011, 'Alto')
    INTO meve_Car (license, year, model) VALUES ('12-6000', 2015, 'Nano Twist')
SELECT * FROM dual;

ALTER TABLE meve_accident
MODIFY driver VARCHAR(100);

-- Insert data into meve_accident
INSERT ALL
    INTO meve_accident (adate, driver, damage_amount) VALUES (TO_DATE('12/01/2013', 'DD/MM/YYYY'), 'Arif', 10000)
    INTO meve_accident (adate, driver, damage_amount) VALUES (TO_DATE('25/09/2015', 'DD/MM/YYYY'), 'Sumon', 12000)
    INTO meve_accident (adate, driver, damage_amount) VALUES (TO_DATE('20/06/2014', 'DD/MM/YYYY'), 'Sagor', 11000)
    INTO meve_accident (adate, driver, damage_amount) VALUES (TO_DATE('20/12/2011', 'DD/MM/YYYY'), 'Abdul', 8000)
    INTO meve_accident (adate, driver, damage_amount) VALUES (TO_DATE('19/09/2015', 'DD/MM/YYYY'), 'Himesh', 7000)
    INTO meve_accident (adate, driver, damage_amount) VALUES (TO_DATE('15/05/2013', 'DD/MM/YYYY'), 'Amirul', 20000)
    INTO meve_accident (adate, driver, damage_amount) VALUES (TO_DATE('20/08/2014', 'DD/MM/YYYY'), 'Sajib', 15000)
SELECT * FROM dual;

-- Insert data into meve_owns
INSERT ALL
    INTO meve_owns (nid, license) VALUES (123451, '11-3000')
    INTO meve_owns (nid, license) VALUES (123452, '12-4000')
    INTO meve_owns (nid, license) VALUES (123453, '12-5000')
    INTO meve_owns (nid, license) VALUES (123454, '11-5000')
    INTO meve_owns (nid, license) VALUES (123455, '11-6000')
    INTO meve_owns (nid, license) VALUES (123456, '12-6000')
    INTO meve_owns (nid, license) VALUES (123457, '12-3000')
SELECT * FROM dual;

SELECT *
FROM meve_accident

DROP TABLE meve_log;

-- Insert data into meve_Log
INSERT ALL
    INTO meve_Log (license, adate, driver) VALUES ('11-3000', TO_DATE('12/01/2013', 'DD/MM/YYYY'), 'Arif')
    INTO meve_Log (license, adate, driver) VALUES ('12-4000', TO_DATE('25/09/2015', 'DD/MM/YYYY'), 'Komol')
    INTO meve_Log (license, adate, driver) VALUES ('11-6000', TO_DATE('20/06/2014', 'DD/MM/YYYY'), 'Bahadur')
    INTO meve_Log (license, adate, driver) VALUES ('11-5000', TO_DATE('20/12/2011', 'DD/MM/YYYY'), 'Abdul')
    INTO meve_Log (license, adate, driver) VALUES ('12-6000', TO_DATE('19/09/2015', 'DD/MM/YYYY'), 'Akter')
    INTO meve_Log (license, adate, driver) VALUES ('11-3000', TO_DATE('15/05/2013', 'DD/MM/YYYY'), 'Arif')
    INTO meve_Log (license, adate, driver) VALUES ('11-3000', TO_DATE('20/08/2014', 'DD/MM/YYYY'), 'Arif')
SELECT * FROM dual;


meve_person (nid, name, address) 	
meve_car (license, year, model)	
meve_accident (adate, driver, damage-amount)	
meve_owns (nid, license)	
meve_log (license, adate, driver)



----------
--b
SELECT 	name
FROM 	meve_person
WHERE 	address = 'Rajshahi'
;

--c
SELECT *
FROM  	meve_car
WHERE 	YEAR = 2013
;

--d
SELECT DRIVER 
FROM 	meve_accident;
		AND a.damage_amount >= 10000
		AND a.damage_amount <= 15000
	;

--d using join
SELECT p.*,a.*
FROM 	meve_person p,
		meve_accident a
WHERE 	p.name = a.driver
		AND a.damage_amount >= 10000
		AND a.damage_amount <= 15000
;

--e
SELECT w.NID 
FROM 	meve_car c,
		meve_owns w
WHERE 	c.LICENSE = w.LICENSE 
		AND c.MODEL = 'Axio'
		;

-- f
SELECT p.NID , p.ADDRESS 
FROM 	meve_person p
		LEFT JOIN meve_owns w
		ON p.NID = w.NID 
			LEFT JOIN 	meve_car C
			ON w.LICENSE = c.LICENSE 
WHERE 	c.MODEL = 'Alto'

--g
SELECT 	DRIVER 
FROM 	meve_log
WHERE 	ADATE <= TO_DATE('20/12/2011', 'DD/MM/YYYY') 
;

--h
SELECT p.* 
FROM 	meve_person p
		LEFT JOIN meve_owns w
		ON p.NID = w.NID 
WHERE 	w.LICENSE = '12-4000'
;

--i
SELECT p.NAME 
FROM 	meve_person p
		LEFT JOIN meve_owns W
		ON  p.NID = w.NID 
			LEFT JOIN meve_log l
			ON l.LICENSE = w.LICENSE 
WHERE 	l.DRIVER = 'Arif'
;
	
to_lower(adress) = 'rajshai'

--j
SELECT 	MODEL 
FROM 	meve_car c
		LEFT JOIN meve_log l
		ON l.LICENSE = c.LICENSE 
WHERE 	ADATE <= TO_DATE('19/09/2015', 'DD/MM/YYYY') 
;

--k
SELECT 	Count(*)
FROM 	meve_accident
WHERE 	DRIVER = 'Arif'
;
-- l
SELECT  ADATE 
FROM 	meve_log 
WHERE 	DRIVER = 'Arif'
;

--m
--UPDATE 	meve_person 
SET 	ADDRESS= 'Natore' 
WHERE 	name = 'Arif'

SELECT *
FROM 	meve_person