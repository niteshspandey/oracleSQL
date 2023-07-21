---By default ref cursor is weakly typed ref cursor.
---sys ref cursor is also weakly types ref cursor.
---Simple ref cursor

clear screen;
set serveroutput on;
declare
    type ref_cur_demo is ref CURSOR;
    ref_cur_emp_list ref_cur_demo;
    lv_name varchar2(10);
    lv_dept_no number;
    
begin
    dbms_output.put_line('---records for employee table');
    open ref_cur_emp_list for select emp_name from t_emp_det;
    loop
        fetch ref_cur_emp_list into lv_name;
        exit when ref_cur_emp_list%notfound;
        dbms_output.put_line(lv_name);
    end loop;
    close ref_cur_emp_list;
    dbms_output.put_line('---records for deptartment table');  
    open ref_cur_emp_list for 'select dept_id,dept_name from t_dept_det';
    loop
        fetch ref_cur_emp_list into lv_dept_no,lv_name ;
        exit when ref_cur_emp_list%notfound;
        dbms_output.put_line(lv_dept_no||'-'||lv_name);
    end loop;
    close ref_cur_emp_list;
end;

/*
---records for employee table
Nitesh
Sarvesh
Purnima
Tara
Nitesh
Badal
---records for deptartment table
10-IT
20-Admin
30-Ops
40-HR

PL/SQL procedure successfully completed.
*/

---Ref cursor with data type 
clear screen;
set serveroutput on;
declare
    type ref_cur_demo is ref CURSOR;
    ref_cur_emp_list ref_cur_demo;
    lv_name t_emp_det%rowtype;
    lv_dept_no t_dept_det%rowtype;
    
begin
    dbms_output.put_line('-----cursor 1---------');
    open ref_cur_emp_list for select * from t_emp_det;
    loop
        fetch ref_cur_emp_list into lv_name;
        exit when ref_cur_emp_list%notfound;
        dbms_output.put_line(lv_name.emp_name||'--'||lv_name.sal);
    end loop;
    close ref_cur_emp_list;
    dbms_output.put_line('---c ursor 2-----------');  
    open ref_cur_emp_list for select * from t_dept_det;
    loop
        fetch ref_cur_emp_list into lv_dept_no ;
        exit when ref_cur_emp_list%notfound;
        dbms_output.put_line(lv_dept_no.dept_id||'-'||lv_dept_no.dept_name);
    end loop;
    close ref_cur_emp_list;
end;

/*
-----cursor 1---------
Nitesh--29330
Sarvesh--21000
Purnima--16500
Tara--19650
Nitesh--24456
Badal--201000
---cursor 2-----------
10-IT
20-Admin
30-Ops
40-HR


PL/SQL procedure successfully completed.

-----cursor 1---------
Nitesh--29330
Sarvesh--21000
Purnima--16500
Tara--19650
Nitesh--24456
Badal--201000
---c ursor 2-----------
10-IT
20-Admin
30-Ops
40-HR
PL/SQL procedure successfully completed.
*/


---Ref Cursor(Strongly typed---because of return datatype)
clear screen;
set serveroutput on;
declare
    type ref_cur_demo is ref CURSOR return t_emp_det%rowtype;
    ref_cur_emp_list ref_cur_demo;
    lv_name t_emp_det%rowtype;
    lv_dept_no t_dept_det%rowtype;
    
begin
    dbms_output.put_line('-----cursor 1---------');
    open ref_cur_emp_list for select * from t_emp_det;
    loop
        fetch ref_cur_emp_list into lv_name;
        exit when ref_cur_emp_list%notfound;
        dbms_output.put_line(lv_name.emp_name||'--'||lv_name.sal);
    end loop;
    close ref_cur_emp_list;

end;

/*
-----cursor 1---------
Nitesh--29330
Sarvesh--21000
Purnima--16500
Tara--19650
Nitesh--24456
Badal--201000

PL/SQL procedure successfully completed.
*/

---Ref Cursor(Strong typed---because of return datatype)
---wrong data type is return hence error occurred
clear screen;
set serveroutput on;
declare
    type ref_cur_demo is ref CURSOR return t_emp_det%rowtype;
    ref_cur_emp_list ref_cur_demo;
    lv_name t_emp_det%rowtype;
    lv_dept_no t_dept_det%rowtype;
    
begin
    dbms_output.put_line('-----cursor 1---------');
    open ref_cur_emp_list for select * from t_dept_det;
    loop
        fetch ref_cur_emp_list into lv_dept_no;
        exit when ref_cur_emp_list%notfound;
        dbms_output.put_line(lv_dept_no.dept_id||'--'||lv_dept_no.dept_name);
    end loop;
    close ref_cur_emp_list;

end;

/*Error report -
ORA-06550: line 11, column 9:
PLS-00394: wrong number of values in the INTO list of a FETCH statement
PL/SQL: SQL Statement ignored
*/


---Ref Cursor(Weakly typed---because of no return datatype)

clear screen;
set serveroutput on;
declare
    type ref_cur_demo is ref CURSOR ;
    ref_cur_emp_list ref_cur_demo;
    lv_name t_emp_det%rowtype;
    lv_dept_no t_dept_det%rowtype;
    
begin
    dbms_output.put_line('-----cursor 1---------');
    open ref_cur_emp_list for select * from t_dept_det;
    loop
        fetch ref_cur_emp_list into lv_dept_no;
        exit when ref_cur_emp_list%notfound;
        dbms_output.put_line(lv_dept_no.dept_id||'--'||lv_dept_no.dept_name);
    end loop;
    close ref_cur_emp_list;

end;
/*
-----cursor 1---------
10--IT
20--Admin
30--Ops
40--HR
PL/SQL procedure successfully completed.
*/
