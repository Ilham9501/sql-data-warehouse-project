
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       13_report_products.sql
Purpose:      Create a product report summarising product sales, revenue,
              customer reach, product lifespan, and performance segments.
===============================================================================
*/

CREATE OR ALTER VIEW dbo.report_products AS

WITH base_query AS (
    SELECT
        f.order_number,
        f.product_key,
        f.order_date,
        f.customer_key,
        f.sales_amount,
        f.quantity,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost
    FROM dbo.fact_sales AS f
    LEFT JOIN dbo.dim_products AS p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
),
product_aggregation AS (
    SELECT
        product_key,
        product_name,
        category,
        subcategory,
        cost,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
        MAX(order_date) AS last_sale_date,
        COUNT(DISTINCT order_number) AS total_orders,
        COUNT(DISTINCT customer_key) AS total_customers,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        ROUND(
            AVG(
                CAST(sales_amount AS FLOAT)
                / NULLIF(quantity, 0)
            ), 1
        ) AS avg_selling_price
    FROM base_query
    GROUP BY
        product_key,
        product_name,
        category,
        subcategory,
        cost
)
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,
    DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
    CASE
        WHEN total_sales > 50000 THEN 'High Performer'
        WHEN total_sales >= 10000 THEN 'Mid Range'
        ELSE 'Low Performer'
    END AS product_segment,
    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,
    CAST(total_sales AS DECIMAL(18, 2))
        / NULLIF(total_orders, 0) AS avg_order_revenue,
    CAST(total_sales AS DECIMAL(18, 2))
        / NULLIF(lifespan, 0) AS avg_monthly_revenue
FROM product_aggregation;
GO

-- Test the product report
SELECT *
FROM dbo.report_products;
