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