-- 08_revenue_kpis.sql
-- Revenue KPIs: Total Revenue, Orders, Customers, AOV, ARPU

WITH base AS (
  SELECT
    o.order_id,
    o.customer_id,
    oi.quantity * oi.item_amount AS line_revenue
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
)

SELECT
  -- Core metrics
  SUM(line_revenue) AS total_revenue,
  COUNT(DISTINCT order_id) AS total_orders,
  COUNT(DISTINCT customer_id) AS total_customers,

  -- Average Order Value
  SUM(line_revenue) * 1.0 
    / NULLIF(COUNT(DISTINCT order_id), 0) AS avg_order_value,

  -- Average Revenue Per User
  SUM(line_revenue) * 1.0
    / NULLIF(COUNT(DISTINCT customer_id), 0) AS arpu

FROM base;
