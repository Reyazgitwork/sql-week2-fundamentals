-- Day 1: SQL Basics Practice

CREATE DATABASE week2_sql;
USE week2_sql;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

INSERT INTO students (id, name, marks) VALUES
(1, 'Asha', 80),
(2, 'Ravi', 70),
(3, 'Meera', 90),
(4, 'Arjun', 65),
(5, 'Priya', 85);
-- Day 1: SQL Basics Practice

-- Basic SELECT queries

SELECT * FROM students;

SELECT name, marks FROM students;

SELECT * FROM students
WHERE marks > 75;

SELECT * FROM students
ORDER BY marks DESC;

SELECT COUNT(*) AS total_students FROM students;

SELECT AVG(marks) AS average_marks FROM students;
