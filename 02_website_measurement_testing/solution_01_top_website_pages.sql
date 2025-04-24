USE `mavenfuzzyfactory`;
SELECT 
    COUNT(DISTINCT o.order_id) as orders, COUNT(DISTINCT ws.website_session_id) as sessions,COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) AS conversion_rate
FROM 
    website_sessions ws
LEFT JOIN 
    orders o ON ws.website_session_id = o.website_session_id
WHERE 
    ws.utm_source = 'gsearch'
    AND ws.utm_campaign = 'nonbrand';