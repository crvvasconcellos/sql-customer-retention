-- Repeat Purchase Funnel Analysis
-- Objective: Analyze customer progression from first to subsequent orders
-- and measure conversion rates and time between purchases.

WITH ordered AS (
  SELECT
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER (
      PARTITION BY customer_id
      ORDER BY order_date, order_id
    ) AS order_number
  FROM orders
),

pivot AS (
  SELECT
    customer_id,
    MAX(CASE WHEN order_number = 1 THEN order_date END) AS first_order_date,
    MAX(CASE WHEN order_number = 2 THEN order_date END) AS second_order_date,
    MAX(CASE WHEN order_number = 3 THEN order_date END) AS third_order_date
  FROM ordered
  GROUP BY customer_id
),

counts AS (
  SELECT
    COUNT(*) AS customers_1plus,
    SUM(CASE WHEN second_order_date IS NOT NULL THEN 1 ELSE 0 END) AS customers_2plus,
    SUM(CASE WHEN third_order_date  IS NOT NULL THEN 1 ELSE 0 END) AS customers_3plus
  FROM pivot
),

time_between AS (
  SELECT
    AVG(
      CASE WHEN second_order_date IS NOT NULL
      THEN julianday(second_order_date) - julianday(first_order_date)
      END
    ) AS avg_days_1_to_2,

    AVG(
      CASE WHEN third_order_date IS NOT NULL
      THEN julianday(third_order_date) - julianday(second_order_date)
      END
    ) AS avg_days_2_to_3
  FROM pivot
)

SELECT
  c.customers_1plus,
  c.customers_2plus,
  c.customers_3plus,
  1.0 * c.customers_2plus / c.customers_1plus * 100 AS pct_to_2nd,
  1.0 * c.customers_3plus / NULLIF(c.customers_2plus, 0) * 100 AS pct_to_3rd,
  t.avg_days_1_to_2,
  t.avg_days_2_to_3
FROM counts c
CROSS JOIN time_between t;
