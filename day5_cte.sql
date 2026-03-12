use week2_sql;
WITH avg_marks AS (
  SELECT AVG(marks) AS avg_value
  FROM students
)
SELECT name, marks
FROM students
WHERE marks > (SELECT avg_value FROM avg_marks)
ORDER BY marks DESC;

WITH student_scores AS (
  SELECT id, name, marks
  FROM students
)
SELECT *
FROM student_scores
ORDER BY marks DESC;
