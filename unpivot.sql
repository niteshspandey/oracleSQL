/*
Unpivot

to convert column value into row value we use unpivot method.
it takes 2 argument
cols name--name associate with specific columns.
cols value--value of namespecify in cols name coluns.


pivot
The PIVOT clause is new for Oracle Database 11g and enables you to flip the rows into columns in the output from a query, 
and, at the same time,allow you to run an aggregation function on the data

Pivot and unpivot relational operator are used to generate a multidimensional reporting.
Pivot table will contain three specific area mainly-rows,columns and values.

*/
select * from (select 'welcome' cols1,
        'to' cols2,
        'home' cols3,
        'nitesh' cols4
from dual)
unpivot(cols_val for columns_name in (cols1,cols2,cols3,cols4));

/*
i/p-
welcome	to	home	nitesh

o/p-
COLS1	welcome
COLS2	to
COLS3	home
COLS4	nitesh

*/


select 'welcome' cols1,
        'to' cols2,
        'home' cols3,
        'nitesh' cols4
from dual

select * from t_emp;
create table t_emp(emp_no varchar2(10),
emp_name varchar2(10),job varchar2(40));

insert into t_emp values('1','Nitesh','Executive');
insert into t_emp values('2','Sarvesh','Carpenter');
insert into t_emp values('3','Sam','Admin');
insert into t_emp values('4','Tara','Housewife');
insert into t_emp values('5','Purnima','Engineer');
insert into t_emp values('6','Arun','BigData');

select * from
(select emp_no,emp_name,job
from t_emp) unpivot (col_val for column_name in (emp_no,emp_name,job));

EMP_NO	        1
EMP_NAME	Nitesh
JOB	        Executive
EMP_NO	        2
EMP_NAME	Sarvesh
JOB	        Carpenter
EMP_NO	        3
EMP_NAME	Sam
JOB	        Admin
EMP_NO	        4
EMP_NAME	Tara
JOB	        Housewife
EMP_NO	        5
EMP_NAME	Purnima
JOB	        Engineer
EMP_NO	        6
EMP_NAME	Arun
JOB	        BigData



--Pivot
SELECT *
FROM (
  inner_query
)
PIVOT (
  aggregate_function FOR pivot_column IN (list_of_values)
)
ORDER BY…;
