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


select * from t_emp_det order by sal desc

Nitesh	1	23456	20
Nitesh	100	23000	10
Sam	111	23000	30
Sarvesh	110	20000	20
Purnima	130	15000	10
Tara	131	15000	10

select dense_rank(15000) within group(order by sal desc) rnk from t_emp_det;--4
select rank(15000) within group(order by sal desc) rnk from t_emp_det;--5
