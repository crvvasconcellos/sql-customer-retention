# Customer Retention & Repeat Purchase (SQLite)

Goal
Analyze customer behavior using SQL: churn logic, retention (2023→2024), repeat purchase speed, and top products by country.

Dataset (SQLite)
Tables:

customers(customer_id, name, country, signup_date, age)

orders(order_id, customer_id, order_date, amount)

order_items(order_item_id, order_id, product, quantity, item_amount)

Business Definitions

Churned customer (after 2023): customer with at least one order historically, and no orders after 2023-12-31.

Retained customer (2023→2024): customer with ≥1 order in 2023 and ≥1 order in 2024.

Retention rate 2024: retained customers / customers who purchased in 2023.

Fast return: second order happened within 30 days of the first order.
