
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       date_range_exploration.sql
Purpose:      Determine the date ranges of sales and customer birthdates.
              Assess the time period covered by the available data.
===============================================================================
*/

-- 1. Sales date range
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years
FROM dbo.fact_sales;

-- 2. Customer birthdate range
SELECT
    MIN(birthdate) AS earliest_birthdate,
    MAX(birthdate) AS latest_birthdate
FROM dbo.dim_customers;

-- 3. Customer age range
SELECT
    MIN(DATEDIFF(YEAR, birthdate, GETDATE())) AS youngest_age,
    MAX(DATEDIFF(YEAR, birthdate, GETDATE())) AS oldest_age
FROM dbo.dim_customers
WHERE birthdate IS NOT NULL;
