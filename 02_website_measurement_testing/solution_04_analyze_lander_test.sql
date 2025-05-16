

-- STEP 0: find out when the new page /lander launched
-- STEP 1: finding the first website_pageview_id for relevant sessions
-- STEP 2: identifying the landing page of each session
-- STEP 3: counting pageviews for each session, to identify "bounces"
-- STEP 4: summarizing total sessions and bounced sessions, by LP

USE mavenfuzzyfactory;

-- First find when the lander-1 page launched
SELECT
    MIN(created_at) AS first_created_at,
    MIN(website_pageview_id) as first_pageview_id
FROM website_pageviews
WHERE pageview_url = '/lander-1'
    and created_at IS NOT NULL;

-- first_created_at = '2012-06-19 00:35:54'
-- first_pageview_id = 23504
-- Clean up any existing temp tables
DROP TEMPORARY TABLE IF EXISTS first_test_pageviews;
DROP TEMPORARY TABLE IF EXISTS nonbrand_test_sessions_w_landing_page;
DROP TEMPORARY TABLE IF EXISTS nonbrand_test_bounced_sessions;

-- Create temporary table with first pageviews for test sessions
CREATE TEMPORARY TABLE first_test_pageviews
SELECT
    website_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS min_pageview_id
from website_pageviews
INNER JOIN website_sessions
    on website_sessions.website_session_id = website_pageviews.website_session_id
    AND website_sessions.created_at < '2012-07-28' -- prescribed by the assignment
    AND website_pageviews.website_pageview_id > 23504 -- the min_pageview_id we found for the test
    AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY
    website_pageviews.website_session_id;

-- Bring in the landing page for each session (restricted to home or lander-1)
CREATE TEMPORARY TABLE nonbrand_test_sessions_w_landing_page
SELECT
    first_test_pageviews.website_session_id,
    website_pageviews.pageview_url as landing_page
FROM first_test_pageviews
LEFT JOIN website_pageviews
    ON website_pageviews.website_pageview_id = first_test_pageviews.min_pageview_id
WHERE website_pageviews.pageview_url in ('/home','/lander-1');

-- SELECT * FROM nonbrand_test_sessions_w_landing_page; -- QA only

-- Create table with count of pageviews per session, limited to bounced sessions
CREATE TEMPORARY TABLE nonbrand_test_bounced_sessions
SELECT
    nonbrand_test_sessions_w_landing_page.website_session_id,
    nonbrand_test_sessions_w_landing_page.landing_page,
    COUNT(website_pageviews.website_pageview_id) as count_of_pages_viewed
FROM nonbrand_test_sessions_w_landing_page
LEFT join website_pageviews
    ON website_pageviews.website_session_id = nonbrand_test_sessions_w_landing_page.website_session_id
GROUP BY
    nonbrand_test_sessions_w_landing_page.website_session_id,
    nonbrand_test_sessions_w_landing_page.landing_page
HAVING
    COUNT(website_pageviews.website_pageview_id) = 1;

-- SELECT * FROM nonbrand_test_bounced_sessions -- QA only

-- Final output comparing bounce rates
SELECT
    nonbrand_test_sessions_w_landing_page.landing_page,
    COUNT(DISTINCT nonbrand_test_sessions_w_landing_page.website_session_id) AS sessions,
    COUNT(DISTINCT nonbrand_test_bounced_sessions.website_session_id) AS bounced_sessions,
    COUNT(DISTINCT nonbrand_test_bounced_sessions.website_session_id)/count(DISTINCT nonbrand_test_sessions_w_landing_page.website_session_id) AS bounce_rate
from nonbrand_test_sessions_w_landing_page
LEFT JOIN nonbrand_test_bounced_sessions
    on nonbrand_test_sessions_w_landing_page.website_session_id = nonbrand_test_bounced_sessions.website_session_id
GROUP BY
    nonbrand_test_sessions_w_landing_page.landing_page;