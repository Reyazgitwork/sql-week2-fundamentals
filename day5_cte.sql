-- Day 5: CTE Practice
USE week2_sql;

-- Students above average using CTE
WITH avg_marks AS (
    SELECT AVG(marks) AS avg_value
    FROM students
)
SELECT name, marks
FROM students
WHERE marks > (SELECT avg_value FROM avg_marks)
ORDER BY marks DESC;
