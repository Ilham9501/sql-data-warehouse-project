
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       performance_analysis.sql
Purpose:      Compare yearly product sales against average performance
              and previous-year sales to identify changes in performance.
===============================================================================
*/

WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_key,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM dbo.fact_sales f
    LEFT JOIN dbo.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY
        YEAR(f.order_date),
        p.product_key,
        p.product_name
),
product_performance AS (
    SELECT
        order_year,
        product_key,
        product_name,
        current_sales,
        AVG(current_sales) OVER (
            PARTITION BY product_key
        ) AS average_sales,
        LAG(current_sales) OVER (
            PARTITION BY product_key
            ORDER BY order_year
        ) AS previous_year_sales
    FROM yearly_product_sales
)
SELECT
    order_year,
    product_key,
    product_name,
    current_sales,
    average_sales,
    previous_year_sales,
    current_sales - previous_year_sales AS sales_difference,
    CASE
        WHEN current_sales > average_sales
            THEN 'Above Average'
        WHEN current_sales < average_sales
            THEN 'Below Average'
        ELSE 'Average'
    END AS average_performance
FROM product_performance
ORDER BY product_key, order_year;
