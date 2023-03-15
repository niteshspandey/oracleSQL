select * from movie_tbl where 
score =(select max(score) from movie_tbl);

