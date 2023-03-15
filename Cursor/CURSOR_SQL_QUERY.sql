/*SELECT * FROM V$OPEN_CURSOR;
SELECT * FROM V$PARAMETER WHERE NAME LIKE '%open_cursors%';

GET THE RUN TIME DETAILS OF CURSOR
CURSOR ATTRIBUTES ARE

ISOPEN      --RETURNS TRUE IF CURSOR IS OPEN,FALSE OTHERWISE.
FOUND       --RETURN TRUE IF RECORD WAS FETCHED SUCCESSFULLY ,FALSE OTHERWISE.
NOTFOUND    --RETURN TRUE IF RECORD WAS NOT FETCHED SUCCESSFULLY ,FALSE OTHERWISE.
ROWCOUNT    --RETURN NUMBER OF RECORDS FETCHED FROM CURSOR AT THAT POINT IN TIME.
*/

CLEAR SCREEN
SET SERVEROUTPUT ON;
DECLARE 
CURSOR EMP_NAME_CUR IS
SELECT EMP_NAME FROM EMP;

    V_NAME VARCHAR2(100);

BEGIN
    OPEN EMP_NAME_CUR;
    FETCH EMP_NAME_CUR INTO V_NAME;
    DBMS_OUTPUT.PUT_LINE('V_NAME:'||V_NAME);
    FETCH EMP_NAME_CUR INTO V_NAME;
    DBMS_OUTPUT.PUT_LINE('V_NAME:'||V_NAME);
    CLOSE EMP_NAME_CUR;
END;



CLEAR SCREEN
SET SERVEROUTPUT ON;
DECLARE 
CURSOR EMP_NAME_CUR_LIST IS
SELECT EMP_NAME FROM EMP;

    V_NAME VARCHAR2(100);

BEGIN
    OPEN EMP_NAME_CUR_LIST;
    FETCH EMP_NAME_CUR_LIST INTO V_NAME;
    DBMS_OUTPUT.PUT_LINE('V_NAME:'||V_NAME);
    FETCH EMP_NAME_CUR INTO V_NAME;
    DBMS_OUTPUT.PUT_LINE('V_NAME:'||V_NAME);
    CLOSE EMP_NAME_CUR;
END;


CLEAR SCREEN
SET SERVEROUTPUT ON;
DECLARE 
CURSOR EMP_NAME_CUR_LIST IS
SELECT EMP_NAME FROM EMP;

    V_NAME VARCHAR2(100);

BEGIN
    OPEN EMP_NAME_CUR_LIST;
    LOOP
        FETCH EMP_NAME_CUR_LIST INTO V_NAME;
        EXIT WHEN EMP_NAME_CUR_LIST%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('V_NAME:'||V_NAME);
    END LOOP;
    CLOSE EMP_NAME_CUR_LIST;
END;



CLEAR SCREEN;
SET SERVEROUTPUT ON;
DECLARE
CURSOR CUR_EMP_DET IS
SELECT EMP_NAME FROM EMP;
V_NAME VARCHAR2(100);

BEGIN
OPEN CUR_EMP_DET;
LOOP
    FETCH CUR_EMP_DET INTO V_NAME ;
    EXIT WHEN CUR_EMP_DET%NOTFOUND;
    --DBMS_OUTPUT.PUT_LINE('NAME OF EMPLOYEE IS:'|| V_NAME);
    --DBMS_OUTPUT.PUT_LINE('COUNT IS:'||CUR_EMP_DET%ROWCOUNT);
END LOOP;

    IF CUR_EMP_DET%ISOPEN THEN
       DBMS_OUTPUT.PUT_LINE('CURSOR IS OPEN'); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('CURSOR IS CLOSED'); 
    END IF;
CLOSE CUR_EMP_DET ;
END;


--FOR CURSOR IS USED WHEN WE NEDS TO WRITE CODE ONLY ONE MEANS NO REUSABLITIY REQUIRED
CLEAR SCREEN
SET SERVEROUTPUT ON
BEGIN
    FOR I IN (SELECT EMP_NAME FROM EMP)
    LOOP
        DBMS_OUTPUT.PUT_LINE(I.EMP_NAME);
        DBMS_OUTPUT.PUT_LINE(I.EMP_NAME || I.EMP_NO);
    END LOOP ;
END;