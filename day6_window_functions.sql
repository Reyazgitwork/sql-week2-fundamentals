use week2_sql;

select name, marks,
       ROW_NUMBER() OVER (ORDER BY marks DESC) AS row_num
FROM students;

SELECT name, marks,
       RANK() OVER (ORDER BY marks DESC) AS rank_num
FROM students;

SELECT name, marks,
       DENSE_RANK() OVER (ORDER BY marks DESC) AS dense_rank_num
FROM students;