--cumulative sum of salary based on department number
select e.*,
    sum(sal) over(partition by dept_no order by emp_no ) cum_sal1, 
    sum(sal) over(partition by dept_no order by emp_no rows between unbounded preceding and current row ) cum_sal2
from emp e;

--column level vs table level constraint
--column level constraint
create table stud(
regno number unique,
name varchar2(30),
rollno number,
dept varchar2(30))

--table level constraint
create table stud(
regno number ,
name varchar2(30),
rollno number,
dept varchar2(30)
--constraint u1 unique(regno,rollno),
constraint u1 unique(regno));

--why we use select 1 with query 
--return the value mention in select same as length of table mention in query
select 'abc' from emp;
select 1 from emp;


--Type of pragma
/*
pragma is an instruction to the compiler that is processes at compile time.
autonous _transaction
coverage
deprecate
exception_init
inline
restrict_references
serially_reusable
udf
*/



---mask the character or number except last 4 digit or character
--does not work well when there is length of digit is less then 4
with data as
(
select 1111222233334444 d from dual)
select 
--substr(d,1,length(d)-4),
lpad('X',length(d)-4,'X')||substr(d,-4) details
from data;

--work well in every situation
with data as
(
select 114444 d from dual)
select 
--substr(d,1,length(d)-4),
lpad('X',length(d)-4,'X')||substr(d,case when length(d)<=4 then 1 else -4 end) details
from data;

--methd 2 using regex
with data as
(
select 11444411 d from dual)
select 
    regexp_replace(substr(d,1,length(d)-4),'[^.]','X')|| 
    substr(d,case when length(d)<=4 then 1 else -4 end) details
from data;

/*
update value 1 to 0 and 0 to 1 in the given table
*/
drop table t;
create table t(c number);
insert into t values(1);
insert into t values(0);
insert into t values(1);
insert into t values(0);
insert into t values(1);
insert into t values(0);
insert into t values(1);
insert into t values(0);
insert into t values(1);

select * from t;
update t set c=abs(c-1) ;
update t set c=1-c ;
update t set c=(c-1)*-1;
update t set c=decode(c,1,0,0,1);
update t set c=(case c when 0 then 1 
                       when 1 then 0 end );
                       
                       
                       
--select alternate record from table 
select * from ( 
select rownum r,e.* from emp e order by 1) where mod(r,2)=0;


-----find unique travel fair from respective source and destination.
create table travels
(src varchar2(10),dest varchar2(10),fair number);

insert into travels values('MUM','CHN',500);
insert into travels values('CHN','MUM',500);
insert into travels values('HYB','MUM',500);
insert into travels values('MUM','HYB',500);
insert into travels values('MUM','PUN',1500);

select distinct least(src,dest),
greatest(src,dest),fair
from travels;
/*
CHN	MUM	500
MUM	PUN	1500
HYB	MUM	500
*/

---what is private procedure?how to access private procedure/function??
--we never create procedure if it is declare in package specification
-- we can declare the procedure as private in package body only and it is accessible by the procedure of same package.

create or replace package test_pkg1 as
 procedure proc_p1;
 procedure proc_p2;
end;

create or replace package body test_pkg1 as
    procedure priv_proc as 
    begin
        dbms_output.put_line('Private procedure');
    end;
    procedure proc_p1 as 
    begin
        dbms_output.put_line('first procedure');
        priv_proc;
    end;
    
    procedure proc_p2 as 
    begin
        dbms_output.put_line('second procedure');
    end;
end;

set serveroutput on
exec test_pkg1.priv_proc;--error occured because we cant access private procedure directly.

------------------------------
create table dummy
(name varchar2(20));

insert into dummy values ('Nitesh');
insert into dummy values ('*[Nitesh');
insert into dummy values ('[Nitesh]');
insert into dummy values ('sam...');
insert into dummy values ('jhon');
insert into dummy values ('[bob]');

select name from (
select name,count(*) over(partition by lower(regexp_replace(name,'[^a-zA-z0-9]',''))) result from dummy)
where result>1 order by 1;


-------------type of procedure----------
/*
Stored procedure
Standalone procedure
Local Procedure
Packaged procedure
Public procedure
Private procedure
One tiem only procedure
*/

--stored  procedure
--plsql component(pprocedure,function,package) stored in the database is collectively called as stored procedure.

--Standalone 
--only one object with mention name is called standalone procedure.
--it can be create by using replace or create keyword 
--example shown as below.
create or replace procedure proc_name(pin number) as
begin
update emp set sal=100
where dept_no=1234
end;

--packaged procedure
create or replace package pkg1 as
    procedure pkg_proc_1 ;
    procedure pkg_proc_2;
end;

create or replace package body pkg1 as
    procedure pkg_proc_1 as
    begin
    dbms_output.put_line('Procedure 1');
    end ;

    procedure pkg_proc_2 as
    begin
    dbms_output.put_line('Procedure 2');
    end ;
end;


--local procedure
--write inside the declaration part of any pl sql component

set serverout on
declare
    procedure my_proc1 as
    begin
        dbms_output.put_line('***printing my procedure *****')
    end;
begin
    my_proc1;
end;

--one time only procedure
create or replace package my_pkg as
    lv_num_of_emp number;
    procedure print;
end my_pkg ;

create or replace package body my_pkg as
procedure print
as
begin
dbms_output.put_line('lv_num_of_emp:='|| lv_num_of_emp);
end print;
begin
    select count(*) into lv_num_of_emp from emp
end my_pkg;

--reorder the column name of already created table using invicible
select table_name,
column_name,
column_id
from user_tab_columns
where table_name='EMP';

alter table emp modify emp_address invisible;
alter table emp modify emp_address visible;

--check the metadata of mention table
select 
sys.dbms_metadata.get_ddl('table','emp') 
from dual;

--find the dubplicate values from travels table

select * from travels;
/*
MUM	CHN	500
CHN	MUM	500
HYB	MUM	500
MUM	HYB	500
MUM	PUN	1500
*/

select least(src,dest) city1 ,
greatest(src,dest) city2 ,
fair --count(*)
from travels group by least(src,dest),greatest(src,dest),fair having count(*)>1;
/*
CHN	MUM	500
HYB	MUM	500
*/

--use of with clause
--it is called as common table expression(CTE) 
--it is temporary table it help to reduce complexity of code.

with data as
(select 'welcome' d from dual)
select substr(d,level),
       substr(d,1,level),
       substr(d,level,1) from data 
connect by level<=length(d);
/*

welcome	  w	        w
elcome	  we	    e
lcome	  wel	    l
come	  welc	    c
ome	      welco	    o
me	      welcom	m
e	      welcome	e
*/


----get the diagonal data from metrix(work well for only 3 rows)
drop table t;
create table t(c1 number ,c2 number ,c3 number);
insert into t values(10,20,30);
insert into t values(40,50,60);
insert into t values(70,80,90);


SELECT
    decode(ROWNUM, 1, c1)
    || decode(ROWNUM, 2, c2)
    || decode(ROWNUM, 3, c3) AS daigonal_element
FROM
    t;
/*
10
50
90
*/

SELECT
    decode(ROWNUM, 1, c1, 0) + 
    decode(ROWNUM, 2, c2, 0) + 
    decode(ROWNUM, 3, c3, 0) diagonal_elelemt
FROM
    t;

/*
10
50
90
*/

SELECT
    decode(ROWNUM, 1, c1, 2, c2,
           3, c3) AS diagonal_element
FROM
    t;

/*
10
50
90
*/


    
SELECT
    CASE
        WHEN ROWNUM = 1 THEN c1
        WHEN ROWNUM = 2 THEN c2
        WHEN ROWNUM = 3 THEN c3
    END daigonal_elelemt
FROM
    t;
/*
10
50
90
*/

--more then 3 rows
insert into t values(1,2,3);
insert into t values(4,5,6);
insert into t values(7,8,9);

select 
        decode(mod(rownum,3),1,c1,2,c2,0,c3) daigonal_element
        from t;

/*
10
50
90
1
5
9
*/

--
drop table t;
create table t
(c1 varchar2(10),c2 varchar2(10),c3 varchar2(10),c4 varchar2(10),c5 varchar2(10),c6 varchar2(10));

insert into t values('A1','A2','A3','A4','A5','A6');
insert into t values('B1','B2','B3','B4','B5','B6');
insert into t values('C1','C2','C3','C4','C5','C6');

COMMIT;

select 
max(decode(rownum,1,c1)) c1,
max(decode(rownum,1,c2)) c2,
max(decode(rownum,2,c3)) c3,
max(decode(rownum,2,c4)) c4,
max(decode(rownum,3,c5)) c5,
max(decode(rownum,3,c6)) c6
from t;
/*
A1	A2	B3	B4	C5	C6
*/

select max(decode(mod(rownum,3),1,c1)) c1,
       max(decode(mod(rownum,3),1,c2)) c2,
       max(decode(mod(rownum,3),2,c3)) c3,
       max(decode(mod(rownum,3),2,c4)) c4,
       max(decode(mod(rownum,3),0,c5)) c5,
       max(decode(mod(rownum,3),0,c6)) c6
from t group by ceil(rownum/3);
/*
A1	A2	B3	B4	C5	C6
*/
--

insert into t values('D1','D2','D3','D4','D5','D6');
insert into t values('E1','E2','E3','E4','E5','E6');
insert into t values('F1','F2','F3','F4','F5','F6');

select * from t;

select 
max(decode(mod(rownum,3),1,c1)) c1,
max(decode(mod(rownum,3),1,c2)) c2,
max(decode(mod(rownum,3),2,c3)) c3,
max(decode(mod(rownum,3),2,c4)) c4,
max(decode(mod(rownum,3),0,c5)) c5,
max(decode(mod(rownum,3),0,c6)) c6
from t group by ceil(rownum/3); 
/*
A1	A2	B3	B4	C5	C6
D1	D2	E3	E4	F5	F6
*/


select listagg(level*3,',') within group (order by rownum desc)from dual connect by level<=100/3;
/*
99,96,93,90,87,84,81,78,75,72,69,66,63,60,57,54,51,48,45,42,39,36,33,30,27,24,21,18,15,12,9,6,3
*/

select listagg(r,',') within group (order by r desc)from
(select level r from dual connect by level<=100) where mod(r,3)=0 ;
/* 3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,60,63,66,69,72,75,78,81,84,87,90,93,96,99 */
--pivot example

create table stud_marks
(sname varchar2(10),marks1 number,marks2 number,marks3 number);

insert into stud_marks values('nitesh',50,60,70);
insert into stud_marks values('sam',70,60,90);

select * from stud_marks 
unpivot 
(mark for column_name in (marks1,marks2,marks3));

/*
nitesh	MARKS1	50
nitesh	MARKS2	60
nitesh	MARKS3	70
sam	    MARKS1	70
sam	    MARKS2	60
sam	    MARKS3	90   
*/

--------
create table stud_subject
(student varchar2(10),
stud_subject varchar2(20));

insert into stud_subject values ('A','Science');
insert into stud_subject values ('A','Math');
insert into stud_subject values ('A','Eng');
insert into stud_subject values ('B','Science');
insert into stud_subject values ('B','Math');
insert into stud_subject values ('B','Eng');
insert into stud_subject values ('C','Math');

select Science,Math,Eng from  
(select student,stud_subject,student grp from stud_subject) 
pivot (max(student) for stud_subject in ('Science','Math','Eng'));

--------

drop table t;
create table t (c varchar2(30));

insert into t values(1);
insert into t values(1234);
insert into t values('nitesh');
insert into t values('sds');
insert into t values('a.b.c');
insert into t values('test');
insert into t values(100);
insert into t values(7);

select * from t;
/*
1
1234
nitesh
sds
a.b.c
test
100
7
*/

select * from t where not REGEXP_LIKE (c,'^[a-zA-Z]');
/*
1
1234
100
7
*/

select * from t where  REGEXP_LIKE (c,'^[a-zA-Z]');
/*
nitesh
sds
a.b.c
test
*/

select c from t 
where cast(c as number default -999 on conversion error)=1
union all
select c from t 
where cast(c as number default -999 on conversion error)=-999;

/*
1
nitesh
sds
a.b.c
test
*/
--
select * from t;
drop table t;
create table t (c number);
insert into t values(1);
insert into t values(2);
insert into t values(3);
insert into t values(4);

select * from t
union all
select * from t order by 1 asc;
/*
1
1
2
2
3
3
4
4
*/

select c from t,
(select level from dual connect by level<=2) order by 1 asc;

/*
1
1
2
2
3
3
4
4
*/

---find parent id who have only one male and female child

 create table family(parent_id number,child varchar2(30));
 
 insert into family values(1,'Male'); 
 insert into family values(1,'Male');
 insert into family values(1,'Female');
 insert into family values(2,'Female');
 insert into family values(3,'Female');
 insert into family values(3,'Male');
 insert into family values(4,'Female');
 insert into family values(5,'Male');
  insert into family values(5,'Female');
insert into family values(5,'Male');
insert into family values(7,'Male');
insert into family values(6,'Female');
insert into family values(6,'Male');

--method 1
select  parent_id,
        count(case when child='Male' then 1 end) M,
        count(case when child='Female' then 1 end) F
from family
group by parent_id
having count(case when child='Male' then 1 end)=1 and
       count(case when child='Female' then 1 end)=1
order by 1;
/*
3	1	1
6	1	1
*/


--method2
select distinct parent_id from (
select parent_id,child,count(*) over (partition by parent_id) c,
count(case when child='Male' then 1 end) over (partition by parent_id) M,
count(case when child='Female' then 1 end) over (partition by parent_id) F
from family) where m=1 and f=1;
/*
3
6
*/

--method3
select m.parent_id from (select parent_id,count(*) from family where 
child='Male' group by parent_id
having count(*)=1)M,
(select parent_id,count(*) from family where
child='Female' group by parent_id having count(*)=1) F
where m.parent_id=f.parent_id;
/*
6
3
*/

--method-4
with d as (select parent_id
from family 
where  child='Male' group by parent_id having count(*)=1
intersect
select parent_id
from family 
where
child='Female' 
group by parent_id having count(*)=1) 
select * from d order by 1;
/*
3
6
*/
    
--method1
with d as (select 'ABCD' as str from dual)
select str,
level,
substr(str,level,1) 
from d connect by level<=length(str);
/*
ABCD	1	A
ABCD	2	B
ABCD	3	C
ABCD	4	D
*/

--method2
with d as (select 'ABCD' as str ,4 as seq from dual )
 select str as c1,
 mod(level,length(str))+1 c3,
 substr(str,mod(level,length(str))+1,1)||ceil(level/length(str)) as c4  
 from d connect by level<=length(str) * seq
 order by 2,3;--or use this syntax for ordering substr(str,mod(level,length(str))+1,1)||ceil(level/length(str)) asc
 /*
ABCD	1	A1
ABCD	1	A2
ABCD	1	A3
ABCD	1	A4
ABCD	2	B1
ABCD	2	B2
ABCD	2	B3
ABCD	2	B4
ABCD	3	C1
ABCD	3	C2
ABCD	3	C3
ABCD	3	C4
ABCD	4	D1
ABCD	4	D2
ABCD	4	D3
ABCD	4	D4
*/
 
------------------------------------------------------
create table transaction_data(
id number, type varchar2(10),amount number);

insert into transaction_data values(1,'C',10000);
insert into transaction_data values(2,'D',2000);
insert into transaction_data values(3,'C',10000);
insert into transaction_data values(4,'D',5000);
insert into transaction_data values(5,'D',4000);

select id,type,amount,
/*sum(decode(type,'C',amount)) over (order by id) c_a,
sum(decode(type,'D',amount)) over (order by id) d_a,*/
 sum(decode(type,'C',amount)) over (order by id) - sum(nvl(decode(type,'D',amount),0)) over (order by id) cum_amount
from transaction_data;
/*
1	C	10000	10000
2	D	2000	8000
3	C	10000	18000
4	D	5000	13000
5	D	4000	9000
*/

select id,
type,
amount,
sum(decode(type,'C',amount,'D',amount *-1)) 
over (order by id) cum_amount from transaction_data;
/*
1	C	10000	10000
2	D	2000	8000
3	C	10000	18000
4	D	5000	13000
5	D	4000	9000
*/

with d as (select  level l from dual connect by level<=5)
select l,(
select  listagg(level) within group(order by level) 
from dual connect by level<=l)
from d;

or

with d as (select  '12345' str from dual)
select substr(str,1,level) from d connect by level<=length(str);
/*
1
12
123
1234
12345
*/

---sort the data in below mention order
/*
Manager
Manager
Developer
Developer
Lead
*/

create table design(name varchar2(30),design varchar2(30));
insert into design values('A','Developer'); 
insert into design values('B','Developer'); 
insert into design values('C','Manager'); 
insert into design values('D','Lead'); 
insert into design values('E','Manager'); 


select design
from design
order by decode(design,'Manager',1,'Developer',2,'Lead',3,4);

---print india first then all other country name
create table country(c_name varchar2(30));
insert into country values('china'); 
insert into country values('australia');
insert into country values('turkey');
insert into country values('india');
insert into country values('nepal');
insert into country values('bhutan');

select c_name  
from country 
order by case when c_name='india' then 1 else 2 end;


SELECT c_name
FROM country
ORDER BY
    decode(c_name, 'india', 1, 2);

/*
india
australia
bhutan
nepal
china
turkey
*/

------------------
create table c(c1 varchar2(10),c2 number);
insert into c values('A',1);
insert into c values('B',2);
insert into c values('B',2);
insert into c values('C',3);
insert into c values('C',3);
insert into c values('C',3);

/*--lateral
The lateral keyword represents a lateral join between two or more tables. 
It joins the output of the outer query with the output of the underlying 
lateral subquery. It is like a for-each loop in SQL where the subquery iterates
through each row of the concerned table, evaluating the subquery for each row. */

select * from c;
select c1,c2 from c,lateral(select level l  from dual connect by level <=c2);
/*
A	1
B	2
B	2
B	2
B	2
C	3
C	3
C	3
C	3
C	3
C	3
C	3
C	3
C	3
*/

drop table t;
create table t (c varchar2(10));

insert into t values('A,B');
insert into t values('X,Y,Z');

select regexp_substr(c,'[^,]+',l) from t,
lateral (select level l from dual connect by level<=regexp_count(c,',')+1);
/*
A
B
X
Y
Y
*/


--no operation(NULL).do nothing
declare
lv_a number :=0;
lv_b number :=1;
res number ;
begin
    if lv_b=0 then
        null;--no operation
    else
     res:=lv_a/lv_b;
    end if;
 end;
 
 
--function
create or replace function id
return number is
begin
return 100;
end;

--table
create table t(id number,name varchar2(10));
insert into t values(1,'Nitesh');
insert into t values(2,'Sarvesh');
insert into t values(3,'Pandey');

select id,name,user_name.id from t;


---find positive or negative number from given column
drop table t;
create table t(c number);

insert into t values(1);
insert into t values(2);
insert into t values(3);
insert into t values(-1);
insert into t values(-2);
insert into t values(-3);
insert into t values(-4);


select sum(c) from t where c>0
union all
select sum(c) from t where c<0;
/*
6
-10
*/

select
(select sum(c) Positive_Number from t where c>0) positive,
(select sum(c) Negative_Number from t where c<0) negative from dual;

/*
6	-10
*/

select 
sum(decode(sign(c),1,c)) p, 
sum(decode(sign(c),-1,c)) n
from t;
/*
6	-10
*/

select 
sum(case when c>0 then c end) p,
sum(case when c<0 then c end) n
from t;
/*
6	-10
*/

select 'Positive' sign,sum(c) from t where c>0
union all
select 'Negative' sign,sum(c) from t where c<0;
/*
Positive	6
Negative	-10
*/

--------------------
select * from t;

create table t
(c number);

insert into t values(1);
insert into t values(2);
insert into t values(3);
insert into t values(11);
insert into t values(22);

select c from t order by to_char(c);
/*
1
11
2
22
3
*/

select c from t order by cast(c as varchar2(10));
/*
1
11
2
22
3
*/

select c from t order by c||'';
/*
1
11
2
22
3
*/

select substr(c,1) from t order by substr(c,1,1);
/*
1
11
2
22
3
*/

select c,ascii(c) from t order by ascii(c);
/*
1	49
11	49
2	50
22	50
3	51
*/


drop table t;
select * from t;

create table t (id number,cols1 varchar2(10),col2 varchar2(10),cols3 varchar2(10));
insert into t values(1,'A','B','C');
insert into t values(2,'A','B','A');
insert into t values(3,'A','A','A');

select id,listagg(c,',') output 
from (select id,cols1 c from t
union 
select id,col2 from t
union 
select id,cols3 from t)
group by id;
/*
1	A,B,C
2	A,B
3	A
*/

select id,listagg(distinct val,',') result from (select * from t) unpivot(val for colummn_name in(cols1,col2,cols3)) group by id;
/*
1	A,B,C
2	A,B
3	A
*/


select rownum,
        mod(rownum,2) mod2,
        decode(mod(rownum,3),0,3,mod(rownum,3)) mod3
        from dual connect by level<=9;
/*
1	1	1
2	0	2
3	1	3
4	0	1
5	1	2
6	0	3
7	1	1
8	0	2
9	1	3
*/

--Find the length of character 'A' or 'a' present in given string
with d as 
    (select  'aaAAdhfdhvbdA' s from dual)
select 
    length(s)- length(replace(upper(s),'A'))
res from d;
/*
5
*/

select regexp_count('aaAAdhfdhvbdA','A|a') res from dual;
/*
5
*/

----------find day in each month
with year as (select 2024 y from dual)
select --y,
        --rownum MM,
        --last_day(to_date(trim(to_char(level,'00'))||y,'MMYYYY')) last_day,
        to_char(last_day(to_date(trim(to_char(level,'00'))||y,'MMYYYY')),'MONTH') Month,
        to_char(last_day(to_date(trim(to_char(level,'00'))||y,'MMYYYY')),'DD') no_of_day
        from year connect by level<=12;

/*
JANUARY  	31
FEBRUARY 	29
MARCH    	31
APRIL    	30
MAY      	31
JUNE     	30
JULY     	31
AUGUST   	31
SEPTEMBER	30
OCTOBER  	31
NOVEMBER 	30
DECEMBER 	31
*/

--add space between given string
select 'welcome',regexp_replace('welcome','()','\1 ')  from dual;
/*
welcome	 w e l c o m e 
*/

select 'welcome',regexp_replace('welcome','()',' ')  from dual;
/*
welcome	 w e l c o m e 
*/

--find anagram
with ds as (select 'tag' s1 ,'man' s2 from dual)
select s1,
s2,
--sum(a),
--sum(b),
case when sum(a)=sum(b) then 'Valid Anagram' else 'Not Valid Anagram' end op  
from (select s1,s2,ora_hash(substr(s1,level,1)) a,ora_hash(substr(s2,level,1)) b from ds connect by level<=length(s1)) group by s1,s2;
/*
tag	man	Not Valid Anagram
*/

--
drop table t;
create table t (c number(10));
insert into t values(12453);
insert into t values(895);
insert into t values(5438);

---sort values of each row in ascending order.
with ds as (select rownum r,c from t)
select r,listagg(substr(c,l,1)) within group(order by substr(c,l,1)) from ds,
lateral (select level l from dual connect by level<=length(c))
group by r
order by r;
/*
12345
589
3458
*/


--find no of days without usng last_day method
with d as (select to_date('17-Feb-2023','DD-MON-YYYY') as t from dual)
select last_day(t),
add_months(trunc(t,'MONTH'),1)-1 from d;
/*
28-FEB-23	28-FEB-23
*/


--Input-Nit2133	
--Output-NiG3177
with data as (select 'Nit2133' as d from dual)
select d,substr(d,1,2)||dbms_random.string('U',1)||substr(substr(dbms_random.value,2),1,length(d)-3) res from data;

--input-Nitesh
--output-Ni3456

with data as (select 'Nitesh' as d from dual)
select d,substr(d,1,2)||substr(substr(dbms_random.value,2),1,length(d)-2) res from data;



--input-nitesh@gmail.com
--output-ni3960@gmail.com
with data as (select 'niteshefefef@gmail.com' as d from dual)
select d,substr(d,1,2)||substr(substr(dbms_random.value,2),1,length(d)-length(substr(d,instr(d,'@')))-2)||substr(d,instr(d,'@')) res from data;




--pseudo column 
/*
rownum
rowid
sequence(nextval,currval)
column_value(as a part of xmltable)
ora_rowscn,
connect by level,
connect_by_isleaf,
connect_by_iscycle
*/


select rowid,rownum,emp_name from emp;

create SEQUENCE emp_seq;
select emp_seq.nextval from dual;
select emp_seq.CURRVAL from dual;

select column_value 
from 
(xmltable('<a>123</a>'))


/*
Row num is pesudo column(less than or equal to we can equate)
Rowcount is cursor attribute*/

/*
rownum--pseudo column
row_number--analytical function
virtual colum-(c is virtaul column which is written in below code because its derived from other columns)

pseudo column
1.column not part of table.
2.values are not derived from table data.
3.cannot be indexed.
4.only selection is allowed

virtual column
1.columns prt of table
2.value are derived from other columns of same table.
3.can be index
4.only selection is allowed,no dml are allowed
*/

create table virtual_tbl(a number,b number, c as (a+b));
insert into virtual_tbl(a,b) values(10,20);
select * from virtual_tbl;

/*
10	20	30
*/


/*
Unused Column
Marking the column as unused is similar to 'logical delete' of column.
once marked as unused,it can not be revert back.however a new column with the same name can be created.
*/

alter table emp set unused(emp_name);
alter table emp drop unused column


/* Initialization block 
1.this piece of code will be executed only once for the session that is
the first time when the package is acessed.
2.this code won't be executed again the same session.
*/

create or replace package pkg1_test as
lv_num_exp number:=10;
procedure proc_print;
end pkg1_test;

create or replace package body pkg1_test as
procedure proc_print as
begin 
dbms_output.put_line('lv_num_exp'||lv_num_exp);
end proc_print;
begin

--intialization block
select count(*) 
into lv_num_exp 
from emp;

end pkg1_test;

clear screen
exec pkg1_test.proc_print;

------forward declaration
declare
    procedure proc2_test(pin2 number);--forward declartion.we can declare the procedure in advance to avoid any scope related error
    procedure proc1_test(pin number) as
    begin
        proc2_test(12);
    end;
 
    procedure proc2_test(pin2 number) as
    begin
        proc1_test(23);
    end;
    
begin
null;
end;


/*Pragma Serially Reusable

The serially reusable pragma specifies that the package state is needed for only one call 
to the server.

*/

create or replace package pkg_non_sr as
    lv_num number;
end ;

create or replace package pkg_sr_pragma as
    pragma serially_reusable;
    lv_num number;
end;

--Non Pragma Serially Reusable
clear screen
set serveroutput on;
begin
    pkg_non_sr.lv_num:=10;
    dbms_output.put_line('Variable value:'||pkg_non_sr.lv_num);
end;


----Pragma Serially Reusable
clear screen
set serveroutput on;
begin
    pkg_sr_pragma.lv_num:=13;
    dbms_output.put_line('Variable value:'||pkg_sr_pragma.lv_num);
end;

----return value which we define in block previously because its value is accessiblt till the session.
begin
    dbms_output.put_line('Variable value:'||pkg_non_sr.lv_num);
end;

--return null value because its only hold value within the block only
begin
    dbms_output.put_line('Variable value:'||pkg_sr_pragma.lv_num);
end;

----
clear screen
create or replace procedure test1_demo(p_value IN OUT varchar2,lv_temp IN OUT number)--Actual parameter 
as
begin
    p_value:='B';
    lv_temp:=1/0;
end;

clear screen
declare
    lv_char varchar2(2);
    lv_temp number;
begin
    lv_char:='A';--Formal parameter
    lv_temp:=1/0;
    begin
    test1_demo(lv_char,lv_temp);
    exception when others then
        null;
    end;
    dbms_output.put_line('return value from procedure is:'||lv_char);
end;

/*
Actual Parameter
1.When a function is called, the values (expressions) that are passed in the function call are called the arguments or actual parameters.	
2.There is no need to specify datatype in actual parameter. 
    
Formal Parameter
1. The parameter used in function definition statement which contain data type on its time of declaration is called formal parameter.
2.The datatype of the receiving value must be defined.
*/

/*
Oracle has 2 method of passing out and inout parameter in plsql code.
1.pass by reference.
2.pass by value.
*/
--Pass by value example

create or replace procedure proc_p1(pin in out varchar2)
as
begin
    pin :='B';
end;
/

declare
lv_val varchar2(2);
begin
    lv_val:='A';
    proc_p1(lv_val);
    dbms_output.put_line('Value of variable is:'||lv_val);
end;

/*
Value of variable is:B
PL/SQL procedure successfully completed.
*/

--Pass by reference
create or replace procedure proc_p2(pin in out nocopy varchar2)
as
begin
    pin :='C';
end;
/

declare
lv_val varchar2(2);
begin
    lv_val:='D';
    proc_p2(lv_val);
    dbms_output.put_line('Value of variable is:'||lv_val);
end;

/*
Value of variable is:C
PL/SQL procedure successfully completed.
*/

/*NO copy hint
NOCOPY is a hint provide to compiler to use "PASS BY REFERENCE",there are many scenarios that compiler may ignore this also.
NOCOPY hint is applicable for out and inout parameter only.
No copy hint tells the plsql compiler to pass out and inout parameter by reference rather then pass by value.
It reduce the overhead of passing parameters to improve the performance of pl/sql code.

*/
clear screen
create or replace package demo_pkg as
    type nest_tab_type is table of varchar2(4000);
    lv_nest_tab_val nest_tab_type:=nest_tab_type();
    
    procedure p_copy(param_value IN OUT nest_tab_type);
    procedure p_no_copy(param_value IN OUT NOCOPY nest_tab_type);
end;


create or replace package body demo_pkg as
    procedure p_copy(param_value IN OUT nest_tab_type) as 
    x number(38) ;
    begin
        null;
    end;

    procedure p_no_copy(param_value IN OUT NOCOPY nest_tab_type) as 
    x number(38) ;
    begin
        null;
    end;
end;

set serveroutput on
declare 
    lv_start_time number(38);
    lv_end_time number(38);
    lv_last_idx number(38);

begin
    for i in 1..38 loop
        demo_pkg.lv_nest_tab_val.extend;
        lv_last_idx:=demo_pkg.lv_nest_tab_val.last();
        demo_pkg.lv_nest_tab_val(lv_last_idx):=lpad('A',4000,'A');
    end loop;
    
    lv_start_time:=dbms_utility.get_time;
    demo_pkg.p_copy(demo_pkg.lv_nest_tab_val);
    lv_end_time:=dbms_utility.get_time;
    dbms_output.put_line('copy='||lv_end_time-lv_start_time);
    
    lv_start_time:=dbms_utility.get_time;
    demo_pkg.p_no_copy(demo_pkg.lv_nest_tab_val);
    lv_end_time:=dbms_utility.get_time;
    dbms_output.put_line('copy='||lv_end_time-lv_start_time);
end;


---Recursive function example

with t(n) as 
(select 1 from dual --anchor member
union all
select n+1 from t where n<5 --recursive member
)
select * from t;
/*
1
2
3
4
5
*/
     

with t(n1,n2) as
(
select 1,'A' from dual
union all
select n1+1,n2||'A'
from t where n1<5)
select * from t;
/*
1	A
2	AA
3	AAA
4	AAAA
5	AAAAA
*/

---DML FOR LOGGING
drop table source_1;

clear screen
create table source_1(emp_name varchar2(20),
age number(2));

insert into source_1 values('Nitesh',30);
insert into source_1 values('Arun',27);
insert into source_1 values('Purnima',20);
insert into source_1 values('Sarvesh Pandey',50);
insert into source_1 values('Soumya Tiwari',29);

clear screen
create table EMP2(emp_name varchar2(10),
age number(2));


begin 
DBMS_ERRLOG.create_error_log (dml_table_name => 'emp2');
end;
SELECT * FROM err$_emp2;


INSERT INTO EMP2 SELECT * FROM SOURCE_1 
LOG ERRORS INTO ERR$_EMP2 REJECT LIMIT UNLIMITED; --insert the data with no error instead of complete rollback of status.


--LOG ERRORS INTO ERR$_EMP2('MY TEST INSERT') REJECT LIMIT UNLIMITED;--ASSIGN TAG TO ERROR



/*MULTITABLE INSERT STATEMENT*/

DROP TABLE T;
CREATE TABLE T(C VARCHAR2(10));
INSERT INTO T VALUES('A');
INSERT INTO T VALUES('B');
INSERT INTO T VALUES('C');

CREATE TABLE T1(C VARCHAR2(10));
CREATE TABLE T2(C VARCHAR2(10));
CREATE TABLE T3(C VARCHAR2(10));


SELECT * FROM T;
SELECT * FROM T1;
SELECT * FROM T2;
SELECT * FROM T3;

--UNCONDITIONAL INSERTION DATA IN MULTITABLE USING INSERT ALL KEYWORD
INSERT ALL INTO T1 VALUES(C)
            INTO T2 VALUES(C)
            INTO T3 VALUES(C)
    SELECT * FROM T;
    
    
--CONDITIONAL INSERTION DATA IN MULTITABLE USING INSERT ALL KEYWORD


CREATE TABLE E(E_NAME VARCHAR2(10),DEPT_NO NUMBER);
INSERT INTO E VALUES('NITESH',10);
INSERT INTO E VALUES('SARVESH',20);
INSERT INTO E VALUES('PANDEY',20);
INSERT INTO E VALUES('ARUN',20);
INSERT INTO E VALUES('SAM',10);
INSERT INTO E VALUES('PURNIMA',30);
INSERT INTO E VALUES('TARA',30);

SELECT * FROM E;

CREATE TABLE E_10(E_NAME VARCHAR2(10),DEPT_NO NUMBER);
CREATE TABLE E_20(E_NAME VARCHAR2(10),DEPT_NO NUMBER);
CREATE TABLE E_30(E_NAME VARCHAR2(10),DEPT_NO NUMBER);

INSERT ALL 
    WHEN DEPT_NO=10 THEN 
        INTO E_10 VALUES(E_NAME,DEPT_NO)
    WHEN DEPT_NO=20 THEN 
        INTO E_20 VALUES(E_NAME,DEPT_NO)
    WHEN DEPT_NO=30 THEN 
        INTO E_30 VALUES(E_NAME,DEPT_NO)

SELECT E_NAME,DEPT_NO FROM E;


SELECT * FROM E_10
UNION ALL
SELECT * FROM E_20
UNION ALL
SELECT * FROM E_30;


--CONDITIONAL INSERT

DROP TABLE E_30;

CREATE TABLE E(E_NAME VARCHAR2(10),SAL NUMBER);
INSERT INTO E VALUES('NITESH',1000);
INSERT INTO E VALUES('SARVESH',2000);
INSERT INTO E VALUES('PANDEY',3000);
INSERT INTO E VALUES('ARUN',4000);
INSERT INTO E VALUES('SAM',5000);
INSERT INTO E VALUES('PURNIMA',2500);
INSERT INTO E VALUES('TARA',1500);

SELECT * FROM E_10;

CREATE TABLE E_10(E_NAME VARCHAR2(10),SAL NUMBER);
CREATE TABLE E_20(E_NAME VARCHAR2(10),SAL NUMBER);
CREATE TABLE E_30(E_NAME VARCHAR2(10),SAL NUMBER);

INSERT ALL 
    WHEN SAL<=2000 THEN 
        INTO E_10 VALUES(E_NAME,SAL)
    WHEN SAL>2000 AND SAL<4000 THEN 
        INTO E_20 VALUES(E_NAME,SAL)
    WHEN SAL>4000 THEN 
        INTO E_30 VALUES(E_NAME,SAL)

SELECT E_NAME,SAL FROM E;


SELECT * FROM E_10
UNION ALL
SELECT * FROM E_20
UNION ALL
SELECT * FROM E_30;

INSERT FIRST--IF MORE THEN ONE VALUE SATIFIED THE SAME CONDITION THEN IT FRST INSERT THE VALUE AND REMIAING ALL VALUE PASS TO THE NEXT CONDITION  
    WHEN SAL<=2000 THEN 
        INTO E_10 VALUES(E_NAME,SAL)
    WHEN SAL>2000 AND SAL<4000 THEN 
        INTO E_20 VALUES(E_NAME,SAL)
    WHEN SAL>4000 THEN 
        INTO E_30 VALUES(E_NAME,SAL)

SELECT E_NAME,SAL FROM E;

--LOCKING,UNLOCKING TABLE 

ALTER TABLE EMP READ ONLY;--NOT ALLOW TO PERORM ANY DML OPERATION ON TABLE
INSERT INTO EMP VALUES('Samnit3',1143341,23890,10);

ALTER TABLE EMP READ WRITE;
INSERT INTO EMP VALUES('Samnit6',1143341,23890,10);
