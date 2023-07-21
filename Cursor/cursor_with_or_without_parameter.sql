
--2 different cursor for each department id

clear screen
set serveroutput on
declare
 cursor dept_10 is select emp_name from t_emp_det where dept_id=10;
 cursor dept_20 is select emp_name from t_emp_det where dept_id=20;
 emp_name_data varchar2(10);
begin
    dbms_output.put_line('--------Record for department 10-----------');
    open dept_10;
    loop
        fetch  dept_10 into emp_name_data;
        exit when dept_10%notfound;
        dbms_output.put_line(emp_name_data);
    end loop;
    close dept_10;
    dbms_output.put_line('----------dept 20 employee data------------');
    open dept_20;
    loop
        fetch dept_20 into emp_name_data;
        exit when dept_20%notfound;
        dbms_output.put_line(emp_name_data);
    end loop;
    close dept_20;
    
end;

/*
--------Record for department 10-----------
Nitesh
Purnima
Tara
----------dept 20 employee data------------
Sarvesh
Nitesh

PL/SQL procedure successfully completed.
*/

--instead of 2 cursor we can write above query with one cursor only for each depatment no
clear screen
set serveroutput on
declare
 lv_dept_no number;
 cursor dept_cur is select emp_name from t_emp_det where dept_id=lv_dept_no;
 emp_name_data varchar2(10);
begin
    dbms_output.put_line('--------Record for department 10-----------');
    lv_dept_no:=10;
    open dept_cur;
    loop
        fetch  dept_cur into emp_name_data;
        exit when dept_cur%notfound;
        dbms_output.put_line(emp_name_data);
    end loop;
    close dept_cur;
    dbms_output.put_line('----------dept 20 employee data------------');
    lv_dept_no:=20;
    open dept_cur;
    loop
        fetch  dept_cur into emp_name_data;
        exit when dept_cur%notfound;
        dbms_output.put_line(emp_name_data);
    end loop;
    close dept_cur;
    
end;
/*
--------Record for department 10-----------
Nitesh
Purnima
Tara
----------dept 20 employee data------------
Sarvesh
Nitesh

PL/SQL procedure successfully completed.
*/

--Passing  parameter to explicit cursor 
--instead of assigning the value to variable direct pass to cursor.
clear screen
set serveroutput on
declare
 cursor dept_cur(p_dept_no number) is select emp_name from t_emp_det where dept_id=p_dept_no;
 emp_name_data varchar2(10);
begin
    dbms_output.put_line('--------Record for department 10-----------');
    open dept_cur(10);
    loop
        fetch  dept_cur into emp_name_data;
        exit when dept_cur%notfound;
        dbms_output.put_line(emp_name_data);
    end loop;
    close dept_cur;
    dbms_output.put_line('----------dept 20 employee data------------');
    open dept_cur(20);
    loop
        fetch  dept_cur into emp_name_data;
        exit when dept_cur%notfound;
        dbms_output.put_line(emp_name_data);
    end loop;
    close dept_cur;
    
end; 
/*
--------Record for department 10-----------
Nitesh
Purnima
Tara
----------dept 20 employee data------------
Sarvesh
Nitesh

PL/SQL procedure successfully completed.
*/

---Passing Parameter to explicit cursor for loop statements.
set serveroutput on;
clear screen;

declare
    cursor demo_emp_cur(dept_no number) is select emp_name from t_emp_det where dept_id=dept_no;
begin
    dbms_output.put_line('--------Record for department 10-----------');
    for i in demo_emp_cur(10)
    loop
        dbms_output.put_line(i.emp_name);
    end loop;  
    
    dbms_output.put_line('--------Record for department 20-----------');
    for i in demo_emp_cur(20)
    loop
        dbms_output.put_line(i.emp_name);
    end loop;

    dbms_output.put_line('--------Record for department 30-----------');
    for i in demo_emp_cur(30)
    loop
        dbms_output.put_line(i.emp_name);
    end loop;
end;

/*
--------Record for department 10-----------
Nitesh
Purnima
Tara
--------Record for department 20-----------
Sarvesh
Nitesh
--------Record for department 30-----------

PL/SQL procedure successfully completed.

*/
