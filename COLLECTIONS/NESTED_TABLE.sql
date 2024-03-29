--NESTED TABLE
/*

AN ARRAY HAS A DECLARED FIXED NUMBER OF ELEMENTS BUT A NESTED TABLE DOES NOT.
THE SIZE OF NESTED TABLE CAN INCREASE DYNAMICALLY.

AN ARRAY IS ALWAYS DENSE.A NESTED ARRAY IS DENSE INITIALLY.BUT IT CAN BECOME SPARSE,BECAUSE
YOU CAN DELETE ELEMENT FROM IT.

A NESTED TABLE IS APPROPRIATE WHEN:
1.THE NUMBER OF ELEMENTS IS NOT SET
2.INDEX VALUE ARE NOT CONSECUTIVE.
3.YOU MUST DELETE OR UPDATE SOME ELEMENT BUT NOT ALL ELEMENT SIMULTANEOUSLY.
*/




CLEAR SCREEN
SET SERVEROUTPUT ON
DECLARE
TYPE V_DAY_DET IS TABLE OF VARCHAR2(30);
V_DAY V_DAY_DET :=V_DAY_DET(NULL,NULL);

BEGIN

V_DAY(1):='MONDAY';
V_DAY(2):='TUESDAY';
--V_DAY.DELETE;
DBMS_OUTPUT.PUT_LINE('DAY 1 IS ' ||V_DAY(1));
--DBMS_OUTPUT.PUT_LINE('DAY FUNCTION IS ' ||V_DAY.LAST);

END;

/*
FUNCTION USED IN NESTED TABLE
LIMIT
FIRST
LAST
COUNT
TRIM
DELETE
PRIOR
NEXT
EXIST
*/


--VARRAY

CLEAR SCREEN
SET SERVEROUTPUT ON
DECLARE
    TYPE DAY_WEEK_DET IS VARRAY(7) OF VARCHAR2(30);
    V_ARR_VAL DAY_WEEK_DET:=DAY_WEEK_DET(NULL,NULL,NULL);

BEGIN
    V_ARR_VAL(1):='NITESH';
    V_ARR_VAL(2):='NITESH2';
    V_ARR_VAL(3):='NITESH3';
    
    DBMS_OUTPUT.PUT_LINE('FIRST VALUE IS:'||V_ARR_VAL(1));
    DBMS_OUTPUT.PUT_LINE('THIRD VALUE IS:'||V_ARR_VAL(3));
    DBMS_OUTPUT.PUT_LINE('SECOND VALUE IS:'||V_ARR_VAL(2));
END;
