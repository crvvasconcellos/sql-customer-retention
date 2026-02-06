-- Project: Customer Retention & Repeat Purchase
-- Metric: Fast repeat purchase (second order within 30 days)
-- Definition:
--   A customer is considered a "fast repeater" if their SECOND order
--   happens within 30 days of their FIRST order.
-- Notes:
--   - Uses ROW_NUMBER to identify the 2nd order per customer
--   - Uses LAG to get the previous order date
--   - julianday() is used for date differences in SQLite

WITH ranked_orders AS (
    SELECT
        o.customer_id,
        o.order_date,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date
        ) AS order_rank,
        LAG(o.order_date) OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date
        ) AS prev_order_date
    FROM orders o
)
SELECT
    customer_id,
    CAST(julianday(order_date) - julianday(prev_order_date) AS INTEGER) AS days_between_orders
FROM ranked_orders
WHERE order_rank = 2
  AND (julianday(order_date) - julianday(prev_order_date)) <= 30;
