--normal cursor can be global
create or replace package test_package1 as
 cursor lv_cursor is select * from emp;
end test_package1;



--ref cursor is not global
create or replace package test_package2 as
    lv_cur SYS_REFCURSOR;
end test_package2;
