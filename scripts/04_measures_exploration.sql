
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       measures_exploration.sql
Purpose:      Calculate key business measures, including total sales,
              quantity sold, average price, orders, customers, and products.
===============================================================================
*/

-- 1. Total sales
SELECT SUM(sales_amount) AS total_sales
FROM dbo.fact_sales;

-- 2. Total quantity sold
SELECT SUM(quantity) AS total_quantity
FROM dbo.fact_sales;

-- 3. Average product price in sales records
SELECT AVG(price) AS average_price
FROM dbo.fact_sales;

-- 4. Total sales records
SELECT COUNT(*) AS total_sales_records
FROM dbo.fact_sales;

-- 5. Distinct orders
SELECT COUNT(DISTINCT order_number) AS total_orders
FROM dbo.fact_sales;

-- 6. Distinct customers who made purchases
SELECT COUNT(DISTINCT customer_key) AS purchasing_customers
FROM dbo.fact_sales;

-- 7. Total products in the product dimension
SELECT COUNT(*) AS total_products
FROM dbo.dim_products;

-- 8. Total customers in the customer dimension
SELECT COUNT(*) AS total_customers
FROM dbo.dim_customers;

-- 9. Summary of key measures in one result
SELECT
    'Total Sales' AS measure_name,
    SUM(sales_amount) AS measure_value
FROM dbo.fact_sales

UNION ALL

SELECT
    'Total Quantity',
    SUM(quantity)
FROM dbo.fact_sales

UNION ALL

SELECT
    'Average Price',
    AVG(CAST(price AS DECIMAL(18,2)))
FROM dbo.fact_sales

UNION ALL

SELECT
    'Distinct Orders',
    COUNT(DISTINCT order_number)
FROM dbo.fact_sales

UNION ALL

SELECT
    'Purchasing Customers',
    COUNT(DISTINCT customer_key)
FROM dbo.fact_sales

UNION ALL

SELECT
    'Total Products',
    COUNT(*)
FROM dbo.dim_products

UNION ALL

SELECT
    'Total Customers',
    COUNT(*)
FROM dbo.dim_customers;
