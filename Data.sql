-- ============================================================
-- Sunrise Supermarket - Sample Data
-- 8 customers (1 with no orders), 8 products (4 categories),
-- 15 orders, 25 order items, spread across Jan-May 2026.
-- ============================================================
INSERT INTO customers VALUES
(1, 'John', 'john@gmail.com', 'Kigali');

INSERT INTO customers VALUES
(2, 'Mary', 'mary@gmail.com', 'Huye');

INSERT INTO customers VALUES
(3, 'Jenn', 'Jenn@gmail.com', 'Kigali');

INSERT INTO customers VALUES
(4, 'Ann', 'ann@gmail.com', 'Musanze');

INSERT INTO customers VALUES
(5, 'Tom', 'tom@gmail.com', 'Rubavu');
commit;
select * from customers;
INSERT INTO products VALUES(1, 'Milk', 'Dairy', 1.20);
INSERT INTO products VALUES(2, 'Bread', 'Bakery', 0.80);
INSERT INTO products VALUES (3, 'Rice', 'Grains', 2.50);
INSERT INTO products VALUES (4, 'Beans', 'Grains', 1.80);
INSERT INTO products VALUES (5, 'Cheese', 'Dairy', 3.50);
INSERT INTO products VALUES (6, 'Cake', 'Bakery', 5.00);
INSERT INTO products VALUES (7, 'Sugar', 'Groceries', 1.00);
INSERT INTO products VALUES (8, 'Cooking Oil', 'Groceries', 4.20);
select * from products;

INSERT INTO orders VALUES (1, 1, DATE '2026-01-05');
INSERT INTO orders VALUES (2, 2, DATE '2026-01-07');
INSERT INTO orders VALUES (3, 1, DATE '2026-01-10');
INSERT INTO orders VALUES (4, 3, DATE '2026-01-12');
INSERT INTO orders VALUES (5, 4, DATE '2026-01-15');
INSERT INTO orders VALUES (6, 5, DATE '2026-01-18');
INSERT INTO orders VALUES (7, 2, DATE '2026-01-20');
INSERT INTO orders VALUES (8, 6, DATE '2026-01-22');
INSERT INTO orders VALUES (9, 1, DATE '2026-01-25');
INSERT INTO orders VALUES (10, 3, DATE '2026-01-28');
INSERT INTO orders VALUES (11, 4, DATE '2026-02-01');
INSERT INTO orders VALUES (12, 5, DATE '2026-02-04');
INSERT INTO orders VALUES (13, 6, DATE '2026-02-07');
INSERT INTO orders VALUES (14, 2, DATE '2026-02-10');
INSERT INTO orders VALUES (15, 1, DATE '2026-02-14');
select * from orders;

INSERT INTO order_items VALUES (1, 1, 1, 5);
INSERT INTO order_items VALUES (2, 1, 2, 3);
INSERT INTO order_items VALUES (3, 2, 3, 2);
INSERT INTO order_items VALUES (4, 2, 5, 1);
INSERT INTO order_items VALUES (5, 3, 4, 4);
INSERT INTO order_items VALUES (6, 3, 8, 2);
INSERT INTO order_items VALUES (7, 4, 6, 1);
INSERT INTO order_items VALUES (8, 4, 7, 6);
INSERT INTO order_items VALUES (9, 5, 1, 10);
INSERT INTO order_items VALUES (10, 5, 3, 5);
INSERT INTO order_items VALUES (11, 6, 2, 8);
INSERT INTO order_items VALUES (12, 6, 5, 2);
INSERT INTO order_items VALUES (13, 7, 4, 3);
INSERT INTO order_items VALUES (14, 7, 8, 1);
INSERT INTO order_items VALUES (15, 8, 6, 2);
INSERT INTO order_items VALUES (16, 8, 7, 4);
INSERT INTO order_items VALUES (17, 9, 1, 6);
INSERT INTO order_items VALUES (18, 9, 2, 5);
INSERT INTO order_items VALUES (19, 10, 3, 7);
INSERT INTO order_items VALUES (20, 10, 5, 3);
INSERT INTO order_items VALUES (21, 11, 6, 1);
INSERT INTO order_items VALUES (22, 11, 8, 2);
INSERT INTO order_items VALUES (23, 12, 4, 5);
INSERT INTO order_items VALUES (24, 12, 7, 3);
INSERT INTO order_items VALUES (25, 13, 1, 4);
