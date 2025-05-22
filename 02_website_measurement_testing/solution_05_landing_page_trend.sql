
USE mavenfuzzyfactory;

-- First find when the lander-1 page launched
CREATE TEMPORARY TABLE sessions_w_min_pv_id_view_count
SELECT
    website_sessions.website_session_id,
    MIN(website_pageviews.website_pageview_id) as first_pageview_id,
    COUNT(website_pageviews.website_pageview_id) as count_pageviews
FROM website_sessions
	LEFT JOIN website_pageviews
    ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE
     website_sessions.utm_source = 'gsearch'
    AND website_sessions.utm_campaign = 'nonbrand'
    AND website_sessions.created_at BETWEEN '2012-06-01' and '2012-08-31' -- between key, separate cond possible
GROUP BY 
	website_sessions.website_session_id; -- for each session id(each group) #of pageview_id and min for first.

