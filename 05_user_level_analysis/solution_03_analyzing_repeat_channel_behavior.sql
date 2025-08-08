USE mavenfuzzyfactory;

SELECT
  is_repeat_session,
  utm_source,
  COUNT(*) AS sessions
FROM website_sessions
GROUP BY is_repeat_session, utm_source;