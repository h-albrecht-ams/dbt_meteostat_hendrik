WITH sales AS (

    SELECT * 
    from {{ ref('prep_sales') }}

)


SELECT 
    order_year::INT as order_year,
    order_month::INT as order_month,
    category_name,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2) AS avg_revenue_per_order
FROM sales
GROUP BY
    order_year,
    order_month,
    category_name
ORDER BY
    order_year,
    order_month,
    category_name