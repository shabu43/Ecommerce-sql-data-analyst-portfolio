USE mavenfuzzyfactory;

SELECT
  is_repeat_session,
  COUNT(DISTINCT ws.website_session_id) AS sessions,
  COUNT(DISTINCT o.order_id) AS orders,
  ROUND(COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id), 4) AS conversion_rate
FROM website_sessions ws
LEFT JOIN orders o ON ws.website_session_id = o.website_session_id
GROUP BY is_repeat_session;