-- Mini Project: E-commerce SQL Analysis
-- Database: ecommerce_mini
-- MySQL 8.0

DROP DATABASE IF EXISTS ecommerce_mini;
CREATE DATABASE ecommerce_mini;
USE ecommerce_mini;

-- 1) Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

-- 2) Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- 3) Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 4) Order Items table (line items)
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Customers
INSERT INTO customers VALUES
(1,'Asha','Seattle'),
(2,'Ravi','Boston'),
(3,'Meera','Chicago'),
(4,'Priya','Austin'),
(5,'Sahil','Seattle');

-- Insert Products
INSERT INTO products VALUES
(101,'Laptop','Electronics',1000.00),
(102,'Phone','Electronics',500.00),
(103,'Headphones','Electronics',120.00),
(104,'Office Chair','Furniture',200.00),
(105,'Desk Lamp','Furniture',40.00),
(106,'Backpack','Accessories',60.00);

-- Insert Orders
INSERT INTO orders VALUES
(1001,1,'2024-01-10'),
(1002,2,'2024-01-15'),
(1003,1,'2024-02-05'),
(1004,3,'2024-03-12'),
(1005,4,'2024-03-18'),
(1006,5,'2024-04-02'),
(1007,2,'2024-04-20'),
(1008,3,'2024-05-01');

-- Insert Order Items
INSERT INTO order_items VALUES
(1001,101,1),
(1001,103,2),
(1002,102,1),
(1002,106,2),
(1003,102,2),
(1003,105,3),
(1004,104,1),
(1004,105,2),
(1005,101,1),
(1005,106,1),
(1006,103,1),
(1006,106,1),
(1007,104,2),
(1007,105,1),
(1008,102,1),
(1008,103,1);


SHOW TABLES;

-- Q1: Total revenue
SELECT ROUND(SUM(p.price * oi.quantity), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- Q2: Revenue by product
SELECT p.product_name,
       ROUND(SUM(p.price * oi.quantity), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Q3: Best-selling products by quantity
SELECT p.product_name,
       SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC;

-- Q4: Monthly revenue trend
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       ROUND(SUM(p.price * oi.quantity), 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Q5: Top customers by total spending
SELECT c.customer_name,
       ROUND(SUM(p.price * oi.quantity), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Q6: Customers spending above average (CTE)
WITH customer_spend AS (
    SELECT c.customer_id,
           c.customer_name,
           SUM(p.price * oi.quantity) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
),
avg_spend AS (
    SELECT AVG(total_spent) AS avg_value
    FROM customer_spend
)
SELECT cs.customer_name,
       ROUND(cs.total_spent, 2) AS total_spent
FROM customer_spend cs
CROSS JOIN avg_spend a
WHERE cs.total_spent > a.avg_value
ORDER BY cs.total_spent DESC;

-- Q7: Rank products by revenue (Window Function)
SELECT product_name,
       revenue,
       DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM (
    SELECT p.product_name,
           SUM(p.price * oi.quantity) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_name
) t
ORDER BY revenue_rank, product_name;
