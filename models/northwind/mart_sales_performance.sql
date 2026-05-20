WITH sales AS (

    SELECT * 
    from {{ ref('prep_sales') }}

)


SELECT 
    order_year,
    order_month,
    category_name,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(revenue) / COUNT(DISTINCT order_id) AS avg_revenue_per_order
FROM sales
GROUP BY
    order_year,
    order_month,
    category_name
ORDER BY
    order_year,
    order_month,
    category_name