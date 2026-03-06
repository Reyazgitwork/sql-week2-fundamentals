-- Day 1: Basic SQL Practice
-- Objective: Practice SELECT, WHERE, ORDER BY, and aggregate functions

-- Create database
CREATE DATABASE week2_sql;

-- Switch to database
USE week2_sql;

-- Create students table
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

-- Insert sample data
INSERT INTO students (id, name, marks) VALUES
(1, 'Asha', 80),
(2, 'Ravi', 70),
(3, 'Meera', 90);

-- Retrieve all records
SELECT * FROM students;

-- Filter students scoring above 75
SELECT * FROM students
WHERE marks > 75;

-- Calculate average marks
SELECT AVG(marks) AS average_marks FROM students;
