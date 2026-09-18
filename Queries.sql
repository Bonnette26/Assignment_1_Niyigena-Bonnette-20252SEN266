-- ============================================================
-- Sunrise Supermarket - Assignment Queries
-- Each question below matches the assignment numbering.
-- Run schema.sql then Data.sql before these.
-- ============================================================

-- ------------------------------------------------------------
-- Q1. List every order with the customer's name and city, and the order date.
-- (INNER JOIN: orders + customers)
-- ------------------------------------------------------------
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date;


-- ------------------------------------------------------------
-- Q2. List every order item with the product name, category, price, and
-- quantity ordered. (JOIN: order_items + products)
-- ------------------------------------------------------------
SELECT
    oi.order_item_id,
    p.product_name,
    p.category,
    p.price,
    oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id, oi.order_item_id;


-- ------------------------------------------------------------
-- Q3. List all customers and, where they exist, their orders -
-- including customers who have never placed an order.
-- (LEFT JOIN: customers + orders)
-- ------------------------------------------------------------
SELECT
    c.customer_name,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_name;


-- ------------------------------------------------------------
-- Q4. Each customer's total amount spent (quantity x price, summed across
-- all order items), returning only customers who spent above the average
-- customer spend. (CTE for per-customer totals, then filter vs. average.)
-- ------------------------------------------------------------
WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o        ON o.customer_id = c.customer_id
    JOIN order_items oi  ON oi.order_id = o.order_id
    JOIN products p      ON p.product_id = oi.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spent
FROM customer_totals
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_totals)
ORDER BY total_spent DESC;


-- ------------------------------------------------------------
-- Q5. Rank customers by total amount spent, highest first.
-- (Window function: RANK())
-- ------------------------------------------------------------
WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o        ON o.customer_id = c.customer_id
    JOIN order_items oi  ON oi.order_id = o.order_id
    JOIN products p      ON p.product_id = oi.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
FROM customer_totals
ORDER BY spend_rank;


-- ------------------------------------------------------------
-- Q6. Number each customer's orders in the order they were placed.
-- (Window function: ROW_NUMBER() partitioned by customer)
-- ------------------------------------------------------------
SELECT
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_sequence
FROM orders
ORDER BY customer_id, order_sequence;


-- ------------------------------------------------------------
-- Q7. Show a running total of revenue over time, ordered by order date.
-- (Window function: SUM() OVER ... running total)
-- ------------------------------------------------------------
WITH order_revenue AS (
    SELECT
        o.order_id,
        o.order_date,
        SUM(oi.quantity * p.price) AS order_revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    GROUP BY o.order_id, o.order_date
)
SELECT
    order_id,
    order_date,
    order_revenue,
    SUM(order_revenue) OVER (ORDER BY order_date, order_id
                              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM order_revenue
ORDER BY order_date, order_id;


-- ------------------------------------------------------------
-- Q8. For each customer with more than one order, show how many days
-- passed between their current and previous order.
-- (Window function: LAG())
-- ------------------------------------------------------------
WITH customer_order_gaps AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date
    FROM orders
)
SELECT
    customer_id,
    order_id,
    order_date,
    previous_order_date,
    (order_date - previous_order_date) AS days_since_previous_order
FROM customer_order_gaps
WHERE previous_order_date IS NOT NULL
ORDER BY customer_id, order_date;
