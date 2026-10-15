
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       data_exploration.sql
Purpose:      Explore the database structure, identify available tables,
              and inspect column names and data types.
===============================================================================
*/

-- 1. View all tables
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- 2. View all columns and their data types
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- 3. View columns in the customer dimension
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

-- 4. Preview the sales fact table
SELECT TOP 10 *
FROM dbo.fact_sales; 
