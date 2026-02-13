-- 10_pareto_80_list.sql
-- Pareto (80% revenue): list customers by revenue with cumulative share
-- and flag the smallest group of top customers whose cumulative revenue >= 80%.

WITH customer_rev AS (
  SELECT
    o.customer_id,
    SUM(oi.quantity * oi.item_amount) AS customer_revenue
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
  GROUP BY o.customer_id
),

ranked AS (
  SELECT
    customer_id,
    customer_revenue,
    ROW_NUMBER() OVER (ORDER BY customer_revenue DESC) AS rn,
    COUNT(*) OVER () AS total_customers,
    SUM(customer_revenue) OVER () AS total_revenue,
    SUM(customer_revenue) OVER (
      ORDER BY customer_revenue DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue,
    SUM(customer_revenue) OVER (
      ORDER BY customer_revenue DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) * 1.0 / NULLIF(SUM(customer_revenue) OVER (), 0) AS cumulative_share
  FROM customer_rev
),

cutoff AS (
  SELECT
    MIN(rn) AS cutoff_rn
  FROM ranked
  WHERE cumulative_share >= 0.80
)

SELECT
  r.customer_id,
  r.customer_revenue,
  r.rn,
  r.total_customers,
  r.total_revenue,
  r.cumulative_revenue,
  ROUND(r.cumulative_share, 4) AS cumulative_share,
  c.cutoff_rn,
  CASE WHEN r.rn <= c.cutoff_rn THEN 1 ELSE 0 END AS is_in_80_percent_group
FROM ranked r
CROSS JOIN cutoff c
ORDER BY r.rn;
