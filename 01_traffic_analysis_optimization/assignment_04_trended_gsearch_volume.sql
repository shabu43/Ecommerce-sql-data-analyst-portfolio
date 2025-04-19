USE `mavenfuzzyfactory`;

SELECT 
    YEAR(ws.created_at) AS year,
    WEEK(ws.created_at) AS week,
    COUNT(DISTINCT ws.website_session_id) AS gsearch_sessions
FROM 
    website_sessions ws
WHERE 
    ws.utm_source = 'gsearch'
    AND ws.utm_campaign = 'nonbrand'
GROUP BY 
    YEAR(ws.created_at), WEEK(ws.created_at);