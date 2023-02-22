create table emp (emp_name varchar2(30),emp_no number,sal number);

insert into emp values('Nitesh',100,23000);
insert into emp values('Sarvesh',110,20000);
insert into emp values('Sam',111,23000);
insert into emp values('Purnima',130,15000);
insert into emp values('Tara',131,15000,10);

select * from emp;

alter table emp add dept_no number;

update emp set dept_no=10 where emp_no in (100,110);
update emp set dept_no=20 where emp_no in (130,111);