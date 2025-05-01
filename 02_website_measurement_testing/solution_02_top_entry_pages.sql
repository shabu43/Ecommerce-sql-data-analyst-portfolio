USE `mavenfuzzyfactory`;

DROP TEMPORARY TABLE IF EXISTS first_pv_per_session;

CREATE	TEMPORARY TABLE first_pv_per_session
SELECT website_session_id,
MIN(website_pageview_id) as first_pv 
FROM website_pageviews
WHERE created_at < '2012-06-12'
GROUP BY website_session_id;


SELECT website_pageviews.pageview_url as landing_page_url,
COUNT(DISTINCT first_pv_per_session.website_session_id) as sessions_volume
FROM first_pv_per_session
	LEFT JOIN website_pageviews
	ON first_pv_per_session.first_pv = website_pageviews.website_pageview_id
GROUP BY website_pageviews.pageview_url ORDER BY sessions_volume DESC; 