-- PROJECT: E-commerce Sales and Customer Behavior Analysis
-- DATABASE: sql_analysis | TOOL: MySQL / MySQL Workbench
-- These are exploration, validation, and analysis queries.
-- The validation queries do not modify or clean source tables.

USE sql_analysis;

-- STAGE 1: Explore available tables
SHOW TABLES;

-- STAGE 2: Inspect table structures
DESCRIBE customers;
DESCRIBE order_items;
DESCRIBE orders;
DESCRIBE payments;
DESCRIBE products;
DESCRIBE refunds;

-- STAGE 3: Validate data
-- 3.1 Count records in each table
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'refunds', COUNT(*) FROM refunds;

-- 3.2 Check selected missing values in orders
SELECT
    COUNT(*) AS total_rows,
    SUM(order_id IS NULL) AS missing_order_ids,
    SUM(customer_id IS NULL) AS missing_customer_ids,
    SUM(ordered_at_new IS NULL) AS missing_order_dates
FROM orders;

-- 3.3 Find duplicate order IDs, if any
SELECT order_id, COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- STAGE 4: Inspect relationships across tables
-- Caution: multiple one-to-many joins can multiply rows.
-- This is a small relationship inspection, not an aggregate.
SELECT
    o.order_id,
    o.customer_id,
    oi.product_id,
    p.payment_id,
    r.refund_id
FROM orders AS o
LEFT JOIN order_items AS oi ON o.order_id = oi.order_id
LEFT JOIN payments AS p ON o.order_id = p.order_id
LEFT JOIN refunds AS r ON o.order_id = r.order_id
LIMIT 5;

-- STAGE 5: Overall sales for completed orders
-- Revenue here means the sum of order-item line totals.
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.line_total) AS total_revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
WHERE o.order_status = 'completed';

-- Monthly completed-order trends.
-- YYYY-MM format preserves chronological sorting.
SELECT
    DATE_FORMAT(o.ordered_at_new, '%Y-%m') AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.line_total) AS total_revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
WHERE o.order_status = 'completed'
GROUP BY DATE_FORMAT(o.ordered_at_new, '%Y-%m')
ORDER BY sales_month;

-- STAGE 6: Product performance among completed orders
SELECT
    p.product_name,
    s.unit_sold,
    s.item_line_revenue
FROM (
    SELECT
        oi.product_id,
        SUM(oi.quantity) AS unit_sold,
        SUM(oi.line_total) AS total_revenue
    FROM order_items AS oi
    JOIN orders AS o ON oi.order_id = o.order_id
    WHERE o.order_status = 'completed'
    GROUP BY oi.product_id
) AS s
JOIN products AS p ON s.product_id = p.product_id
ORDER BY s.item_line_revenue DESC
LIMIT 10;

-- STAGE 7: Customer spending among completed orders
SELECT
    c.customer_id,
    c.country_code,
    c.customer_segment,
    s.total_spend,
    s.total_orders
FROM (
    SELECT
        o.customer_id,
        SUM(oi.line_total) AS total_spend,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM orders AS o
    JOIN order_items AS oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'completed'
    GROUP BY o.customer_id
) AS s
JOIN customers AS c ON s.customer_id = c.customer_id
ORDER BY s.total_spend DESC
LIMIT 10;

-- STAGE 8: Busiest order dates
-- Includes all order statuses, not only completed orders.
SELECT
    DATE(ordered_at_new) AS order_date,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY DATE(ordered_at_new)
ORDER BY total_orders DESC
LIMIT 10;

-- STAGE 9: Payment method analysis
SELECT
    payment_method,
    COUNT(payment_id) AS total_payments,
    SUM(amount) AS total_payment_amount
FROM payments
GROUP BY payment_method
ORDER BY total_payment_amount DESC;

-- STAGE 10: Refund analysis
SELECT
    COUNT(refund_id) AS total_refund_records,
    SUM(amount) AS total_refund_amount
FROM refunds;
