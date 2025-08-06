USE mavenfuzzyfactory;

-- Sessions breakdown by repeat vs new visitors for 2014
SELECT
    is_repeat_session,
    COUNT(*) AS sessions
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-12-31'
GROUP BY is_repeat_session;