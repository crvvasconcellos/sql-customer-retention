-- Project: Customer Retention & Repeat Purchase
-- Metric: Retention rate (2024)
-- Definition:
--   Retention 2024 = customers who purchased in BOTH 2023 and 2024
--                    divided by customers who purchased in 2023
-- Notes:
--   - This query counts customers (not orders)
--   - DISTINCT ensures customer-level sets
--   - NULLIF prevents division by zero
--   - 100.0 forces floating-point division in SQLite

WITH customers_2023 AS (
    SELECT DISTINCT
        o.customer_id
    FROM orders o
    WHERE o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
),
customers_2024 AS (
    SELECT DISTINCT
        o.customer_id
    FROM orders o
    WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
)
SELECT
    COUNT(*) AS retained_customers,
    (SELECT COUNT(*) FROM customers_2023) AS base_customers_2023,
    ROUND(
        100.0 * COUNT(*) / NULLIF((SELECT COUNT(*) FROM customers_2023), 0),
        2
    ) AS retention_rate_pct
FROM customers_2023 c23
JOIN customers_2024 c24
  ON c23.customer_id = c24.customer_id;
