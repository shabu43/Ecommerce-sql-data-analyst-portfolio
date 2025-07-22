USE mavenfuzzyfactory;

-- Monthly sales and revenue trends by product
SELECT
    YEAR(created_at) AS yr,
    MONTH(created_at) AS mo,
    product_id,
    COUNT(order_id) AS orders,
    SUM(price_usd) AS revenue
FROM order_items
GROUP BY yr, mo, product_id
ORDER BY yr, mo, product_id;