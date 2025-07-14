USE mavenfuzzyfactory;

SELECT
  utm_source,
  device_type,
  COUNT(DISTINCT o.order_id) AS orders,
  COUNT(DISTINCT ws.website_session_id) AS sessions,
  ROUND(COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id), 4) AS conversion_rate
FROM website_sessions ws
LEFT JOIN orders o ON ws.website_session_id = o.website_session_id
WHERE utm_campaign = 'nonbrand'
  AND utm_source IN ('gsearch', 'bsearch')
  AND ws.created_at BETWEEN '2012-08-22' AND '2012-09-18'
GROUP BY 1, 2;