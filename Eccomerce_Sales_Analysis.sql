--
-- =========================================================== =================================================
--- PROJECT: E-commerce Sales and Customer Behavior Analysis
-- Description: Data Cleaning,
-- TOOLS: MySQL Workbench
-- DATABASE: SQL_Analysis
--
-- =================================================================================================================



-- ==================================================================================================================


-- Select the Project database
USE sql_analysis;

-- Display the table available in the database
show TABLES;

-- ===========================================================
--- STAGE 2: INSPECT THE TABLE STRUCTURE
-- ===========================================================
DESCRIBE customers;
DESCRIBE ORDER_ITEMS;
DESCRIBE ORDERS;
DESCRIBE PAYMENTS;
DESCRIBE PRODUCTS;
DESCRIBE REFUNDS;
-- ============================================================
-- STAGE 3: VALIDATE YOUR DATA
-- ============================================================

-- 1 Count the records in each table
 select 'customers' as table_name, count(*) as total_rows from customers
union all
 select 'order_items', count(*) as total_rows from order_items
union all
select 'orders',    count(*) as total_rows from orders
 union all
select 'payments',  count(*) as total_rows from payments
union all
 select 'products', count(*) as total_rows from products
 union all
 select 'refunds',  count(*) as total_rows from refunds;

-- 2 check for missing value in the orders table 
select
count(*) as total_rows,
sum(order_id is null) as missing_order_ids, 
sum(customer_id is null) as missing_customer_ids,
sum(ordered_at_new is null) as missing_order_date
from orders;

-- 3. check for duplicate order IDs
select order_id,
count(*) as occurrences
from orders
group by order_id
having count(*) > 1


-- ===================================================
-- STAGE 4: TABLE RELATIONSHIPS
-- ===================================================

-- confirming the linking column between tables 
select
o.order_id, 
o.customer_id,
oi.product_id,
p.payment_id,
r.refund_id
from orders o
left join order_items oi on o.order_id = oi.order_id
left join payments p on o.order_id = p.order_id
left join refunds r on o.order_id = r.order_id
limit 5;


-- =====================================================
-- STAGE 5: ANALYZE OVERALL SALES
-- =====================================================
-- Total Orders and Total Revenue
select 
count(distinct o.order_id) as total_orders,
sum(oi.line_total) as total_revenue
from orders o
join order_items oi on o.order_id = oi.order_id
where o.order_status = 'completed';

-- Monthly Sales Trend
select 
date_format(o.ordered_at_new, '%y-%m') as sales_month,
count(distinct o.order_id) as total_orders,
sum(oi.line_total) as total_revenue
from orders o
join order_items oi on o.order_id = oi.order_id
where o.order_status = 'completed'
group by date_format(o.ordered_at_new, '%y-%m')
order by sales_month;

-- =====================================================
-- STAGE 6: ANALYZE PRODUCT PERFORMANCE
-- =====================================================
-- Top 10 Product by Revenue
select
p.product_name,
s.unit_sold,
s.total_revenue
from(
select oi.product_id, 
sum(oi.quantity) as unit_sold, sum(oi.line_total) as total_revenue
from order_items oi
join orders o on oi.order_id = o.order_id
where o.order_status = 'completed' group by oi.product_id) s
join products p on s.product_id = p.product_id
order by s.total_revenue desc
limit 10;

-- =====================================================================
-- STAGE 7: ANALYZE CUSTOMER BEHAVIOUR
-- =====================================================================
-- Top Ten Customers by Spending
select
c.customer_id, c.country_code, c.customer_segment, s.total_spend, s.total_orders
from( select
o.customer_id, 
sum(oi.line_total) as total_spend,
count(distinct o.order_id) total_orders
from orders o
join order_items oi on o.order_id = oi.order_id
where o.order_status = 'completed'
group by o.customer_id) s
join customers c on s.customer_id = c.customer_id
order by s.total_spend desc
limit 10


-- ========================================================================
-- STAGE 8: ANALYZE ORDER TRENDS
-- ========================================================================
-- Top 10 Busiest Order Dates
select 
date(ordered_at_new) as order_date,
count(distinct order_id) as total_orders
from orders
group by date(ordered_at_new)
order by total_orders desc
limit 10

-- =============================================================
-- STAGE 9: ANALYZE PAYMENTS
-- =============================================================
-- Payment Method Analysis
select 
payment_method,
count(payment_id) as total_payments,
sum(amount) as total_amount
from payments
group by payment_method
order by total_amount desc;

-- ===============================================================
-- STAGE 10; ANALYZE REFUNDS
-- ===============================================================
-- Total Revenue and Total Amount
select
count(refund_id) as total_refund, 
sum(amount) as total_refund_amount
from refunds;