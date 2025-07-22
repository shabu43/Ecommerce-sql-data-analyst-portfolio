USE mavenfuzzyfactory;

SELECT
  product_id,
  COUNT(order_item_id) AS units_sold,
  SUM(price_usd) AS revenue,
  CASE WHEN created_at < '2013-02-01' THEN 'Before Launch'
       ELSE 'After Launch' END AS period
FROM order_items
GROUP BY product_id, period
ORDER BY product_id, period;