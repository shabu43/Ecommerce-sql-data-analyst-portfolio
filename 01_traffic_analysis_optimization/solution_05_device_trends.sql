USE `mavenfuzzyfactory`;

SELECT 
    ws.device_type, 
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    week(ws.created_at) as week
FROM 
    website_sessions ws
LEFT JOIN 
    orders o ON ws.website_session_id = o.website_session_id
WHERE
	ws.created_at BETWEEN '2012-04-15' AND '2012-05-19' AND
    ws.utm_source = 'gsearch' AND
	ws.utm_campaign = 'nonbrand'
GROUP BY 
    WEEK(ws.created_at),YEAR(ws.created_at),ws.device_type;