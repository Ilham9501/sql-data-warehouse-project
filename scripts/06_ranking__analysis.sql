
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       ranking_analysis.sql
Purpose:      Rank products and customers by sales performance and order
              activity to identify top and bottom performers.
===============================================================================
*/

-- 1. Top 5 products by revenue
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_sales
FROM dbo.fact_sales f
LEFT JOIN dbo.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_key, p.product_name
ORDER BY total_sales DESC;

-- 2. Bottom 5 products by revenue
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_sales
FROM dbo.fact_sales f
LEFT JOIN dbo.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_key, p.product_name
ORDER BY total_sales ASC;

-- 3. Rank all products by revenue
SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_sales,
    ROW_NUMBER() OVER (
        ORDER BY SUM(f.sales_amount) DESC
    ) AS sales_rank
FROM dbo.fact_sales f
LEFT JOIN dbo.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_key, p.product_name;

-- 4. Top 10 customers by revenue
SELECT TOP 10
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(f.sales_amount) AS total_sales
FROM dbo.fact_sales f
LEFT JOIN dbo.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_sales DESC;

-- 5. Three customers with the fewest distinct orders
SELECT TOP 3
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM dbo.fact_sales f
LEFT JOIN dbo.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ASC;
