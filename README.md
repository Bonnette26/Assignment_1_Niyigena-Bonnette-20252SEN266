# Assignment 1 — JOINs, CTEs & Window Functions

**Student Name:** Niyigena Bonnette
**Student ID:** 20252SEN266
**DBMS Used:** Oracle SQL DEVELOPER

---

## Business Scenario — Sunrise Supermarket

Sunrise Supermarket sells products to customers who place orders containing
one or more items. Management wants to understand who their customers are,
what they buy, and how sales are trending over time.

Sample data: at least 5 customers, 8 products(across at least 3 categories), 15 orders, and 25 order items.

---

## QJ1 — Orders with Customer Name, City, Date (INNER JOIN)

SELECT o.order_id, c.customer_name, c.city, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

**What it answers:** Which customer placed each order, where they live, and when.

---

## QJ2 — Order Items with Product Details (JOIN)

SELECT oi.order_item_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

**What it answers:** What products were ordered, their category, price, quantity.

---

## QJ3 — All Customers + Orders (LEFT JOIN)

SELECT c.customer_name, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

**What it answers:** Every customer, including those who never ordered (NULLs).

---

## QC1 — Above-Average Spenders (CTE)

WITH customer_totals AS (
  SELECT c.customer_id, c.customer_name,
         SUM(oi.quantity * p.price) AS total_spent
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_spent
FROM customer_totals
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_totals);

**What it answers:** Customers spending more than the average.

---

## QW1 — Rank Customers by Total Spent

SELECT c.customer_name,
       SUM(oi.quantity * p.price) AS total_spent,
       RANK() OVER (ORDER BY SUM(oi.quantity * p.price) DESC) AS rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_name;

**What it answers:** Customer ranking from biggest to smallest spender.

---

## QW2 — Number Each Customer's Orders

SELECT customer_id, order_id, order_date,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_num
FROM orders;

**What it answers:** 1st, 2nd, 3rd… order per customer.

---

## QW3 — Running Total of Revenue

SELECT o.order_date,
       SUM(oi.quantity * p.price) AS daily_revenue,
       SUM(SUM(oi.quantity * p.price)) OVER (ORDER BY o.order_date) AS running_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_date
ORDER BY o.order_date;

**What it answers:** How revenue accumulates day by day.

---

## QW4 — Days Between Consecutive Orders

SELECT customer_id, order_id, order_date,
       order_date - LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS days_gap
FROM orders;

**What it answers:** Gap in days between consecutive orders.

---

## Business Interpretation

- Top customers: Mary (27.10), John (24.90) — highest spenders.
- Kigali has the most customers → strongest market.
- Dairy and Grains are most purchased categories.
- Total revenue = 209.90 by Feb 14, 2026 (steady growth).
- Customers reorder within 5–21 days → good loyalty.
- Recommendation: Loyalty program for top spenders; focus on Kigali.

---

## Challenges & Resolutions

| Challenge | Resolution |
|-----------|------------|
| Filtering by average needed 2 steps. | Used CTE then filter in main query. |
| Ties in spending (Tom & Eric). | Used RANK() so ties share rank. |
| Date math differs by DBMS. | Oracle uses date - date; MySQL uses DATEDIFF(). |
| Avoiding double-counted revenue. | Used SUM + GROUP BY before windowing. |

---

## How to Run

1. Run `schema.sql` to create tables.
2. Run `data.sql` to insert sample data.
3. Run `queries.sql` to execute Q1–Q8.
4. Compare results with screenshots.
