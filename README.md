# Customer Retention & Repeat Purchase (SQL / SQLite)

## Overview
This project analyzes customer behavior using SQL, focusing on customer churn,
retention between periods (2023 → 2024), repeat purchase patterns, and product
performance by country.

It applies common metrics used by product, marketing, and revenue teams to
evaluate customer health and engagement.

---

## Business Questions Answered
- Which customers are considered churned after 2023?
- Which customers were retained from 2023 to 2024?
- What is the customer retention rate for 2024?
- How quickly do customers place a second order?
- Which products perform best by country?
- How many customers remain active in the months following their first purchase?
---

## Queries
- Churned customers after 2023: `queries/01_churn_customers.sql`
- Retained customers (2023 → 2024): `queries/02_retained_customers_2023_2024.sql`
- Retention rate for 2024: `queries/03_retention_rate_2024.sql`
- Fast repeat purchase (second order within 30 days): `queries/04_repeat_purchase_within_30_days.sql`
- Top product by country (by quantity): `queries/05_top_products_by_country.sql`
- Monthly cohort retention (cohort month + month index + retention rate): `queries/06_monthly_cohort_retention.sql`


---

## Database Schema
The analysis uses a simplified transactional model:

- **customers**: one row per customer  
- **orders**: one row per order (1:N relationship with customers)  
- **order_items**: line items per order (1:N relationship with orders)

The full schema definition is available in `schema/schema.sql`.

---

## Metrics Definitions
- **Churned customer (after 2023)**: customer with at least one order historically
  and no orders after `2023-12-31`.
- **Retained customer (2023 → 2024)**: customer with at least one order in 2023
  and at least one order in 2024.
- **Retention rate 2024**: retained customers divided by customers who purchased
  in 2023.
- **Fast repeat purchase**: second order placed within 30 days of the first order.
- **Cohort month**: month of customer’s first order (truncated to month)
- **Active customer (monthly)**: customer with at least one order in a month
- **Monthly retention rate**: active_customers / cohort_size for each cohort_month and month_index
---

## Skills Demonstrated
- Analytical SQL for behavioral analysis (EXISTS / NOT EXISTS, CTEs)
- Time-based customer metrics (churn, retention, repeat purchase)
- Window functions for sequence and interval analysis
- Business-oriented metric definition and validation

---

## Notes
- Data is modeled for analytical demonstration purposes.
- The focus is on correctness, clarity, and business reasoning rather than data volume.
