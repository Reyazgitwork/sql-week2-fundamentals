USE week2_sql;

-- Q1: Students scoring above average
SELECT name
FROM students
WHERE marks > (
    SELECT AVG(marks)
    FROM students
);

-- Q2: Student(s) with highest marks
SELECT name
FROM students
WHERE marks = (
    SELECT MAX(marks)
    FROM students
);

-- Q3: Students scoring below average
SELECT name
FROM students
WHERE marks < (
    SELECT AVG(marks)
    FROM students
);

---- Day 4: Subqueries Practice

USE week2_sql;

-- Q1: Students scoring above average
SELECT name
FROM students
WHERE marks > (
    SELECT AVG(marks)
    FROM students
);

-- Q2: Student(s) with highest marks
SELECT name
FROM students
WHERE marks = (
    SELECT MAX(marks)
    FROM students
);

-- Q3: Students scoring below average
SELECT name
FROM students
WHERE marks < (
    SELECT AVG(marks)
    FROM students
);

-- Q4: Students who scored the same as the minimum marks
SELECT name, marks
FROM students
WHERE marks = (
  SELECT MIN(marks)
  FROM students
);

-- Q5: Students who scored in Top 3 marks (subquery with ORDER BY + LIMIT)
SELECT name, marks
FROM students
WHERE marks IN (
    SELECT marks FROM (
        SELECT marks
        FROM students
        ORDER BY marks DESC
        LIMIT 3
    ) AS top_marks
)
ORDER BY marks DESC, name;