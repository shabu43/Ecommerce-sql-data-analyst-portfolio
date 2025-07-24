USE mavenfuzzyfactory;

-- Simple funnel: product page > cart > shipping > billing > thank you
SELECT
  pageview_url,
  COUNT(DISTINCT website_session_id) AS product_page_sessions
FROM website_pageviews
WHERE pageview_url IN ('/the-original-mr-fuzzy', '/the-forever-love-bear')
GROUP BY pageview_url;