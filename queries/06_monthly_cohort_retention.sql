-- 06_monthly_cohort_retention.sql
-- Goal: Monthly cohort retention table
-- Cohort = month of first order
-- Active = customer placed >= 1 order in a given month
-- Retention rate = active_customers / cohort_size

WITH cohort AS (
  SELECT
    customer_id,
    DATE(MIN(order_date), 'start of month') AS cohort_month
  FROM orders
  GROUP BY customer_id
),
activity AS (
  -- 1 row per customer per active month
  SELECT
    customer_id,
    DATE(order_date, 'start of month') AS activity_month
  FROM orders
  GROUP BY customer_id, DATE(order_date, 'start of month')
),
cohort_activity AS (
  SELECT
    c.customer_id,
    c.cohort_month,
    a.activity_month,
    (
      (CAST(strftime('%Y', a.activity_month) AS INT) - CAST(strftime('%Y', c.cohort_month) AS INT)) * 12
      + (CAST(strftime('%m', a.activity_month) AS INT) - CAST(strftime('%m', c.cohort_month) AS INT))
    ) AS month_index
  FROM cohort c
  JOIN activity a
    ON a.customer_id = c.customer_id
  -- Optional safety (should already be true):
  -- WHERE a.activity_month >= c.cohort_month
),
cohort_sizes AS (
  SELECT
    cohort_month,
    COUNT(*) AS cohort_size
  FROM cohort
  GROUP BY cohort_month
)
SELECT
  ca.cohort_month,
  ca.month_index,
  cs.cohort_size,
  COUNT(DISTINCT ca.customer_id) AS active_customers,
  1.0 * COUNT(DISTINCT ca.customer_id) / cs.cohort_size AS retention_rate
FROM cohort_activity ca
JOIN cohort_sizes cs
  ON cs.cohort_month = ca.cohort_month
GROUP BY
  ca.cohort_month,
  ca.month_index,
  cs.cohort_size
ORDER BY
  ca.cohort_month,
  ca.month_index;
