--IN VS ANY

SELECT * FROM T;


INSERT INTO T VALUES(10);
INSERT INTO T VALUES(20);
INSERT INTO T VALUES(30);
INSERT INTO T VALUES(40);
INSERT INTO T VALUES(50);
INSERT INTO T VALUES(60);
INSERT INTO T VALUES(70);
INSERT INTO T VALUES(80);
INSERT INTO T VALUES(90);
INSERT INTO T VALUES(100);


SELECT * FROM T WHERE C =ANY(30,50,70);
SELECT * FROM T WHERE C IN(30,50,70);
SELECT * FROM T WHERE C=30 OR C=50 OR C=70;

SELECT * FROM T WHERE C=30
UNION ALL
SELECT * FROM T WHERE C=50
UNION ALL
SELECT * FROM T WHERE C=70;

-- >ANY (GREATER THAN SMALLEST NUMBER) --
SELECT * FROM T WHERE C>ANY(30,50,70);
SELECT * FROM T WHERE C>ANY(30);
SELECT * FROM T WHERE C>30 OR C>50 OR C>70;

-- <ANY (LESS THAN GREATEST NUMBER)---
SELECT * FROM T WHERE C<ANY(30,50,70);
SELECT * FROM T WHERE C<30 OR C<50 OR C<70;


--any vs all comparison

select * from t where c >ALL(30,50,70);--greater than greatest number (80,90,100)
select * from t where c >any(30,50,70);--greater than lowest number (40,50,60,70,80,90,100)

select * from t where c >=ALL(30,50,70);--greater than greatest number (70,80,90,100)
select * from t where c >=any(30,50,70);--greater than lowest number (30,40,50,60,70,80,90,100)

select * from t where c <ALL(30,50,70);--less than lowest number.(10,20)
select * from t where c <any(30,50,70);--less than greates number.(10,20,30,40,50,60)

select * from t where c <=ALL(30,50,70);--less than lowest number.(10,20,30)
select * from t where c <=any(30,50,70);--less than greates number.(10,20,30,40,50,60,70)
