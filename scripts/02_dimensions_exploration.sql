
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       dimension_exploration.sql
Purpose:      Explore dimension tables and identify the unique values
              available for customers, countries, and products.
===============================================================================
*/

-- 1. Countries where customers live
SELECT DISTINCT country
FROM dbo.dim_customers
ORDER BY country;

-- 2. Customer genders
SELECT DISTINCT gender
FROM dbo.dim_customers
ORDER BY gender;

-- 3. Product categories
SELECT DISTINCT category
FROM dbo.dim_products
ORDER BY category;

-- 4. Product subcategories
SELECT DISTINCT subcategory
FROM dbo.dim_products
ORDER BY subcategory;

-- 5. Product names
SELECT DISTINCT product_name
FROM dbo.dim_products
ORDER BY product_name;
