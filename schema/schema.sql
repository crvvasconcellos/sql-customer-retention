-- Database schema for Customer Retention analysis
-- SQLite

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    country TEXT,
    signup_date DATE,
    age INTEGER
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product TEXT,
    quantity INTEGER,
    item_amount REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
