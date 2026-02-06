-- Project: Customer Retention & Repeat Purchase
-- Metric: Retained customers (2023 -> 2024)
-- Definition: customers with >= 1 order in 2023 AND >= 1 order in 2024

SELECT
    c.customer_id
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
)
AND EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
);
