
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       magnitude_analysis.sql
Purpose:      Measure and compare business metrics across groups,
              including customers by country and sales by product category.
===============================================================================
*/

-- 1. Number of customers by country
SELECT
    country,
    COUNT(*) AS total_customers
FROM dbo.dim_customers
GROUP BY country
ORDER BY total_customers DESC;

-- 2. Number of customers by gender
SELECT
    gender,
    COUNT(*) AS total_customers
FROM dbo.dim_customers
GROUP BY gender
ORDER BY total_customers DESC;

-- 3. Number of products by category
SELECT
    category,
    COUNT(*) AS total_products
FROM dbo.dim_products
GROUP BY category
ORDER BY total_products DESC;

-- 4. Average product cost by category
SELECT
    category,
    AVG(cost) AS average_cost
FROM dbo.dim_products
GROUP BY category
ORDER BY average_cost DESC;

-- 5. Total revenue by product category
SELECT
    p.category,
    SUM(f.sales_amount) AS total_sales
FROM dbo.fact_sales f
LEFT JOIN dbo.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_sales DESC;

-- 6. Total revenue by customer
SELECT
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

-- 7. Quantity sold by country
SELECT
    c.country,
    SUM(f.quantity) AS total_quantity
FROM dbo.fact_sales f
LEFT JOIN dbo.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_quantity DESC;
