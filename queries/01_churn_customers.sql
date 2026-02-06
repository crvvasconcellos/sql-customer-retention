-- Project: Customer Retention & Repeat Purchase
-- Author: Cyro Vasconcellos
-- Database: SQLite
-- Description:
-- Customers considered churned are those who made at least one purchase historically
-- but have no orders after 2023-12-31.

SELECT 
    c.customer_id
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_date > '2023-12-31'
);
