--Bulk Collect 
/*These are select statement that retrive multiple rows with a single fetch,
there by improving the speed of data retrival.

A bulk collect is a method of fetching data where the PL/SQL engine tells the SQL engine to collect 
many rows at once and place them in a collection. The SQL engine retrieves all the rows and loads 
them into the collection and switches back to the PL/SQL engine. All the rows are retrieved with only 2 context switches.

*/

CREATE OR REPLACE FUNCTION fn_bulk_collect_demo (
    pin_dept_no NUMBER
) RETURN sys.odcivarchar2list AS
    lv_list_name sys.odcivarchar2list;
BEGIN
    SELECT
        emp_name
    BULK COLLECT
    INTO lv_list_name
    FROM
        t_emp_det
    WHERE
        dept_id = pin_dept_no;

    RETURN lv_list_name;
END;
/

select * from table(fn_bulk_collect_demo(10));
/*Nitesh
Purnima
Tara
*/
