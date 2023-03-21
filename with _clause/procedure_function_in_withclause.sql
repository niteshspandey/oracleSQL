--function inside with clause
with function func_with_demo(p_id in number) 
return number is
begin
return p_id;
end;

select func_with_demo(1) from dual;


--procedure in the with clause
with procedure proc_with_demo(p_id in number)is
begin
dbms_output.put_line('p_id'||p_id);
end;
select emp_no from emp where rownum=1;