SELECT
    product_id,
    product_name,
    category,
    subcategory,
    brand,
    unit_cost,
    list_price
FROM products_raw
WHERE list_price < 0
   OR unit_cost > list_price
ORDER BY product_id;

SELECT
    product_id,
    product_name,
    category,
    subcategory,
    brand,
    unit_cost,
    CASE
        WHEN unit_cost > list_price THEN NULL
        ELSE list_price
    END AS list_price
INTO products_clean
FROM products_raw;

SELECT
    COUNT(*) AS invalid_prices_remaining
FROM products_clean
WHERE unit_cost > list_price;

SELECT
    COUNT(*) AS null_list_price
FROM products_clean
WHERE list_price IS NULL;


-- Order_raw 




SELECT
    order_status,
    COUNT(*) AS records
FROM orders_raw
WHERE quantity < 0
GROUP BY order_status;

select * from orders_raw
where discount_amount < 0;

SELECT
    MIN(quantity) AS minimum_quantity,
    MAX(quantity) AS maximum_quantity,
    SUM(CASE WHEN quantity < 0 THEN 1 ELSE 0 END) AS negative_quantity_rows,
    SUM(CASE WHEN quantity = 0 THEN 1 ELSE 0 END) AS zero_quantity_rows
FROM orders_raw;

SELECT
    SUM(CASE WHEN unit_price < 0 AND order_status = 'Completed' THEN 1 ELSE 0 END) AS negative_price_completed,
    SUM(CASE WHEN unit_price < 0 AND order_status = 'Cancelled' THEN 1 ELSE 0 END) AS negative_price_cancelled,
    SUM(CASE WHEN discount_amount < 0 AND order_status = 'Completed' THEN 1 ELSE 0 END) AS negative_discount_completed,
    SUM(CASE WHEN discount_amount < 0 AND order_status = 'Cancelled' THEN 1 ELSE 0 END) AS negative_discount_cancelled
FROM orders_raw;

SELECT TOP 20
    order_id,
    quantity,
    unit_price,
    discount_amount,
    gross_revenue,
    cogs,
    order_status
FROM orders_raw
WHERE unit_price < 0
   OR discount_amount < 0
ORDER BY order_id;

WITH cleaned_orders AS
(
    SELECT
        order_id,
        order_date,
        customer_id,
        product_id,
        quantity,

        CASE
            WHEN unit_price < 0 THEN NULL
            ELSE unit_price
        END AS unit_price,

        CASE
            WHEN discount_amount < 0 THEN NULL
            ELSE discount_amount
        END AS discount_amount,

        CASE
            WHEN unit_price < 0 THEN NULL
            ELSE quantity * unit_price
        END AS gross_revenue,

        cogs,
        order_status,

        ROW_NUMBER() OVER (
            PARTITION BY order_id, product_id
            ORDER BY order_id
        ) AS rn

    FROM orders_raw
)

SELECT
    order_id,
    order_date,
    customer_id,
    product_id,
    quantity,
    unit_price,
    discount_amount,
    gross_revenue,
    cogs,
    order_status
INTO orders_clean
FROM cleaned_orders
WHERE rn = 1;

SELECT
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS null_unit_price,
    SUM(CASE WHEN discount_amount IS NULL THEN 1 ELSE 0 END) AS null_discount,
    SUM(CASE WHEN gross_revenue IS NULL THEN 1 ELSE 0 END) AS null_gross_revenue
FROM orders_clean;

--returns_raws

SELECT
    return_id,
    order_id,
    product_id,
    customer_id,
    return_date,
    return_reason,
    return_quantity,

    CASE
        WHEN refund_amount < 0 THEN NULL
        ELSE refund_amount
    END AS refund_amount,

    return_status
INTO returns_clean
FROM returns_raw;

SELECT COUNT(*) AS null_refunds
FROM returns_clean
WHERE refund_amount IS NULL;