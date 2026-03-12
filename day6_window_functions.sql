-- Ranking students using ROW_NUMBER
SELECT name, marks,
       ROW_NUMBER() OVER (ORDER BY marks DESC) AS row_num
FROM students;
-- Ranking students using Rank_Number
SELECT name, marks,
       RANK() OVER (ORDER BY marks DESC) AS rank_num
FROM students;
-- Ranking students using Dense_Rank
SELECT name, marks,
       RANK() OVER (ORDER BY marks DESC) AS rank_num
FROM students;