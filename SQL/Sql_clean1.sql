CREATE DATABASE NovaMart;
GO

USE NovaMart;
GO


select COUNT(*) from customers_raw;
select COUNT(*) from dim_date;
select COUNT(*) from orders_raw;
select COUNT(*) from products_raw;
select COUNT(*) from returns_raw;

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

EXEC sp_help 'customers_raw';

select count(*) as totalrows 
from customers_raw;

select customer_id, count(*) as occurrence
from customers_raw
group by customer_id
having COUNT(*)>1;

SELECT *
FROM customers_raw
WHERE customer_id IS NULL;
SELECT COUNT(*) AS null_customer_id

FROM customers_raw
WHERE customer_id IS NULL;

SELECT *
FROM customers_raw
WHERE customer_id IN (
    SELECT customer_id
    FROM customers_raw
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
    HAVING COUNT(*) > 1
)
ORDER BY customer_id;

SELECT *
FROM customers_raw
WHERE signup_date IS NULL;

SELECT
    MIN(signup_date) AS earliest_signup,
    MAX(signup_date) AS latest_signup
FROM customers_raw;

SELECT DISTINCT
    customer_id,
    customer_name,
    gender,
    signup_date,
    city,
    state,
    region,
    acquisition_channel
INTO customers_clean
FROM customers_raw;

SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS null_customer_name,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN signup_date IS NULL THEN 1 ELSE 0 END) AS null_signup_date,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN acquisition_channel IS NULL THEN 1 ELSE 0 END) AS null_acquisition_channel
FROM customers_clean;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customer_ids,
    COUNT(city) AS non_null_city,
    COUNT(*) - COUNT(city) AS null_city
FROM customers_raw;