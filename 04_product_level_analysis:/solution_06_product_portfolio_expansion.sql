USE mavenfuzzyfactory;

SELECT
  product_id,
  SUM(price_usd) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC;