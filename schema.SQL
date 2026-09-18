-- ============================================================
-- Sunrise Supermarket - Schema
-- PLSQL Assignment One
-- Written for PostgreSQL. See README.md for Oracle/MySQL notes.
-- ============================================================


CREATE TABLE customers (
    customer_id   INTEGER PRIMARY KEY,
    customer_name VARCHAR(100),
    email         VARCHAR(100),
    city          VARCHAR(50)
);

CREATE TABLE products (
    product_id    INTEGER PRIMARY KEY,
    product_name  VARCHAR(100),
    category      VARCHAR(50),
    price         NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id      INTEGER PRIMARY KEY,
    customer_id   INTEGER REFERENCES customers(customer_id),
    order_date    DATE
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id      INTEGER REFERENCES orders(order_id),
    product_id    INTEGER REFERENCES products(product_id),
    quantity      INTEGER
);
