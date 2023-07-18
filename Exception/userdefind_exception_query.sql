----------------Raise Keyword----------------------
clear screen
set serveroutput on
DECLARE
    v1_number number:=10;
    v2_number number:=0;
    v_result number;
    e_demo_is_zero EXCEPTION;
begin
    if v2_number=0 then
        raise e_demo_is_zero;
    else
        v_result:=v1_number/v2_number;
    end if;
exception when e_demo_is_zero then
dbms_output.put_line('Denominator must be greater than zero');
end;
    
    
--------------------Raise Application Error--------------------    
clear screen
set serveroutput on
declare 
lv_first number:=10;
lv_second number:=0;
lv_result number;

begin
        if lv_second=0 then
            raise_application_error(-20678,'denominator should be greater then zero');
        else 
         lv_result := lv_first/lv_second ; 
        end if;    
end;
