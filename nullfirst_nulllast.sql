create table temp(c number);
insert into temp values(1);
insert into temp values(2);
insert into temp values(3);
insert into temp values(4);
insert into temp values(null);
insert into temp values(5);
insert into temp values(null);

select * from temp;

select * from temp order by c;
select * from temp order by c nulls first;

select * from temp order by c desc;
select * from temp order by c desc nulls first;

select * from temp order by c nulls first;
select * from temp order by c desc nulls last ;
