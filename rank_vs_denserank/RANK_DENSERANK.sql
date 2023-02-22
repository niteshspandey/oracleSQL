--RANK VS DENSE RANK
SELECT
    emp_name,
    emp_no,
    sal,
    RANK()
    OVER(
        ORDER BY
            sal DESC
    )
FROM
    emp;
    
--DENSE RANK
SELECT
    emp_name,
    emp_no,
    sal,
    DENSE_RANK()
    OVER(
        ORDER BY
            sal DESC
    )
FROM
    emp;