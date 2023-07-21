1.Implicit cursors are automatically created by Oracle whenever an SQL statement is executed.
2.Whenever any DML operations occur in the database, an implicit cursor is created that holds the rows affected, in that particular operation. 
3.These cursors cannot be named and, hence they cannot be controlled or referred from another place of the code.

--snippet
clear screen;
set serveroutput on;
declare
total_row_affected number(2);

begin
    update t_emp_det set sal=sal+500 ;
    if sql%notfound then
    dbms_output.put_line('No Data Found');
    else
    total_row_affected:=sql%rowcount;
    dbms_output.put_line('Total row affected as:'||total_row_affected);
    end if;
end;

/*
Total row affected as:6
PL/SQL procedure successfully completed
*/


clear screen;
set serveroutput on;
declare
total_row_affected number(2);

begin
    update t_emp_det set sal=sal+500 where emp_no=999;
    if sql%notfound then
    dbms_output.put_line('No Record Updated ');
    else
    total_row_affected:=sql%rowcount;
    dbms_output.put_line('Total row affected as:'||total_row_affected);
    end if;
end;

/*
No Record Updated 
PL/SQL procedure successfully completed.
*/
