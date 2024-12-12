CREATE TABLE accounts(
	acc_number NUMBER PRIMARY KEY,
	acc_name varchar(50),
	acc_balance number
);

INSERT ALL
INTO accounts values(1001,'Niloy', 5000)
INTO accounts values(1002,'Suvo', 3000)
INTO accounts values(1003,'Tamim', 7000)
SELECT * FROM dual
;

SELECT  *
FROM	accounts;

UPDATE accounts
SET acc_balance = 2000
WHERE 	acc_number = 1001
;

DROP TRIGGER no_access;

CREATE OR REPLACE TRIGGER no_access_accounts
	  BEFORE
		    INSERT OR
		    UPDATE  OR
		    DELETE
	  ON accounts
	  FOR EACH ROW 
  	
DECLARE 

	v_current_day VARCHAR2(20);
	v_current_time VARCHAR2(20);
  
BEGIN
	
	
    SELECT TO_CHAR(SYSDATE, 'Day') 
   	INTO v_current_day 
   	FROM dual;
   
    SELECT TO_CHAR(SYSDATE, 'HH24:MI') 
   	INTO v_current_time 
   	FROM dual;

    IF TRIM(v_current_day) = 'Saturday' OR (v_current_time >= '17:00' AND v_current_time <= '22:00') THEN
        	RAISE_APPLICATION_ERROR(-20001, 'No operations allowed on Saturday or between 5 PM and 10 PM.');
    END IF;
	
END;
/