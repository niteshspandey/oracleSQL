--EXXCEPTION
/*
ERROR THAT ARE RAISED DURING PROGRAM EXECUTION.
1. PREDEFINDED EXCEPTION(SYSTEM DEFIND)
    1.1 NAMED EXCEPTION (NO_DATA_FOUND,INVALID_NUMBER,TOO_MANY_ROWS,ZERO_DEVIDE,VALUE_ERROR)
    1.2 UN-NAMED EXCEPTION 
    
2. USER DEFINED EXCEPTION
    HANDLE USING RAISE KEYWORD
    HANDLE USING RAISE_APPLICATION_ERROR.
    --The raise_application_error is actually a procedure defined by Oracle that allows the 
      developer to raise an exception and associate an error number and message with the procedure.

PRAGMA EXCEPTION
IT IS USED TO GIVE NAME FOR UN NAMED EXCEPTION 

SQLERRM--RETURN ERROR MESSAGE ASSOCIATED WITH ITS ERROR NUMBER ARGUMENT.
SQLCODE--RETURN NUMBER CODE OF THE MOST EXCEPTION.
*/

CREATE OR REPLACE FUNCTION  FN_DIV(PIN1 NUMBER,PIN2 NUMBER)
RETURN NUMBER IS
LV_TEMP NUMBER;
BEGIN
RETURN PIN1/PIN2;
END;

SELECT * FROM USER_ERRORS;

SELECT FN_DIV(5,2) FROM DUAL;

CLEAR SCREEN
SET SERVEROUTPUT ON
BEGIN
DBMS_OUTPUT.PUT_LINE(FN_DIV(5,0)); --DIVISOR IS EQUAL TO ZERO
END;


CLEAR SCREEN
DECLARE
    V_EMP_DETAILS EMP%ROWTYPE;
BEGIN 
    SELECT * INTO V_EMP_DETAILS FROM EMP
    WHERE EMP_NO='131' ;--exact fetch returns more than requested number of rows

EXCEPTION 
    WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('--------MORE THEN ONE RECORD FOUND----------');
END;

SELECT * FROM EMP;

CLEAR SCREEN 
DECLARE
    V_EMP_DET EMP%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP_DET FROM EMP
    WHERE EMP_NO=160;
EXCEPTION 
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('-----NO RECORDS FOUND-------');
END;

CLEAR SCREEN
DECLARE 
    V1 NUMBER:=10;
    V2 NUMBER:=0;
    V_RESULT NUMBER;
    E_DENO_IS_ZERO EXCEPTION;
BEGIN
    IF V2=0 THEN
        RAISE E_DENO_IS_ZERO;
    ELSE
        V_RESULT:=V1/V2;
    END IF;
EXCEPTION WHEN E_DENO_IS_ZERO THEN
    DBMS_OUTPUT.PUT_LINE('DENOMINATOR MUST BE GREATER THAN ZERO');
END;


CLEAR SCREEN
SET SERVEROUTPUT ON
DECLARE 
    V1 NUMBER:=10;
    V2 NUMBER:=0;
    V_RESULT NUMBER;
    E_DENO_IS_ZERO EXCEPTION;
BEGIN
    IF V2=0 THEN
        RAISE_APPLICATION_ERROR(-20601,'DENOMINATOR MUST BE GREATER THAN ZERO');
    ELSE
        V_RESULT:=V1/V2;
    END IF;
END;

CLEAR SCREEN
SET SERVEROUTPUT ON
DECLARE
V_NUM NUMBER;
BEGIN 
    INSERT INTO EMP(EMP_NO) VALUES (999999999999999999999999999999999);
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR CODE IS '||SQLCODE);
    DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE IS '||SQLERRM);
END;


CLEAR SCREEN
SET SERVEROUTPUT ON
DECLARE
V_NUM NUMBER;
BEGIN 
    SELECT EMP_NO INTO V_NUM FROM EMP WHERE EMP_NO=1111 ;
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR CODE IS '||SQLCODE);
    DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE IS '||SQLERRM);
END;

SELECT * FROM EMP;