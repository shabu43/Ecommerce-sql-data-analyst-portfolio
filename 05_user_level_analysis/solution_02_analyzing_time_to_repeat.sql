USE mavenfuzzyfactory;

SELECT
  user_id,
  DATEDIFF(MIN(created_at), MAX(created_at)) AS days_between
FROM website_sessions
WHERE is_repeat_session = 1
GROUP BY user_id
HAVING COUNT(*) >= 2;