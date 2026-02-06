# Customer Retention & Repeat Purchase (SQL / SQLite)

## Overview
This project analyzes customer behavior using SQL, focusing on customer churn,
retention between periods (2023 → 2024), repeat purchase patterns, and product
performance by country.

The goal is to demonstrate analytical SQL skills commonly required for
Data Analyst, BI Analyst, and Business Analyst roles, with emphasis on
business logic, metric definition, and clear reasoning.

---

## Business Questions Answered
- Which customers are considered churned after 2023?
- How many customers were retained from 2023 to 2024?
- What is the customer retention rate for 2024?
- How quickly do customers place a second order?
- Which products perform best by country?

---

## Database Schema
The analysis uses a simplified transactional model:

- **customers**: one row per customer  
- **orders**: one row per order (1:N relationship with customers)  
- **order_items**: line items per order (1:N relationship with orders)

The full schema definition is available in `schema/schema.sql`.

---

## Metrics Definitions
- **Churned customer (after 2023)**: customer with at least one historical order
  and no orders after `2023-12-31`.
- **Retained customer (2023 → 2024)**: customer with at least one order in 2023
  and at least one order in 2024.
- **Retention rate 2024**: retained customers divided by customers who purchased
  in 2023.
- **Fast repeat purchase**: second order placed within 30 days of the first order.

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
