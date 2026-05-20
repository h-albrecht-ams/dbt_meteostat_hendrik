WITH orders AS (

    SELECT * 
    from {{ ref('staging_orders') }}

),

order_details AS (

    SELECT *
    FROM {{ ref('staging_order_details') }}

),

products AS (

    SELECT *
    FROM {{ ref('staging_products') }}

),

categories AS (

    SELECT *
    FROM {{ ref('staging_categories') }}

),

joined AS (
    SELECT 
        o.order_id,
        o.customer_id,
        o.order_date,
        c.category_name,
        p.product_name,
        od.unit_price,
        od.quantity,
        od.discount,
        od.unit_price * od.quantity * (1 - od.discount) as revenue,
        EXTRACT(YEAR FROM o.order_date) AS order_year,
        EXTRACT(MONTH FROM o.order_date) AS order_month

    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    LEFT JOIN categories c
        ON p.category_id = c.category_id
)

SELECT *
FROM joined