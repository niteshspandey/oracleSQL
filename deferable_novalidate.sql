/* 
DEFERRABLE NOVALIDATE
ADD CONSTRAINTS ON THE TABLE WITH EXISITNG DATA WHICH VIOLETES THE UNIQUE CONSTRAINT OR ANY TYPE OF CONSTRAINT.NEW DATA BEING INSERTED WILL COMPLY WITH THE UNIQUE CONSTRAINT.
*/



create table emp_nonvalidate_demo(emp_no number,emp_name varchar2(20));

insert into emp_nonvalidate_demo values(1,'Nitesh');
insert into emp_nonvalidate_demo values(1,'Sam');
insert into emp_nonvalidate_demo values(2,'Sarvesh');
insert into emp_nonvalidate_demo values(3,'Tara');
insert into emp_nonvalidate_demo values(4,'Purnima');
/


select * from emp_nonvalidate_demo;

alter table emp_nonvalidate_demo add constraint emp_no_pk primary key(emp_no); 
/*
02437. 00000 -  "cannot validate (%s.%s) - primary key violated"
*Cause:    attempted to validate a primary key with duplicate values or null
           values.
*Action:   remove the duplicates and null values before enabling a primary
           key.
*/

alter table emp_nonvalidate_demo add constraint emp_no_pk primary key(emp_no) deferrable novalidate; 
insert into emp_nonvalidate_demo values(1,'Pandey');--ORA-00001: unique constraint (SYS.EMP_NO_PK) violated
insert into emp_nonvalidate_demo values(7,'Ram');

select * from emp_nonvalidate_demo;
select * from emp_nonvalidate_demo where emp_no=1;
