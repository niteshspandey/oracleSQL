/*
ADVANTAGES OF PACKAGE
1.LOGICAL GROUP OF SUBPROGRAMS
    LOGICALLY GROUP THE RELATED SUBPROGRAMS,OBJECTS AND VARIABLES.
    
2.SECURITY
    SECURITY OF CODE THROUGH IMPLEMENTATION OF PRIVATE SUBPROGRAMS.
    
3.BETTER PERFORMANCE
    ENTIRE PACKAGE IS LOADED INTO MEMORY WHEN THE PACKAGE IS FIRST REFERENCED.
    THERE IS ONLY ONE COPY OF PACKAGE IN THE MEMORY FOR ALL USERS.
    
4.BETTER DEPENDENCY OBJECT INVALIDATION WHILE RECOMPILING THE PACKAGE BODY.
5.FEATURE THAT CAN BE IMPLEMENTED ONLY WITHIN PACKAGE.
    5.1 OVERLOADING OF SUBPROGRAMS.
    5.2 GLOBAL VARIABLE AND CONSTANT.
    5.3 INITIALIZATION BLOCK.
    5.4 SESSION STATE.
    5.5 REUSE OBJECT NAMING ACROSS OTHER PACKAGES.


*/


--Packages allow you to encapsulate logically related types, variables, constants, subprograms, cursors, and exceptions in named PL/SQL modules. 
--PL/SQL package is a logical grouping of a related subprogram (procedure/function) into a single element.

CREATE OR REPLACE PACKAGE priv_pkg_demo AS
    PROCEDURE p1_proc;

    PROCEDURE p2_proc;

END;
/

CREATE OR REPLACE PACKAGE BODY priv_pkg_demo AS

    PROCEDURE priv_proc AS
    BEGIN
        dbms_output.put_line('Private Procedure inside the package body');
    END;

    PROCEDURE p1_proc AS
    BEGIN
        dbms_output.put_line('Procedure 1 inside the package body');
        priv_proc;
    END;

    PROCEDURE p2_proc AS
    BEGIN
        dbms_output.put_line('Procedure 2 inside the package body');
    END;

END;
/

BEGIN
    priv_pkg_demo.p1_proc();
END;

BEGIN
    priv_pkg_demo.priv_proc();
END;
