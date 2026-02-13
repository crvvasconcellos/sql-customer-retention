-- 09_customer_lifetime_revenue.sql
-- Customer lifetime revenue (total revenue per customer)

SELECT
  o.customer_id,
  SUM(oi.quantity * oi.item_amount) AS customer_lifetime_revenue
FROM orders o
JOIN order_items oi
  ON oi.order_id = o.order_id
GROUP BY o.customer_id
ORDER BY customer_lifetime_revenue DESC;
