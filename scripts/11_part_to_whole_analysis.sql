
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       part_to_whole_analysis.sql
Purpose:      Calculate each product category's contribution to overall
              sales and measure its percentage of total revenue.
===============================================================================
*/

WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM dbo.fact_sales f
    LEFT JOIN dbo.dim_products p
        ON f.product_key = p.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND(
        CAST(total_sales AS FLOAT)
        / NULLIF(SUM(total_sales) OVER (), 0) * 100,
        2
    ) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;

--Remember: SUM(total_sales) OVER () calculates overall sales without grouping the output into a single row. Dividing each category’s sales by overall sales gives its percentage contribution. NULLIF(..., 0) prevents a division-by-zero error.

The percentages across all categories should add up to approximately 100%, allowing for rounding.
