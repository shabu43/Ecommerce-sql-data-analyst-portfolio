USE `mavenfuzzyfactory`;

SELECT 
    ws.device_type, 
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) AS conversion_rate
FROM 
    website_sessions ws
LEFT JOIN 
    orders o ON ws.website_session_id = o.website_session_id
GROUP BY 
    ws.device_type;