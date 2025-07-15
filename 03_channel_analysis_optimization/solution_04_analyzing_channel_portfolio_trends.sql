USE mavenfuzzyfactory;

SELECT
  YEAR(created_at) AS yr,
  WEEK(created_at) AS wk,
  utm_source,
  device_type,
  COUNT(*) AS sessions
FROM website_sessions
WHERE utm_campaign = 'nonbrand'
  AND utm_source IN ('gsearch', 'bsearch')
  AND created_at >= '2012-11-04'
GROUP BY 1, 2, 3, 4;