-- Day 2: Aggregates + GROUP BY + HAVING
USE week2_sql;

-- Add department column (only run once)
ALTER TABLE students ADD department VARCHAR(50);

-- Assign departments (only run once)
UPDATE students SET department = 'IT' WHERE id IN (1,3,7);
UPDATE students SET department = 'HR' WHERE id IN (2,6,9);
UPDATE students SET department = 'Finance' WHERE id IN (6,8,10);

-- Aggregates
SELECT COUNT(*) AS total_students FROM students;
SELECT AVG(marks) AS avg_marks FROM students;
SELECT MAX(marks) AS highest, MIN(marks) AS lowest FROM students;

-- GROUP BY
SELECT department, COUNT(*) AS total_students
FROM students
GROUP BY department;

SELECT department, AVG(marks) AS avg_marks
FROM students
GROUP BY department;

-- HAVING
SELECT department, AVG(marks) AS avg_marks
FROM students
GROUP BY department
HAVING AVG(marks) > 80;
