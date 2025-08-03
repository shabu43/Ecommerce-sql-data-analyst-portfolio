USE mavenfuzzyfactory;

SELECT
  product_id,
  COUNT(CASE WHEN is_refunded = 1 THEN order_item_id END) AS refunds,
  COUNT(order_item_id) AS total,
  ROUND(SUM(is_refunded) / COUNT(order_item_id), 4) AS refund_rate
FROM order_items
GROUP BY product_id;