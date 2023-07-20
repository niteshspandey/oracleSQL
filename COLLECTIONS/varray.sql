1.VARRAY stands for the variable-sized array. 
2.A VARRAY is single-dimensional collections of elements with the same data type. 
3.A VARRAY is a type of collection in which each element is referenced by a positive integer called the array index. 
  
clear screen;
set serveroutput on;
declare
type v_array_type is varray(7) of varchar2(30);
week_days v_array_type:=v_array_type();
begin
    week_days.extend(7);
    week_days(1):='Monday';
    week_days(2):='Tueday';
    week_days(3):='Wednesday';
    week_days(4):='Thursday';

    dbms_output.put_line('week of the name:'||week_days(1));
    dbms_output.put_line('week of the name:'||week_days(5));

end;

/*
week of the name:Monday
week of the name:
PL/SQL procedure successfully completed.
*/
