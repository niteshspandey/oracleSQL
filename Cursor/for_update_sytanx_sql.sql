--For Update
/*
1.Sometimes, you want to lock a set of rows before you can update them in your program. 
Oracle provides the FOR UPDATE clause of the SELECT statement in an updatable cursor to perform this kind of locking mechanism.
2.The FOR UPDATE clause is an optional part of a SELECT statement. Cursors are read-only by default.

Once you open the cursor, Oracle will lock all rows selected by the SELECT ... FOR UPDATE statement in the tables specified in the FROM clause.
And these rows will remain locked until the cursor is closed or the transaction is completed with either COMMIT or ROLLBACK.
*/

clear screen
set serveroutput on;
declare
 cursor c_demo_for_update is select emp_no from t_emp_det where dept_id=10 for update;
 lv_number number;
begin
    open c_demo_for_update;
    dbms_lock.sleep(30);
    loop
        fetch c_demo_for_update into lv_number;
        exit when c_demo_for_update%notfound;
        dbms_output.put_line('updating employee'||lv_number);
        update t_emp_det set sal=sal+500 where current of c_demo_for_update;
    end loop;
    close c_demo_for_update;
end;

/*
updating employee1
updating employee3
updating employee4

PL/SQL procedure successfully completed.
*/
