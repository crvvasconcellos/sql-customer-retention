-- Project: Customer Retention & Repeat Purchase
-- Metric: Top product by country (by quantity)
-- Definition:
--   For each country, return the product with the highest total quantity sold.
-- Notes:
--   - Aggregates at (country, product)
--   - ROW_NUMBER selects the top product per country
--   - Uses order_items because quantity is at item-level (not order-level)

WITH product_sales AS (
    SELECT
        c.country,
        oi.product,
        SUM(oi.quantity) AS total_quantity
    FROM customers c
    JOIN orders o
      ON o.customer_id = c.customer_id
    JOIN order_items oi
      ON oi.order_id = o.order_id
    GROUP BY c.country, oi.product
),
ranked AS (
    SELECT
        country,
        product,
        total_quantity,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_quantity DESC
        ) AS rn
    FROM product_sales
)
SELECT
    country,
    product,
    total_quantity
FROM ranked
WHERE rn = 1;
