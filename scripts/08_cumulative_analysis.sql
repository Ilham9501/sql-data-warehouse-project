
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       cumulative_analysis.sql
Purpose:      Calculate running sales totals and running average prices
              to understand cumulative business performance over time.
===============================================================================
*/

-- 1. Monthly sales and running total sales
WITH monthly_sales AS (
    SELECT
        DATETRUNC(MONTH, order_date) AS order_month,
        SUM(sales_amount) AS total_sales
    FROM dbo.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date)
)
SELECT
    order_month,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY order_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM monthly_sales
ORDER BY order_month;

-- 2. Monthly average price and running moving average
WITH monthly_prices AS (
    SELECT
        DATETRUNC(MONTH, order_date) AS order_month,
        AVG(CAST(price AS DECIMAL(18,2))) AS average_price
    FROM dbo.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date)
)
SELECT
    order_month,
    average_price,
    AVG(average_price) OVER (
        ORDER BY order_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_average_price
FROM monthly_prices
ORDER BY order_month;
