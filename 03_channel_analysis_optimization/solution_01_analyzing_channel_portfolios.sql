USE mavenfuzzyfactory;

-- Weekly sessions for gsearch vs bsearch (nonbrand campaigns)
SELECT
    YEAR(created_at) AS yr,
    WEEK(created_at) AS wk,
    utm_source,
    COUNT(*) AS sessions
FROM website_sessions
WHERE utm_campaign = 'nonbrand'
  AND utm_source IN ('gsearch', 'bsearch')
  AND created_at >= '2012-08-22'
GROUP BY yr, wk, utm_source
ORDER BY yr, wk, utm_source;