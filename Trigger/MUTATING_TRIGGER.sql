--MUTATING TRIGGER
/*
MUTATING ERROR OCCURS WHENEVER A ROW LEVEL TRIGGER TRIES TO MODIFY OR SELECT DATA FROM THE TABLE THAT IS ALREADY UNDERGOING CHANGES.
MUTATING ERROR GET RAISED FROM ROW LEVEL TRIGGER ONLY,AND NOT STATEMENT LEVEL TRIGGER.

SELECT * FROM USER_TRIGGER;---CHECK CREATE TRIGGER

SOLUTION
1.  CREATE STATEMENT LEVEL TRIGGER FOR DML QUERY.
    ASSIGN VARIABLE IN PACKAGE.
    FETCH THE VARIABLE IN ROW LEVEL TRIGGER.

2.  AVOID USING COMPOUND TRIGGER.
*/

CREATE TABLE EMP(EMP_NAME VARCHAR2(20),DESIGN VARCHAR2(20),SALARY NUMBER);

INSERT INTO EMP VALUES('NITESH','CEO',150000);
INSERT INTO EMP VALUES('SARVESH','CFO',80000);
INSERT INTO EMP VALUES('BHAVESH','DEVELOPER',65000);
INSERT INTO EMP VALUES('ROHIT','TESTER',25000);
INSERT INTO EMP VALUES('SHIDDESH','QA',40000);

SELECT * FROM EMP;

CREATE TABLE EMP_SAL_LOG(EMP_NAME VARCHAR2(30),REMARK VARCHAR2(1000));

SELECT * FROM EMP;

--CREATE TABLE EMP_SAL_LOG(EMP_NO NUMBER,UPDATE_LOG VARCHAR2(255));

CREATE OR REPLACE TRIGGER TR_EMP_LOG_DET 
BEFORE UPDATE OF SAL ON EMP
FOR EACH ROW
DECLARE
LV_CEO_SALARY NUMBER;
--LV_MAX_SAL NUMBER:=100000;
BEGIN
    SELECT SAL INTO LV_CEO_SALARY FROM EMP
    WHERE JOBS='CEO'
    AND DEPT_NO=:NEW.DEPT_NO;--MUTATING ERROR CONCEPT
    
    IF :NEW.SAL <LV_MAX_SAL THEN
        INSERT INTO EMP_SAL_LOG VALUES(:NEW.EMP_NO,'SALARY UPDATED SUCCESSFULLY:' || 'OLD SAL= '||:OLD.SAL||',NEW SAL='||:NEW.SAL);
    ELSE
        :NEW.SAL:=:OLD.SAL;
        INSERT INTO EMP_SAL_LOG VALUES(:NEW.EMP_NO,'SALARY NOT UPDATED SUCCESSFULLY: EMPLOYEE SALARY CAN NOT BE MORE THAN' || LV_MAX_SAL);
    END IF;
END;
        
INSERT INTO EMP VALUES('Samnit1',111,230890,10);
SELECT * FROM EMP_SAL_LOG;
SELECT * FROM EMP;

UPDATE EMP SET SAL=123456 WHERE EMP_NAME='Tara';

-----SOLUTION TO RESOLVE THE MUTATING ERROR

CREATE OR REPLACE PACKAGE LV_STORE_PKG AS
    LV_CEO_SAL NUMBER;
END;
/

CREATE OR REPLACE TRIGGER TRIG_EMP_SAL_DATA 
BEFORE UPDATE OF SALARY ON EMP 
DECLARE 
    LV_MAX_SAL NUMBER;
BEGIN
    SELECT SALARY INTO LV_STORE_PKG.LV_CEO_SAL FROM EMP
    WHERE DESIGN='CEO';
END;
/

CREATE OR REPLACE TRIGGER TRIG_EMP_SAL_VAL
BEFORE UPDATE OF SALARY ON EMP
FOR EACH ROW
DECLARE
BEGIN
        IF (:NEW.SALARY <LV_STORE_PKG.LV_CEO_SAL  AND :OLD.DESIGN<>'CEO') OR (:OLD.DESIGN='CEO') THEN
        INSERT INTO EMP_SAL_LOG VALUES(:NEW.EMP_NAME,'SALARY UPDATED SUCCESSFULLY:' || 'OLD SAL= '||:OLD.SALARY||',NEW SAL='||:NEW.SALARY);
        
        ELSE
        :NEW.SALARY:=OLD.SALARY;
        INSERT INTO EMP_SAL_LOG VALUES(:NEW.EMP_NAME,'SALARY NOT UPDATED:EMPLOYEE SALARY CAN NOT BE MORE THEN CEO SALARY'||LV_STORE_PKG.LV_CEO_SAL);
        END IF;

END;
    
