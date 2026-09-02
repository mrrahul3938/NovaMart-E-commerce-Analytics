-- top 10 customer_id 

SELECT TOP 10
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(gross_revenue) AS total_revenue,
    SUM(gross_revenue - cogs) AS gross_profit
FROM orders_clean
WHERE order_status = 'Completed'
GROUP BY customer_id
ORDER BY total_revenue DESC;


-- 11.2: Top 10 Products_id by Revenue and Profit

SELECT TOP 10
    product_id,
    SUM(quantity) AS total_quantity,
    SUM(gross_revenue) AS total_revenue,
    SUM(cogs) AS total_cogs,
    SUM(gross_revenue - cogs) AS gross_profit

FROM orders_clean
WHERE order_status = 'Completed'
GROUP BY product_id
ORDER BY total_revenue DESC;


-- 11.3: Monthly Revenue Analysis

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(gross_revenue) AS total_revenue

FROM orders_clean

WHERE order_status = 'Completed'

GROUP BY
    YEAR(order_date),
    MONTH(order_date)

ORDER BY
    order_year,
    order_month;



-- 4: Customer Distribution by city

SELECT
    city,
    COUNT(*) AS customer_count
FROM customers_clean
GROUP BY city
ORDER BY customer_count DESC;

-- 5: Customer Distribution by Region

SELECT
    region,
    COUNT(*) AS customers_count
FROM customers_clean
GROUP BY region
ORDER BY customers_count DESC;


-- 6: Product Return Analysis

SELECT TOP 10
    product_id,
    COUNT(*) AS return_count,
    SUM(return_quantity) AS returned_quantity

FROM returns_clean

GROUP BY product_id

ORDER BY return_count DESC;

-- 7: Product Ranking
-- Rank products based on their list price.

SELECT
    product_id,
    product_name,
    list_price,

    -- Rank products from highest to lowest price
    RANK() OVER (
        ORDER BY list_price DESC
    ) AS price_rank

FROM products_clean

ORDER BY price_rank;

-- 8: Customer Signup Year Analysis

SELECT
    YEAR(signup_date) AS signup_year,
    COUNT(*) AS customer_count
FROM customers_clean
GROUP BY YEAR(signup_date)
ORDER BY signup_year;

--9: Products priced above the average product price

SELECT
    product_id,
    product_name,
    list_price
FROM products_clean
WHERE list_price > (
    SELECT AVG(list_price)
    FROM products_clean
)
ORDER BY list_price DESC;

--10: Find cities with a large customer base

SELECT
    city,
    COUNT(*) AS customer_count
FROM customers_clean
GROUP BY city
HAVING COUNT(*) > 500
ORDER BY customer_count DESC;

--11: Top 10 most expensive products

SELECT TOP 10
    product_id,
    product_name,
    list_price
FROM products_clean
ORDER BY list_price DESC;

--12: Top 10 cheapest products

SELECT TOP 10
    product_id,
    product_name,
    list_price
FROM products_clean
WHERE list_price is not null
ORDER BY list_price;

--13: Identify customers where city information is missing

SELECT 
    COUNT(*) AS missing_city_customers
FROM customers_clean
WHERE city IS NULL;

--14 Check products where list price is missing

SELECT
    product_id,
    product_name,
    list_price
FROM products_clean
WHERE list_price IS NULL;

--15 Categorize products based on their list price

SELECT
    product_id,
    product_name,
    list_price,

    CASE
        WHEN list_price >= 10000 THEN 'High Price'
        WHEN list_price >= 5000 THEN 'Medium Price'
        ELSE 'Low Price'
    END AS price_category

FROM products_clean;

