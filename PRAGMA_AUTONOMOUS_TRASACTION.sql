--PRAGMA AUTONOMOUS COMMAND
/*

IT IS A INDEPENDENT TRANSACTION STARTED BY ANOTHER TRANSACTION,
THE MAIN TRANSACTION.

IT DO SQL OPERATION AND COMMIT OR ROLLBACK ,WITHOUT COMMITING OR ROLLING BACK THE MAIN TRANSACTION.

IT IS A CHILD TRANSACTION STARTED FROM ANOTHER TRASACTION.
CHILD TRANSACTION IS INDEPENDENT OF MAIN TRANSACTION.
CHILD TRASACTION MUST END WITH COMMIT/ROLLBACK BEFORE RETURNING BACK TO MAIN TRANSACTION.


IN NORAML TRASACTION SCENERIO IS LIKE BELOW:
    1.COMMIT ENTIRE THING
    2.ROLLBACK ENTIRE THING
    3.ROLLBACK TO SPECIFIC SAVEPOINT

IN PRAGMA AUTONOMOUS TRASACTION WE CAN COMMIT SPECIFIC TRASACTION WITHIN MULTIPLE TRANSACTION
WHICH IS NOT POSSIBLE IN NORMAL TRANSACTION.

APPLICATION OF PRAGMA AUTONOMOUS TRANSACTION
1.ERROR LOGGING.
2.COMMIT INSIDE TRIGGER.
3.CALLING A FUNCTION HAVING 'DML STATEMENT' IN SELECT STATEMENT.

*/
DROP TABLE T;

CREATE TABLE T (N NUMBER);

INSERT INTO T VALUES(1);
DECLARE 
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO T VALUES(2);
    COMMIT;
END;

INSERT INTO T VALUES(3);
ROLLBACK;


SELECT * FROM T;


create or replace FUNCTION func_ddl_demo RETURN NUMBER AS
BEGIN
    create table temp (
        id NUMBER
    );
RETURN 1;

end;
/

--DDL using dynamic query(still getting error)
create or replace function func_ddl_demo2 return number as
begin
    execute immediate 'create table temp(id number)';
    return 1;
end;

select func_ddl_demo2 from dual; 
/* cannot perform a DDL, commit or rollback inside a query */

--Autonomous transaction with dynamic query
create or replace function func_ddl_autonomous_dynamic_query return number as 
pragma autonomous_transaction;
begin
    execute immediate 'create table temp(id number)';
    --execute immediate 'drop table temp';
    return 1;
end;
/

select func_ddl_autonomous_dynamic_query from dual;
select * from temp;--table created 


---------------------------------------------------------------------------------

--function without DDL or DML
CREATE OR REPLACE FUNCTION fn_without_ddl_dml RETURN NUMBER AS
BEGIN
    RETURN 1;
END;
/
SELECT
    fn_without_ddl_dml
FROM
    dual;
    
--Create temporary table
CREATE TABLE t_dml_operation_function_demo (
    id   NUMBER,
    name VARCHAR2(100)
);

INSERT INTO t_dml_operation_function_demo VALUES (
    1,
    'A'
);

INSERT INTO t_dml_operation_function_demo VALUES (
    2,
    'B'
);


select * from t_dml_operation_function_demo;

CREATE OR REPLACE FUNCTION fun_dml_demo RETURN NUMBER AS
BEGIN
    UPDATE t_dml_operation_function_demo
    SET
        name = 'Nitesh'
    WHERE
        id = 2;

    RETURN 1;
END;

SELECT
    fun_dml_demo
FROM
    dual;
/*
cannot perform a DML operation inside a query
*/


----DML can be performed using autonomous transaction in function
CREATE OR REPLACE FUNCTION func_dml_autonomous_trans RETURN NUMBER AS
    PRAGMA autonomous_transaction;
BEGIN
    UPDATE t_dml_operation_function_demo
    SET
        name = 'Nitesh'
    WHERE
        id = 2;

    COMMIT;
    RETURN 1;
END;
/

select func_dml_autonomous_trans from dual; --executed properly without any error
select * from t_dml_operation_function_demo;
/*
1	A
2	Nitesh
*/
