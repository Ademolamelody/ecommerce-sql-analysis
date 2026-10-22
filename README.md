# E-commerce Sales and Customer Behavior Analysis | SQL Portfolio Project

## Project Overview

This project uses SQL to analyze e-commerce sales, customer purchasing behavior, product performance, payment methods, and refunds.

Using MySQL, I explored the dataset to identify sales trends, top-performing products, valuable customers, payment patterns, and refund activity. I also performed data validation checks to examine table structures, record counts, missing values, and duplicate order IDs.

The goal of this project is to demonstrate how SQL can be used to investigate business questions and generate insights that support data-driven decision-making.

## Business Questions

This analysis addresses the following questions:

1. How many records are stored in each database table?
2. Are there missing values or duplicate order IDs in the orders table?
3. What are the total completed orders and revenue?
4. How does revenue change over time?
5. Which products generate the highest revenue?
6. Which customers spend the most?
7. Which dates have the highest number of orders?
8. Which payment methods account for the highest transaction amounts?
9. How many refunds were recorded, and what is their total value?

## Database Tables

The project uses six tables:

- **Customers:** Customer identifiers, country codes, and customer segments.
- **Products:** Product identifiers and product names.
- **Orders:** Order identifiers, customer identifiers, order dates, and order statuses.
- **Order Items:** Product quantities, product identifiers, order identifiers, and line totals.
- **Payments:** Payment identifiers, payment methods, transaction amounts, and order identifiers.
- **Refunds:** Refund identifiers, order identifiers, and refund amounts.

These tables provide information about transactions, customers, products, payments, and refunds.

## Tools and Technologies

- MySQL
- MySQL Workbench
- SQL

## SQL Skills Demonstrated

### 1. Database Exploration
- Selecting the project database
- Listing available tables
- Inspecting table structures using `DESCRIBE`

### 2. Data Validation
- Counting records across multiple tables
- Checking for missing values
- Identifying duplicate order IDs using `GROUP BY` and `HAVING`

### 3. Table Relationships
- Connecting related tables using `LEFT JOIN`
- Combining order and product information
- Examining relationships between orders, payments, and refunds

### 4. Sales Analysis
- Calculating total completed orders
- Calculating total revenue using `SUM()`
- Analyzing monthly revenue trends
- Grouping and sorting results

### 5. Product Performance
- Calculating product quantities sold
- Measuring revenue by product
- Identifying the top 10 products by revenue

### 6. Customer Analysis
- Calculating customer spending
- Counting customer orders
- Identifying the top 10 customers by spending

### 7. Order Trends
- Extracting order dates using `DATE()`
- Counting orders by date
- Identifying the 10 busiest order dates

### 8. Payment and Refund Analysis
- Comparing payment methods by transaction count and total amount
- Calculating the number and total value of recorded refunds

### SQL Functions and Techniques Used

`SELECT`, `WHERE`, `JOIN`, `LEFT JOIN`, `GROUP BY`, `ORDER BY`, `HAVING`, `COUNT()`, `SUM()`, `DATE()`, `DATE_FORMAT()`, `LIMIT`, subqueries, and `UNION ALL`.

## Key Findings

The analysis investigates several aspects of business performance:

- Overall revenue and completed order volume
- Monthly revenue and order trends
- Products generating the highest revenue
- Customers with the highest spending
- Dates with the greatest order activity
- Payment methods with the highest transaction amounts
- Total refund volume and value

The SQL queries and supporting screenshots provide evidence of the analysis. Specific numerical findings should be interpreted using the results returned by the queries.

## Project Files

- **`Eccomerce_Sales_Analysis.sql`** — SQL queries used for database exploration, validation, and business analysis.
- **Screenshots** — Evidence of database structures, data validation, table relationships, and analysis results.

## Conclusion

This project demonstrates how SQL can be used to explore relational databases, validate data, combine information across multiple tables, and answer business questions about sales, customers, products, payments, and refunds.

The analysis provides a foundation for understanding e-commerce performance and identifying areas that may require further investigation.

## Author

Ademola Melody
