--SUBQUEY
/*
A SUBQUERY IS A QUERY WITHIN ANOTHER SQL QUERY(INNER QUERY OR A NESTED QUERY)
THE RESULT RETURNED BY THE INNER QUERY WILL BE USED AS AN INPUT TO OUTER QUERY.

WHERE CAN SUBQUERIES BE USED
INSERT
SELECT (WHERE,SELECT,FROM,HAVING)
UPDATE
DELETE


TYPE OF SUBQUERY

1.SIMPLE SUBQUERY(NON CORRELATED SUBQUERY)
INNER QUERY EXECUTED FIRST
    1.1 SINGLE ROW SUBQUERY
    1.2 MULTI ROW SUBQUERY
    1.3 MULTI COLUMN SUBQUERY
    
2.CORRELATED SUBQUERY
OUTERQUERY AND INNER QUERY ARE EXECUTED PARELLELY
OUTER QUERY EXECUTED FIRST.


*/
--SINGLE ROW SUBQUERY
SELECT * FROM EMP
    WHERE SAL=(SELECT MAX(SAL) FROM EMP);
    
SELECT * FROM EMP
    WHERE DEPT_NO IN (SELECT DEPT_NO FROM EMP WHERE SAL>20000);
   
--MULTI ROW SUBQUERY
SELECT * FROM EMP
    WHERE SAL=(SELECT MAX(SAL) FROM EMP);

--MULTI COLUMN SUBQUERY
SELECT * FROM EMP WHERE (DEPT_NO,SAL) IN(
SELECT DEPT_NO,MAX(SAL) FROM EMP GROUP BY DEPT_NO);

--PERSON GETTING MAXIMUM SALARY USING CORRELATED SUBQUERY--
SELECT * FROM EMP A
WHERE 1=(SELECT COUNT(1) FROM EMP B WHERE
B.SAL>=A.SAL);