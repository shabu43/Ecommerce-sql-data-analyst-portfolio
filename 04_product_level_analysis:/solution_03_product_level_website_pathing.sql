USE mavenfuzzyfactory;

SELECT
  pageview_url,
  COUNT(DISTINCT website_session_id) AS views
FROM website_pageviews
WHERE pageview_url IN ('/the-original-mr-fuzzy','/the-forever-love-bear')
GROUP BY pageview_url;