/*
create table emp (emp_name varchar2(30),emp_no number,sal number);

insert into emp values('Nitesh',100,23000);
insert into emp values('Sarvesh',110,20000);
insert into emp values('Sam',111,23000);
insert into emp values('Purnima',130,15000);

select * from emp;

alter table emp add dept_no number;

update emp set dept_no=10 where emp_no in (100,110);
update emp set dept_no=20 where emp_no in (130,111);

*/

---Procedure Example
create or replace PROCEDURE UPDT_SAL_EMP (
pin_empno IN NUMBER,
pin_pct_inc IN NUMBER,
pout_new_sal OUT NUMBER
) as
BEGIN 
--    IF pin_empno is null then 
--    RETURN
--    END ;
    
    UPDATE emp
    SET
    sal = sal + ( sal * pin_pct_inc / 100 )
WHERE
    emp_no = pin_empno 
RETURNING sal INTO pout_new_sal ;
END UPDT_SAL_EMP ;

--Calling procedure
DECLARE
    emp_no NUMBER := 131; -- Provide the employee number
    per_sal NUMBER := 10; -- Provide the percentage increase
    updated_sal NUMBER;
BEGIN
    UPDT_SAL_EMP(emp_no, per_sal, updated_sal);
    DBMS_OUTPUT.PUT_LINE('Updated Salary: ' || updated_sal);
END;

--To check the updated values
select * from t_emp_det where emp_no=131;

--Return Keyword in procedure
set serveroutput on
begin
    dbms_output.put_line('Printing--1');
    return;
    dbms_output.put_line('Printing--2');
end;

/* output
Printing--1
PL/SQL procedure successfully completed.
*/

-----Function----------------
CREATE OR REPLACE FUNCTION func_add (
    pin1 NUMBER,
    pin2 NUMBER
) RETURN NUMBER AS
    lv_sum NUMBER;
BEGIN
    lv_sum := pin1 + pin2;
    RETURN lv_sum;
END;
/
    
select func_add(5,5) from dual;--10
