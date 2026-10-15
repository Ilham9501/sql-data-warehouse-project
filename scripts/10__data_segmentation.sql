
/*
===============================================================================
Project:      SQL Data Analytics Project
Script:       data_segmentation.sql
Purpose:      Segment products by cost and customers by spending and
              purchasing lifespan to identify meaningful business groups.
===============================================================================
*/

--A. Segment products by cost
  
SELECT
    product_key,
    product_name,
    cost,
    CASE
        WHEN cost < 100 THEN 'Below 100'
        WHEN cost < 500 THEN '100-499'
        WHEN cost <= 1000 THEN '500-1000'
        ELSE 'Above 1000'
    END AS cost_segment
FROM dbo.dim_products
ORDER BY cost;

--The CASE expression assigns a label based on each product’s cost. The boundaries here do not overlap, so a product costing exactly 500 falls into the 500-1000 segment.

-- B. Segment customers by spending and lifespan
WITH customer_spending AS (
    SELECT
        c.customer_key,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(f.sales_amount) AS total_spending,
        MIN(f.order_date) AS first_order_date,
        MAX(f.order_date) AS last_order_date,
        DATEDIFF(
            MONTH,
            MIN(f.order_date),
            MAX(f.order_date)
        ) AS lifespan_months
    FROM dbo.fact_sales f
    LEFT JOIN dbo.dim_customers c
        ON f.customer_key = c.customer_key
    WHERE f.order_date IS NOT NULL
    GROUP BY
        c.customer_key,
        c.first_name,
        c.last_name
)
SELECT
    customer_key,
    customer_name,
    total_spending,
    first_order_date,
    last_order_date,
    lifespan_months,
    CASE
        WHEN lifespan_months >= 12
             AND total_spending > 5000
            THEN 'VIP'
        WHEN lifespan_months >= 12
             AND total_spending <= 5000
            THEN 'Regular'
        ELSE 'New'
    END AS customer_segment
FROM customer_spending
ORDER BY total_spending DESC;

--Remember: A CTE first calculates each customer’s total spending and lifespan. The CASE expression then uses those results to classify the customer as VIP, Regular or New.
