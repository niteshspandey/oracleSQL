select * from smartphone_det;

select brand_name,screen_size from smartphone_det where brand_name='samsung' order by screen_size desc;
select num_front_cameras + num_rear_cameras as "No of cameras" ,brand_name,model from smartphone_det ORDER by "No of cameras" desc;


select brand_name,model,battery_capacity from smartphone_det where battery_capacity is not null
order by battery_capacity desc FETCH FIRST 3 ROWS ONLY;

select brand_name,model,battery_capacity from smartphone_det where battery_capacity is not null 
and battery_capacity <> (select max(battery_capacity) from smartphone_det)
order by battery_capacity desc fetch FIRST 1 row only  ;


select brand_name,model,price,rating
from smartphone_det order by price asc,rating desc;

select brand_name,count(brand_name)
from smartphone_det group by brand_name order by count(brand_name) desc
fetch first 5 row only;

select brand_name,
count(brand_name) "Count",round(avg(price),2)  "Average Price",
max(rating) "Maxium Rating" ,
round(avg(screen_size),2) "Average screen size"
from smartphone_det group by brand_name order by count(brand_name) desc;

select * from smartphone_det;
select brand_name,has_nfc,avg(price),avg(battery_capacity) from smartphone_det group by has_nfc,brand_name order by brand_name;


select has_5g,
round(avg(price)),
round(avg(battery_capacity)) 
from smartphone_det 
group by has_5g,brand_name 
order by brand_name;

select brand_name,
processor_brand,
count(model),
round(avg(primary_camera_rear))
from smartphone_det 
group by 
brand_name,
processor_brand 
order by 
brand_name ,
round(avg(primary_camera_rear));



select * from smartphone_det;

select brand_name,
screen_size 
from smartphone_det 
order by screen_size asc;


select brand_name,round(avg(screen_size)) 
from smartphone_det 
group by brand_name 
order by round(avg(screen_size)) 
fetch first 1 row only;

has_nfc,has_ir_blaster,

select brand_name,count(brand_name) Result
from smartphone_det where has_nfc='True' and has_ir_blaster='True' group by brand_name order by Result desc;


----------Having Clause-----------
--select ---where
--group  ---having

select brand_name,round(avg(price)) as Price from smartphone_det group by brand_name  having count(brand_name)>20 
order by Price;

select ram_capacity,refresh_rate from smartphone_det;

--------------------------------------------- 
