USE mavenfuzzyfactory;

SELECT
  utm_source,
  device_type,
  COUNT(*) AS sessions,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY utm_source), 4) AS pct_device
FROM website_sessions
WHERE utm_campaign = 'nonbrand'
  AND utm_source IN ('gsearch', 'bsearch')
  AND created_at >= '2012-08-22'
GROUP BY utm_source, device_type;