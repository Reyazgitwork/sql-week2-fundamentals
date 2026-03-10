USE week2_sql;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Asha', 'Seattle'),
(2, 'Ravi', 'Boston'),
(3, 'Meera', 'Chicago');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount INT
);

INSERT INTO orders VALUES
(101, 1, 500),
(102, 1, 700),
(103, 2, 300);

SELECT c.name, o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.name, o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name;