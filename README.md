<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=700&size=28&pause=1000&color=00B4D8&center=true&vCenter=true&width=800&height=70&lines=🗄️+SQL+Data+Analysis+Portfolio;CTEs+·+Window+Functions+·+Joins+·+Subqueries;MySQL+8.0+·+6+Modules+·+39+Commits;Mini+Project+%7C+$11%2C120+Revenue+Analyzed" alt="Typing SVG" />

<br/>

![MySQL](https://img.shields.io/badge/MySQL_8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Advanced-003B57?style=for-the-badge&logo=postgresql&logoColor=white)
![CTEs](https://img.shields.io/badge/CTEs-Window_Functions-00B4D8?style=for-the-badge&logo=mysql&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

[![Stars](https://img.shields.io/github/stars/Reyazgitwork/sql-data-analysis-fundamentals?style=social)](https://github.com/Reyazgitwork/sql-data-analysis-fundamentals/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/Reyazgitwork/sql-data-analysis-fundamentals?color=00B4D8)](https://github.com/Reyazgitwork/sql-data-analysis-fundamentals/commits/main)
![Commits](https://img.shields.io/badge/Commits-39-00B4D8?style=flat-square)
![Profile Views](https://komarev.com/ghpvc/?username=Reyazgitwork&label=Profile+Views&color=00B4D8&style=flat-square)

</div>

---

## 📌 Overview

A structured **SQL analytics portfolio** built on MySQL 8.0, progressing from core querying fundamentals through advanced analytical patterns — CTEs, window functions, multi-table joins, and subqueries — culminating in a full **mini e-commerce relational database project** with real business insight generation.

Every file is production-style: commented logic, clean formatting, business-context queries.

---

## 🏆 Mini Project — Key Results

<div align="center">

| 📊 Business Question | 🔍 Answer |
|:---|:---|
| 💰 **Total Revenue** | **$11,120** across all orders |
| 🥇 **Top Products by Revenue** | Laptop & Phone — tied for #1 rank |
| 👤 **Top Spending Customers** | Identified via subquery above-average spend filter |
| 📅 **Peak Revenue Month** | January 2024 recorded the highest monthly revenue |
| 📦 **Revenue Concentration** | Electronics dominate — high-priced SKUs drive majority of revenue |
| 🏆 **Ranking Method** | `DENSE_RANK()` over revenue — no gaps for tied products |

</div>

---

## 📅 Module Breakdown

### 🟢 Day 1 — SQL Basics
> `day1_basics.sql`

Database & table creation, data insertion, filtering, sorting, and basic aggregations.

```sql
-- Top 3 highest paid employees
SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Count employees per department
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;
```

---

### 🟢 Day 2 — Aggregation & Grouping
> `day2_groupby.sql`

GROUP BY logic, HAVING filters, multi-column ordering, continent and department-level analysis.

```sql
-- Departments with average salary above 60,000
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000
ORDER BY avg_salary DESC;
```

---

### 🟢 Day 3 — JOIN Operations
> `day3_joins.sql`

INNER JOIN, LEFT JOIN, multi-table relationships, aggregation after joining.

```sql
-- Total sales per customer using JOIN
SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;
```

---

### 🟢 Day 4 — Subqueries
> `day4_subqueries.sql`

Subqueries in WHERE, nested aggregate comparisons, IN operator, derived table workarounds.

```sql
-- Customers who spend above the average order value
SELECT customer_name, total_spent
FROM (
    SELECT c.customer_name, SUM(o.amount) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
) AS customer_totals
WHERE total_spent > (SELECT AVG(amount) FROM orders);
```

---

### 🟢 Day 5 — CTEs (WITH Clause)
> `day5_cte.sql`

Modular query structuring, improved readability over nested subqueries, analytical decomposition.

```sql
-- CTE: Monthly revenue with running total
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(amount)                       AS revenue
    FROM orders
    GROUP BY month
)
SELECT
    month,
    revenue,
    SUM(revenue) OVER (ORDER BY month) AS running_total
FROM monthly_revenue;
```

---

### 🟢 Day 6 — Window Functions
> `day6_window_functions.sql`

ROW_NUMBER(), RANK(), DENSE_RANK() — analytical ranking queries.

```sql
-- Rank products by revenue — no gaps for ties
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price)        AS total_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    )                                        AS revenue_rank
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;
```

---

## 🛒 Mini Project — E-Commerce SQL Analysis

### Database Schema

```
┌─────────────┐       ┌──────────────┐       ┌─────────────┐
│  customers  │       │    orders    │       │  products   │
│─────────────│       │──────────────│       │─────────────│
│ customer_id │◄──┐   │ order_id  PK │   ┌──►│ product_id  │
│ name        │   └───│ customer_id  │   │   │ name        │
│ email       │       │ order_date   │   │   │ price       │
│ city        │       │ total_amount │   │   │ category    │
└─────────────┘       └──────┬───────┘   │   └─────────────┘
                             │           │
                      ┌──────▼───────┐   │
                      │ order_items  │   │
                      │──────────────│   │
                      │ item_id   PK │   │
                      │ order_id  FK │   │
                      │ product_id ──┘───┘
                      │ quantity     │
                      │ unit_price   │
                      └──────────────┘
```

### Business Questions Answered

| Question | SQL Technique Used |
|----------|-------------------|
| What is total revenue? | `SUM()` aggregation |
| Which products rank highest by revenue? | `DENSE_RANK()` window function |
| Which customers spend above average? | Subquery with nested `AVG()` |
| What is the monthly revenue trend? | `DATE_FORMAT()` + `GROUP BY` + CTE |
| Who are the top spending customers? | `JOIN` + `GROUP BY` + `ORDER BY` |

---

## 🗂️ Repository Structure

```
sql-data-analysis-fundamentals/
│
├── day1_basics.sql              # SELECT, WHERE, ORDER BY, basic aggregates
├── day2_groupby.sql             # GROUP BY, HAVING, multi-column analysis
├── day3_joins.sql               # INNER JOIN, LEFT JOIN, multi-table queries
├── day4_subqueries.sql          # Nested queries, IN operator, derived tables
├── day5_cte.sql                 # WITH clause, modular query structuring
├── day6_window_functions.sql    # ROW_NUMBER, RANK, DENSE_RANK
│
├── mini_project/
│   ├── mini_project_ecommerce.sql   # Full e-commerce relational analysis
│   ├── screenshots/                 # Query output screenshots
│   └── README.md                    # Mini project documentation
│
└── README.md
```

> Each `.sql` file contains commented queries explaining the logic, business context, and output interpretation.

---

## ⚙️ How to Run

### Requirements
- MySQL 8.0+
- MySQL Workbench or any MySQL client (DBeaver, TablePlus, CLI)

### Setup
```bash
# Clone the repo
git clone https://github.com/Reyazgitwork/sql-data-analysis-fundamentals.git
cd sql-data-analysis-fundamentals

# Open MySQL Workbench and run files in order:
# day1 → day2 → day3 → day4 → day5 → day6 → mini_project
```

### Run Mini Project
```sql
-- In MySQL Workbench or CLI
SOURCE mini_project/mini_project_ecommerce.sql;
```

---

## 🧠 Concepts Covered

| Concept | File |
|---------|------|
| SELECT, WHERE, ORDER BY, LIMIT | `day1_basics.sql` |
| GROUP BY, HAVING, COUNT, SUM, AVG | `day2_groupby.sql` |
| INNER JOIN, LEFT JOIN, multi-table | `day3_joins.sql` |
| Subqueries, IN, nested aggregates | `day4_subqueries.sql` |
| CTEs (WITH clause), modular queries | `day5_cte.sql` |
| ROW_NUMBER, RANK, DENSE_RANK | `day6_window_functions.sql` |
| Full relational DB design + analysis | `mini_project/` |

---

## 🤝 Connect

<div align="center">

**Mohammad Reyaz Shaik** — Analytics Engineer · SQL · dbt · Snowflake · Airflow

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mohammad-reyaz-shaik)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Reyazgitwork)
[![Portfolio](https://img.shields.io/badge/More_Projects-View_All-00B4D8?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Reyazgitwork)

<br/>

<sub>Built with 🗄️ MySQL 8.0 · Advanced SQL · Real business context</sub>

</div>
