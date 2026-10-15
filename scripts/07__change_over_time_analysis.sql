
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       change_over_time_analysis.sql
Purpose:      Analyse sales, customer activity, and quantity sold over time
              to identify yearly and monthly trends.
===============================================================================
*/

-- 1. Total sales and purchasing customers by year
SELECT
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers
FROM dbo.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_year;

-- 2. Sales and quantity by year and month
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity
FROM dbo.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;

-- 3. Monthly sales using DATETRUNC
SELECT
    DATETRUNC(MONTH, order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity
FROM dbo.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY order_month;
