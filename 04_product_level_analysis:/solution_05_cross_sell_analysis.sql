USE mavenfuzzyfactory;

SELECT
  order_id,
  COUNT(DISTINCT product_id) AS product_count
FROM order_items
GROUP BY order_id
HAVING product_count > 1
ORDER BY product_count DESC;