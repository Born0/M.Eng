CREATE  TABLE employee_bak(
	ssn varchar(10) ,
	name varchar(20),
	address  varchar(25),
	op_date DATE,
	op_type varchar(50)
);

SELECT  * FROM employee_bak;



CREATE OR REPLACE TRIGGER employee_trigg
AFTER UPDATE OR DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF UPDATING THEN
        INSERT INTO employee_bak (SSN, Name, Address, op_date, op_type)
        VALUES (:OLD.SSN, :OLD.Name, :OLD.Address, SYSDATE, 'UPDATE');
    ELSIF DELETING THEN
        INSERT INTO employee_bak (SSN, Name, Address, op_date, op_type)
        VALUES (:OLD.SSN, :OLD.Name, :OLD.Address, SYSDATE, 'DELETE');
    END IF;
END;
/