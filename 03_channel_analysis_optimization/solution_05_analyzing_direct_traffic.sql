USE mavenfuzzyfactory;

SELECT
  YEAR(created_at) AS yr,
  MONTH(created_at) AS mo,
  COUNT(CASE WHEN utm_source IS NULL THEN website_session_id END) AS direct_sessions,
  COUNT(CASE WHEN utm_campaign = 'brand' THEN website_session_id END) AS brand_sessions,
  COUNT(CASE WHEN utm_campaign = 'nonbrand' THEN website_session_id END) AS nonbrand_sessions
FROM website_sessions
GROUP BY 1, 2
ORDER BY 1, 2;